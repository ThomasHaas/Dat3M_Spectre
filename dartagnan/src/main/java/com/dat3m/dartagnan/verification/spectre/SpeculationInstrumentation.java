package com.dat3m.dartagnan.verification.spectre;

import com.dat3m.dartagnan.configuration.OptionNames;
import com.dat3m.dartagnan.expression.Expression;
import com.dat3m.dartagnan.expression.ExpressionVisitor;
import com.dat3m.dartagnan.expression.processing.ExprTransformer;
import com.dat3m.dartagnan.program.Function;
import com.dat3m.dartagnan.program.IRHelper;
import com.dat3m.dartagnan.program.Program;
import com.dat3m.dartagnan.program.Register;
import com.dat3m.dartagnan.program.event.*;
import com.dat3m.dartagnan.program.event.core.Assert;
import com.dat3m.dartagnan.program.event.core.CondJump;
import com.dat3m.dartagnan.program.event.core.Label;
import com.dat3m.dartagnan.program.event.core.annotations.CodeAnnotation;
import com.dat3m.dartagnan.program.event.functions.AbortIf;
import com.dat3m.dartagnan.program.event.functions.Return;
import com.dat3m.dartagnan.program.processing.ProgramProcessor;
import org.sosy_lab.common.configuration.Configuration;
import org.sosy_lab.common.configuration.InvalidConfigurationException;
import org.sosy_lab.common.configuration.Option;
import org.sosy_lab.common.configuration.Options;

import java.util.*;

@Options
public class SpeculationInstrumentation implements ProgramProcessor {

    @Option(name = OptionNames.SPECULATION_WINDOW,
            description = "The maximal speculation depth permitted.")
    private int speculationWindow = 5;

    private SpeculationInstrumentation(Configuration config) throws InvalidConfigurationException {
        config.inject(this);
    }

    public static SpeculationInstrumentation fromConfig(Configuration config) throws InvalidConfigurationException {
        return new SpeculationInstrumentation(config);
    }

    @Override
    public void run(Program program) {
        program.getFunctions().forEach(this::run);
    }

    private void run(Function function) {
        int specCtr = 0;
        // We speculate only on jumps with non-constant conditions
        final List<CondJump> speculatibleJumps = function.getEvents(CondJump.class).stream()
                .filter(jump -> !jump.getGuard().getRegs().isEmpty())
                .toList();
        final String specStartMarker = String.format("### SPEC_START(%s)", speculationWindow);
        final String specEndMarker = "### SPEC_END";

        final RegisterReplacer replacer = new RegisterReplacer();
        for (CondJump jump : speculatibleJumps) {
            // Speculate true branch
            final Map<Event, Event> copyMap = new HashMap<>();
            final Label specEndTrue = EventFactory.newLabel("__spec_end_true#" + specCtr);
            final List<Event> specTrue = computeSpeculationEvents(jump.getLabel(), speculationWindow, specEndTrue, copyMap, replacer); ;
            specTrue.stream().filter(EventUser.class::isInstance).map(EventUser.class::cast)
                    .forEach(e -> e.updateReferences(copyMap));

            // Speculate false branch
            copyMap.clear();
            final Label specEndFalse = EventFactory.newLabel("__spec_end_false#" + specCtr);
            final List<Event> specFalse = computeSpeculationEvents(jump.getSuccessor(), speculationWindow, specEndFalse, copyMap, replacer);
            specFalse.stream().filter(EventUser.class::isInstance).map(EventUser.class::cast)
                    .forEach(e -> e.updateReferences(copyMap));


            // Insert only after copying both branches
            jump.insertAfter(EventFactory.newStringAnnotation(specEndMarker));
            jump.insertAfter(specEndTrue);
            jump.insertAfter(specTrue);
            jump.insertAfter(EventFactory.newStringAnnotation(specStartMarker));

            jump.getLabel().insertAfter(EventFactory.newStringAnnotation(specEndMarker));
            jump.getLabel().insertAfter(specEndFalse);
            jump.getLabel().insertAfter(specFalse);
            jump.getLabel().insertAfter(EventFactory.newStringAnnotation(specStartMarker));

            specCtr++;
        }
    }

    private List<Event> computeSpeculationEvents(Event cur, int speculationWindow, Label speculationEnd,
                                                 Map<Event, Event> copyMap, RegisterReplacer replacer) {
        final List<Event> specEvents = new ArrayList<>(speculationWindow);
        final Event start = cur;
        replacer.push();
        while (speculationWindow > 0) {
            if (cur == null || cur instanceof Return || (cur instanceof AbortIf abort && IRHelper.isAlwaysBranching(abort))) {
                // Program ends, we cannot speculate further
                break;
            }

            if (cur instanceof CodeAnnotation || cur instanceof Assert || (cur instanceof Label && cur != start)) {
                cur = cur.getSuccessor();
                continue;
            } else if (cur instanceof CondJump jump && jump.isGoto()) {
                cur = jump.getLabel();
                continue;
            }
            // -------------- Actual copy creation --------------
            final Event specCopy = cur.getCopy();
            replacer.update(specCopy, cur.getFunction());
            specCopy.addTags(Tag.SPECULATED);
            specEvents.add(specCopy);
            copyMap.put(cur, specCopy);
            speculationWindow--;

            if (cur instanceof CondJump jump) {
                // Nested speculation
                specEvents.addAll(computeSpeculationEvents(jump.getSuccessor(), speculationWindow, speculationEnd, copyMap, replacer));
                specEvents.addAll(computeSpeculationEvents(jump.getLabel(), speculationWindow, speculationEnd, copyMap, replacer));
                return specEvents;
            }

            cur = cur.getSuccessor();
        }
        replacer.pop();
        specEvents.add(EventFactory.newGoto(speculationEnd));
        return specEvents;
    }

    // We replace registers in speculated parts to avoid accidentally overwriting non-speculated
    // registers, i.e., to get roll-back semantics.
    private static class RegisterReplacer {
        private final Deque<Integer> backtrackPoints = new ArrayDeque<>();
        private final Deque<Register> trace = new ArrayDeque<>();
        private final Map<Register, Register> registerMap = new HashMap<>();

        private final ExpressionVisitor<Expression> regReplacer = new ExprTransformer() {
            @Override
            public Expression visitRegister(Register reg) {
                return registerMap.getOrDefault(reg, reg);
            }
        };

        private void update(Event e, Function func) {
            if (e instanceof RegReader reader) {
                reader.transformExpressions(regReplacer);
            }

            if (e instanceof RegWriter writer) {
                final Register oldReg = writer.getResultRegister();
                if (!registerMap.containsKey(oldReg)) {
                    final String specRegName = oldReg.getName() + "#SPEC";
                    final Register newReg = func.getOrNewRegister(specRegName, oldReg.getType());
                    trace.push(oldReg);
                    registerMap.put(oldReg, newReg);
                }
                writer.setResultRegister(registerMap.get(oldReg));
            }
        }

        private void push() {
            backtrackPoints.add(trace.size());
        }

        private void pop() {
            final int backtrackTo = backtrackPoints.pop();
            while (trace.size() > backtrackTo) {
                registerMap.remove(trace.pop());
            }
        }
    }
}
