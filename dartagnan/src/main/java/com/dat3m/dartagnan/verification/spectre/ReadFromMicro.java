package com.dat3m.dartagnan.verification.spectre;

import com.dat3m.dartagnan.wmm.Definition;
import com.dat3m.dartagnan.wmm.Relation;
import com.dat3m.dartagnan.wmm.RelationNameRepository;

public class ReadFromMicro extends Definition {

    public ReadFromMicro(Relation r0) {
        super(r0, RelationNameRepository.RFX);
    }

    @Override
    public <T> T accept(Visitor<? extends T> v) {
        return v.visitReadFromMicro(this);
    }

}