function [out]=Performance(Wstr, LD, Mcruise, hcruise, Wfuel)

WAW=75362.9*9.81; %N
CTdash=1.8639*10^-4;
R=9191476;
Vcruiseref=221.3022;
hcruiseref=12009.12;

[T,a,P,rho] = atmosisa(hcruise);
Vcruise = a*Mcruise;

eta = exp(-(((Vcruise -Vcruiseref)^2)/(2*70^2))-((hcruise-hcruiseref)^2/(2*2500^2)));
CT = CTdash/eta;

weightratio = exp((R*CT)/(Vcruise*LD));
MTOW = WAW + Wfuel + Wstr

out = (1-0.938/weightratio)*MTOW;
end
