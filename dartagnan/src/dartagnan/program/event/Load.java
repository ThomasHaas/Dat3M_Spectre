package dartagnan.program.event;

import com.microsoft.z3.BoolExpr;
import com.microsoft.z3.Context;
import com.microsoft.z3.Expr;
import dartagnan.expression.IExpr;
import dartagnan.program.Register;
import dartagnan.program.event.utils.RegWriter;
import dartagnan.program.memory.Location;
import dartagnan.program.utils.EType;
import dartagnan.utils.MapSSA;
import dartagnan.utils.Pair;

import static dartagnan.utils.Utils.ssaLoc;
import static dartagnan.utils.Utils.ssaReg;

public class Load extends MemEvent implements RegWriter {

    protected Register reg;
    protected int ssaRegIndex;

    public Load(Register register, IExpr address, String atomic) {
        this.address = address;
        this.atomic = atomic;
        this.condLevel = 0;
        this.reg = register;
        addFilters(EType.ANY, EType.MEMORY, EType.READ);
    }

    @Override
    public Register getModifiedReg(){
        return reg;
    }

    @Override
    public String toString() {
        return nTimesCondLevel() + reg + " <- memory[" + address + "]";
    }

    @Override
    public String label(){
        return "R_" + atomic;
    }

    @Override
    public Load clone() {
        if(clone == null){
            clone = new Load(reg.clone(), address.clone(), atomic);
            afterClone();
        }
        return (Load)clone;
    }

    @Override
    public Pair<BoolExpr, MapSSA> encodeDF(MapSSA map, Context ctx) {
        if(mainThread == null){
            throw new RuntimeException("Main thread is not set for " + toString());
        }
        if(locations == null){
            throw new RuntimeException("Location set is not specified for " + toString());
        }

        Expr z3Reg = ssaReg(reg, map.getFresh(reg), ctx);
        this.ssaRegIndex = map.get(reg);
        addressExpr = address.toZ3Int(map, ctx);
        BoolExpr enc = ctx.mkTrue();

        for(Location loc : locations){
            Expr z3Loc = ssaLoc(loc, mainThread.getTId(), map.getFresh(loc), ctx);
            this.ssaLocMap.put(loc, z3Loc);
            enc = ctx.mkAnd(enc, ctx.mkImplies(
                    ctx.mkEq(addressExpr, loc.getAddress().toZ3Int(ctx)),
                    ctx.mkEq(z3Reg, z3Loc)
            ));
        }
        return new Pair<>(ctx.mkImplies(executes(ctx), enc), map);
    }

    @Override
    public int getSsaRegIndex() {
        return ssaRegIndex;
    }
}
