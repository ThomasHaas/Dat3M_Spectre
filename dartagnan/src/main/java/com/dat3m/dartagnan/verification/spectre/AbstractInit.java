package com.dat3m.dartagnan.verification.spectre;

import com.dat3m.dartagnan.expression.Expression;
import com.dat3m.dartagnan.program.event.EventVisitor;
import com.dat3m.dartagnan.program.event.Tag;
import com.dat3m.dartagnan.program.event.core.Store;

public class AbstractInit extends Store {

    public AbstractInit(Expression addr, Expression defaultValue) {
        super(addr, defaultValue);
        addTags(Tag.INIT);
    }

    @Override
    public String defaultString() {
        return String.format("AbsInit := %s", getMemValue());
    }

    @Override
    public <T> T accept(EventVisitor<T> visitor) {
        return visitor.visitAbstractInit(this);
    }
}