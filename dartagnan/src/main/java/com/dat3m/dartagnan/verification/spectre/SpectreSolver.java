package com.dat3m.dartagnan.verification.spectre;

import com.dat3m.dartagnan.configuration.Property;
import com.dat3m.dartagnan.encoding.*;
import com.dat3m.dartagnan.program.Program;
import com.dat3m.dartagnan.program.Thread;
import com.dat3m.dartagnan.program.analysis.BranchEquivalence;
import com.dat3m.dartagnan.program.analysis.Dependency;
import com.dat3m.dartagnan.program.analysis.ExecutionAnalysis;
import com.dat3m.dartagnan.program.analysis.ThreadSymmetry;
import com.dat3m.dartagnan.program.analysis.alias.AliasAnalysis;
import com.dat3m.dartagnan.program.event.Event;
import com.dat3m.dartagnan.utils.Result;
import com.dat3m.dartagnan.verification.Context;
import com.dat3m.dartagnan.verification.VerificationTask;
import com.dat3m.dartagnan.verification.solving.ModelChecker;
import com.dat3m.dartagnan.wmm.Wmm;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.sosy_lab.common.configuration.Configuration;
import org.sosy_lab.common.configuration.InvalidConfigurationException;
import org.sosy_lab.java_smt.api.*;

import static com.dat3m.dartagnan.utils.Result.FAIL;
import static com.dat3m.dartagnan.utils.Result.PASS;
import static java.util.Collections.singletonList;

public class SpectreSolver extends ModelChecker {

    private static final Logger logger = LogManager.getLogger(SpectreSolver.class);

    private final SolverContext ctx;
    private final ProverEnvironment prover;
    private final VerificationTask task;

    private SpectreSolver(SolverContext c, ProverEnvironment p, VerificationTask t) {
        ctx = c;
        prover = p;
        task = t;
    }

    public static SpectreSolver run(SolverContext ctx, ProverEnvironment prover, VerificationTask task)
            throws InterruptedException, SolverException, InvalidConfigurationException {
        SpectreSolver s = new SpectreSolver(ctx, prover, task);
        s.run();
        return s;
    }

    private void run() throws InterruptedException, SolverException, InvalidConfigurationException {
        final Wmm memoryModel = task.getMemoryModel();
        final Context analysisContext = Context.create();
        final Configuration config = task.getConfig();

        memoryModel.configureAll(config);
        preprocessProgram(task, config);
        preprocessMemoryModel(task);
        performStaticProgramAnalyses(task, analysisContext, config);
        performStaticWmmAnalyses(task, analysisContext, config);

        context = EncodingContext.of(task, analysisContext, ctx.getFormulaManager());
        ProgramEncoder programEncoder = ProgramEncoder.withContext(context);
        PropertyEncoder propertyEncoder = PropertyEncoder.withContext(context);
        WmmEncoder wmmEncoder = WmmEncoder.withContext(context);
        SymmetryEncoder symmetryEncoder = SymmetryEncoder.withContext(context);

        logger.info("Starting encoding using " + ctx.getVersion());
        prover.addConstraint(programEncoder.encodeFullProgram());
        prover.addConstraint(wmmEncoder.encodeFullMemoryModel());
        // For validation this contains information.
        // For verification graph.encode() just returns ctx.mkTrue()
        prover.addConstraint(task.getWitness().encode(context));
        prover.addConstraint(symmetryEncoder.encodeFullSymmetryBreaking());

        BooleanFormulaManager bmgr = ctx.getFormulaManager().getBooleanFormulaManager();
        BooleanFormula assumptionLiteral = bmgr.makeVariable("DAT3M_spec_assumption");
        BooleanFormula propertyEncoding = propertyEncoder.encodeProperties(task.getProperty());
        BooleanFormula assumedSpec = bmgr.implication(assumptionLiteral, propertyEncoding);
        prover.addConstraint(assumedSpec);

        logger.info("Starting first solver.check()");
        if (prover.isUnsatWithAssumptions(singletonList(assumptionLiteral))) {
            prover.addConstraint(propertyEncoder.encodeBoundEventExec());
            logger.info("Starting second solver.check()");
            res = prover.isUnsat() ? PASS : Result.UNKNOWN;
        } else {
            res = FAIL;
            saveFlaggedPairsOutput(memoryModel, wmmEncoder, prover, context, task.getProgram());
        }

        if (logger.isDebugEnabled()) {
            String smtStatistics = "\n ===== SMT Statistics ===== \n";
            for (String key : prover.getStatistics().keySet()) {
                smtStatistics += String.format("\t%s -> %s\n", key, prover.getStatistics().get(key));
            }
            logger.debug(smtStatistics);
        }

        // For Safety specs, we have SAT=FAIL, but for reachability specs, we have SAT=PASS
        res = Property.getCombinedType(task.getProperty(), task) == Property.Type.SAFETY ? res : res.invert();
        logger.info("Verification finished with result " + res);
    }

    public static void preprocessProgram(VerificationTask task, Configuration config) throws InvalidConfigurationException {
        final Program program = task.getProgram();
        ProcessingManager.fromConfig(config).run(program);
        // This is used to distinguish between Litmus tests (whose assertions are defined differently)
        // and C tests.
        if(program.getFormat() != Program.SourceLanguage.LITMUS) {
            computeSpecificationFromProgramAssertions(program);
        }
    }

    public static void performStaticProgramAnalyses(VerificationTask task, Context analysisContext, Configuration config) throws InvalidConfigurationException {
        Program program = task.getProgram();
        analysisContext.register(BranchEquivalence.class, BranchEquivalence.fromConfig(program, config));
        analysisContext.register(ExecutionAnalysis.class, ExecutionAnalysis.fromConfig(program, analysisContext, config));
        analysisContext.register(Dependency.class, Dependency.fromConfig(program, analysisContext, config));
        analysisContext.register(AliasAnalysis.class, SpectreAliasAnalysis.fromConfig(program, config));
        analysisContext.register(ThreadSymmetry.class, ThreadSymmetry.fromConfig(program, config));
        for(Thread thread : program.getThreads()) {
            for(Event e : thread.getEvents()) {
                // Some events perform static analyses by themselves (e.g. Svcomp's EndAtomic)
                // which may rely on previous "global" analyses
                e.runLocalAnalysis(program, analysisContext);
            }
        }
    }

}