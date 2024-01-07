function [out,vararg] = Optim_IDF(x)
    global couplings;

    vararg = {Wfuel,Wfuel_init,LD,LD_init,Wstr,Wstr_init};
    couplings.Wfuel = Wfuel;
    couplings.LD = LD;
    couplings.Wstr = Wstr;

    out = objective(x);
end