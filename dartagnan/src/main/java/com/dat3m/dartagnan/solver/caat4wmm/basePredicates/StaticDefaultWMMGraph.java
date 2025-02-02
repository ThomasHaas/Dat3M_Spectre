package com.dat3m.dartagnan.solver.caat4wmm.basePredicates;

import com.dat3m.dartagnan.solver.caat.predicates.relationGraphs.Edge;
import com.dat3m.dartagnan.solver.caat.predicates.relationGraphs.RelationGraph;
import com.dat3m.dartagnan.verification.model.EventData;
import com.dat3m.dartagnan.wmm.Relation;
import com.dat3m.dartagnan.wmm.analysis.RelationAnalysis;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

// Used for static relations that are not yet implemented explicitly
public class StaticDefaultWMMGraph extends MaterializedWMMGraph {
    private final Relation relation;
    private final RelationAnalysis ra;

    public StaticDefaultWMMGraph(Relation rel, RelationAnalysis relationAnalysis) {
        this.relation = rel;
        this.ra = relationAnalysis;
    }

    @Override
    public List<RelationGraph> getDependencies() {
        return Collections.emptyList();
    }

    @Override
    public void repopulate() {
        ra.getKnowledge(relation).getMaySet().apply((e1, e2) -> {
            Optional<EventData> d1 = model.getData(e1);
            Optional<EventData> d2 = model.getData(e2);
            if (d1.isPresent() && d2.isPresent()) {
                simpleGraph.add(new Edge(d1.get().getId(), d2.get().getId()));
            }
        });
    }
}
