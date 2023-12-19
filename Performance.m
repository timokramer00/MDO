function [out]=Performance(Wstr, LD, Mcruise, hcruise, Wfuel)

WAW=1;
CTdash=1.8639*10^-4;
R=9191476;
Vcruiseref=227.3844;
hcruiseref=12009.12;

ISA = atmosisa(hcruise);
Vcruise = ISA(2)*Mcruise;

eta = exp(-(((Vcruise -Vcruiseref)^2)/(2*70^2))*((hrcruise-hcruiseref)^2/(2*2500^2)));
CT = CTdash/eta;

weightratio = exp((R*CT)/(V*LD));
MTOW = WAW + Wfuel + Wstr;

out = (1-0.938/weightratio)*MTOW;
end
