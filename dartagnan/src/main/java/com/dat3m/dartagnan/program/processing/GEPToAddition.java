package com.dat3m.dartagnan.program.processing;

import com.dat3m.dartagnan.exception.MalformedProgramException;
import com.dat3m.dartagnan.expression.Expression;
import com.dat3m.dartagnan.expression.ExpressionFactory;
import com.dat3m.dartagnan.expression.GEPExpression;
import com.dat3m.dartagnan.expression.IConst;
import com.dat3m.dartagnan.expression.processing.ExprTransformer;
import com.dat3m.dartagnan.expression.type.*;
import com.dat3m.dartagnan.program.Function;
import com.dat3m.dartagnan.program.Program;
import com.dat3m.dartagnan.program.event.core.utils.RegReader;
import com.dat3m.dartagnan.program.memory.MemoryObject;

import java.util.List;

public class GEPToAddition implements ProgramProcessor {

    private GEPToAddition() {}

    public static GEPToAddition newInstance() {
        return new GEPToAddition();
    }

    @Override
    public void run(Program program) {
        final var transformer = new GEPToAdditionTransformer();
        for (Function function : program.getFunctions()) {
            for (RegReader reader : function.getEvents(RegReader.class)) {
                reader.transformExpressions(transformer);
            }
        }

        for (MemoryObject memoryObject : program.getMemory().getObjects()) {
            for (int field : memoryObject.getStaticallyInitializedFields()) {
                memoryObject.setInitialValue(field, memoryObject.getInitialValue(field).accept(transformer));
            }
        }
    }

    private static final class GEPToAdditionTransformer extends ExprTransformer {

        private final TypeFactory types = TypeFactory.getInstance();
        private final ExpressionFactory expressions = ExpressionFactory.getInstance();
        private final IntegerType archType = types.getArchType();

        @Override
        public Expression visit(GEPExpression getElementPointer) {
            Type type = getElementPointer.getIndexingType();
            Expression result = getElementPointer.getBaseExpression().accept(this);
            final List<Expression> offsets = getElementPointer.getOffsetExpressions();
            assert offsets.size() > 0;
            result = expressions.makeADD(result,
                    expressions.makeMUL(
                            expressions.makeValue(types.getMemorySizeInBytes(type), archType),
                            expressions.makeIntegerCast(offsets.get(0).accept(this), archType, true)));
            for (final Expression oldOffset : offsets.subList(1, offsets.size())) {
                final Expression offset = oldOffset.accept(this);
                if (type instanceof ArrayType arrayType) {
                    type = arrayType.getElementType();
                    result = expressions.makeADD(result,
                            expressions.makeMUL(
                                    expressions.makeValue(types.getMemorySizeInBytes(arrayType.getElementType()), archType),
                                    expressions.makeIntegerCast(offset, archType, true)));
                    continue;
                }
                if (!(type instanceof AggregateType aggregateType)) {
                    throw new MalformedProgramException(String.format("GEP from non-compound type %s.", type));
                }
                if (!(offset instanceof IConst constant)) {
                    throw new MalformedProgramException(
                            String.format("Non-constant field index %s for aggregate of type %s.", offset, type));
                }
                final int value = constant.getValueAsInt();
                type = aggregateType.getDirectFields().get(value);
                int o = 0;
                for (final Type elementType : aggregateType.getDirectFields().subList(0, value)) {
                    o += types.getMemorySizeInBytes(elementType);
                }
                result = expressions.makeADD(result, expressions.makeValue(o, archType));
            }
            return result;
        }
    }
}
