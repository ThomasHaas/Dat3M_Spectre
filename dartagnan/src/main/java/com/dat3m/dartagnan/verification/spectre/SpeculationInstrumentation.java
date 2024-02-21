package com.dat3m.dartagnan.verification.spectre;

import com.dat3m.dartagnan.configuration.OptionNames;
import com.dat3m.dartagnan.program.Function;
import com.dat3m.dartagnan.program.Program;
import com.dat3m.dartagnan.program.event.Event;
import com.dat3m.dartagnan.program.event.EventFactory;
import com.dat3m.dartagnan.program.event.EventUser;
import com.dat3m.dartagnan.program.event.Tag;
import com.dat3m.dartagnan.program.event.core.Assert;
import com.dat3m.dartagnan.program.event.core.CondJump;
import com.dat3m.dartagnan.program.event.core.Label;
import com.dat3m.dartagnan.program.event.core.annotations.CodeAnnotation;
import com.dat3m.dartagnan.program.event.functions.Return;
import com.dat3m.dartagnan.program.processing.ProgramProcessor;
import org.sosy_lab.common.configuration.Configuration;
import org.sosy_lab.common.configuration.InvalidConfigurationException;
import org.sosy_lab.common.configuration.Option;
import org.sosy_lab.common.configuration.Options;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Options
public class SpeculationInstrumentation implements ProgramProcessor {

    @Option(name = OptionNames.SPECULATION_WINDOW,
            description = "The maximal speculation depth permitted.")
    private int speculationWindow = 2;

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
        final List<CondJump> speculatibleJumps = function.getEvents(CondJump.class).stream()
                .filter(jump -> !jump.getGuard().getRegs().isEmpty())
                .toList();
        final String specStartMarker = String.format("### SPEC_START(%s)", speculationWindow);
        final String specEndMarker = "### SPEC_END";

        for (CondJump jump : speculatibleJumps) {
            // Speculate true branch
            final Map<Event, Event> copyMap = new HashMap<>();
            final Label specEndTrue = EventFactory.newLabel("__spec_end_true#" + specCtr);
            final List<Event> specTrue = computeSpeculationEvents(jump.getLabel(), speculationWindow, copyMap, specEndTrue);
            specTrue.stream().filter(EventUser.class::isInstance).map(EventUser.class::cast)
                    .forEach(e -> e.updateReferences(copyMap));

            // Speculate false branch
            copyMap.clear();
            final Label specEndFalse = EventFactory.newLabel("__spec_end_false#" + specCtr);
            final List<Event> specFalse = computeSpeculationEvents(jump.getSuccessor(), speculationWindow, copyMap, specEndFalse);
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

    private List<Event> computeSpeculationEvents(Event cur, int speculationWindow,
                                                 Map<Event, Event> copyMap,
                                                 Label speculationEnd) {
        final List<Event> specEvents = new ArrayList<>(speculationWindow);
        while (speculationWindow > 0 && cur != null && !(cur instanceof Return)) {
            if (cur instanceof CodeAnnotation || cur instanceof Assert) {
                cur = cur.getSuccessor();
                continue;
            }
            if (!(cur instanceof Label)) {
                speculationWindow--;
            }
            final Event specCopy = cur.getCopy();
            specEvents.add(specCopy);
            copyMap.put(cur, specCopy);
            specCopy.addTags(Tag.SPECULATED);
            if (cur instanceof CondJump jump && !jump.isGoto()) {
                specEvents.addAll(computeSpeculationEvents(jump.getSuccessor(), speculationWindow, copyMap, speculationEnd));
                specEvents.addAll(computeSpeculationEvents(jump.getLabel(), speculationWindow, copyMap, speculationEnd));
                return specEvents;
            } else if (cur instanceof CondJump jump && jump.isGoto()) {
                speculationWindow++; // We skip simple goto's in the speculation window counter
                cur = jump.getLabel();
            } else {
                cur = cur.getSuccessor();
            }
        }
        specEvents.add(EventFactory.newGoto(speculationEnd));
        return specEvents;
    }
}
