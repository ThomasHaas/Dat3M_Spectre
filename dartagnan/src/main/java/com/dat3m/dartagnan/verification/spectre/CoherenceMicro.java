package com.dat3m.dartagnan.verification.spectre;

import com.dat3m.dartagnan.wmm.Definition;
import com.dat3m.dartagnan.wmm.Relation;

import static com.dat3m.dartagnan.wmm.RelationNameRepository.COX;

public class CoherenceMicro extends Definition {

    public CoherenceMicro(Relation r0) {
        super(r0, COX);
    }

    @Override
    public <T> T accept(Visitor<? extends T> v) {
        return v.visitCoherenceMicro(this);
    }
}