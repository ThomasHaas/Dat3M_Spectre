package com.dat3m.dartagnan.verification.spectre;

import com.dat3m.dartagnan.expression.Expression;
import com.dat3m.dartagnan.expression.ExpressionFactory;
import com.dat3m.dartagnan.expression.type.FunctionType;
import com.dat3m.dartagnan.expression.type.TypeFactory;
import com.dat3m.dartagnan.program.Function;
import com.dat3m.dartagnan.program.Program;
import com.dat3m.dartagnan.program.Thread;
import com.dat3m.dartagnan.program.event.Event;
import com.dat3m.dartagnan.program.event.EventFactory;
import com.dat3m.dartagnan.program.processing.ProgramProcessor;

import java.util.List;
import java.util.stream.Stream;

public class AllocateAbstractInitEvent implements ProgramProcessor {

    @Override
    public void run(Program program) {
        final TypeFactory types = TypeFactory.getInstance();
        final FunctionType initThreadType = types.getFunctionType(types.getVoidType(), List.of());
        int nextThreadId = Stream.concat(program.getThreads().stream(), program.getFunctions().stream())
                .mapToInt(Function::getId).max().getAsInt() + 1;

        final Expression zero = ExpressionFactory.getInstance().makeZero(types.getArchType());
        final Event init = new AbstractInit(zero, zero);
        final Thread thread = new Thread("AbsInit" + nextThreadId, initThreadType, List.of(), nextThreadId,
                EventFactory.newThreadStart(null));
        thread.append(init);
        program.addThread(thread);
        thread.setProgram(program);
        thread.append(EventFactory.newLabel("END_OF_T" + thread.getId()));
    }
}
