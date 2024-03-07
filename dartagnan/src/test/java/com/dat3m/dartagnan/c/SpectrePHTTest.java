package com.dat3m.dartagnan.c;

import com.dat3m.dartagnan.configuration.OptionNames;
import com.dat3m.dartagnan.utils.Result;
import com.dat3m.dartagnan.utils.rules.Provider;
import com.dat3m.dartagnan.utils.rules.Providers;
import com.dat3m.dartagnan.verification.spectre.SpectreSolver;
import com.dat3m.dartagnan.wmm.Wmm;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.sosy_lab.common.configuration.Configuration;

import java.io.IOException;
import java.util.Arrays;

import static com.dat3m.dartagnan.configuration.Arch.C11;
import static com.dat3m.dartagnan.utils.ResourceHelper.getTestResourcePath;
import static com.dat3m.dartagnan.utils.Result.FAIL;
import static org.junit.Assert.assertEquals;

@RunWith(Parameterized.class)
public class SpectrePHTTest extends AbstractCTest {

    public SpectrePHTTest(String name, Result expected) {
        super(name, C11, expected);
    }

    @Override
    protected Provider<String> getProgramPathProvider() {
        return Provider.fromSupplier(() -> getTestResourcePath("spectre/pht/" + name + ".ll"));
    }

    @Override
    protected Provider<Wmm> getWmmProvider() {
        return Providers.createWmmFromName(() -> "sc_spectre");
    }

    @Override
    protected Provider<Configuration> getConfigurationProvider() {
        return Provider.fromSupplier(() -> Configuration.builder()
                .setOption(OptionNames.SPECULATION_WINDOW, "30")
                .build());
    }

    @Override
    protected long getTimeout() {
        return 60000;
    }

    @Parameterized.Parameters(name = "{index}: {0}, target={1}")
    public static Iterable<Object[]> data() throws IOException {
        return Arrays.asList(new Object[][]{
                {"victim_v01", FAIL},
                {"victim_v02", FAIL},
                {"victim_v04", FAIL},
                {"victim_v05", FAIL},
                {"victim_v06", FAIL},
                {"victim_v07", FAIL},
                {"victim_v08", FAIL},
                {"victim_v09", FAIL},
                {"victim_v10", FAIL},
                {"victim_v11", FAIL},
                {"victim_v12", FAIL},
                {"victim_v13", FAIL},
                {"victim_v14", FAIL},
                {"victim_v15", FAIL},
        });
    }

    @Test
    public void testSpectre() throws Exception {
        SpectreSolver s = SpectreSolver.run(contextProvider.get(), proverProvider.get(), taskProvider.get());
        assertEquals(expected, s.getResult());
    }

}