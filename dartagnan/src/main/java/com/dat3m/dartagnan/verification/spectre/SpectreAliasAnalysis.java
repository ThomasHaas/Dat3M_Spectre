package com.dat3m.dartagnan.verification.spectre;

import com.dat3m.dartagnan.program.Program;
import com.dat3m.dartagnan.program.analysis.alias.AliasAnalysis;
import com.dat3m.dartagnan.program.event.Tag;
import com.dat3m.dartagnan.program.event.core.MemoryCoreEvent;
import org.sosy_lab.common.configuration.Configuration;
import org.sosy_lab.common.configuration.InvalidConfigurationException;

public class SpectreAliasAnalysis {

    public static AliasAnalysis fromConfig(Program program, Configuration config) throws InvalidConfigurationException {
        final AliasAnalysis inner = AliasAnalysis.fromConfig(program, config);

        return new AliasAnalysis() {
            @Override
            public boolean mustAlias(MemoryCoreEvent a, MemoryCoreEvent b) {
                if (a.hasTag(Tag.SPECULATED) || b.hasTag(Tag.SPECULATED)) {
                    return false;
                }
                return inner.mustAlias(a, b);
            }

            @Override
            public boolean mayAlias(MemoryCoreEvent a, MemoryCoreEvent b) {
                if (a.hasTag(Tag.SPECULATED) || b.hasTag(Tag.SPECULATED)) {
                    return true;
                }
                return inner.mayAlias(a, b);
            }
        };

    }
}
