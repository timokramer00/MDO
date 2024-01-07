function [c,ceq] = constraints_IDF_coup(x)
%constraints_IDF_coup([21.6,5,0.6,0.4,   0.2337, 0.0796,0.2683, 0.0887, 0.2789, 0.3811, -0.2254, -0.1634, -0.0470,-0.4771, 0.0735, 0.3255,0.75, 12009.12, 70400*9.81, 16, 3309.9816*9.81])
global couplings; 
Wstr = couplings.Wstr;
LD = couplings.LD;
Wfuel = couplings.Wfuel;

%calculating the MTOW from performance
WAW=90000*9.81;
CTdash=1.8639*10^-4;
R=9191476;
Vcruiseref=227.3844;
hcruiseref=12009.12;
b = x(1);
cr = x(2);
TRi = x(3);
TRo = x(4);
Au0 = x(5);
Au1 = x(6);
Au2 = x(7);
Au3 = x(8);
Au4 = x(9);
Au5 = x(10);
Al0 = x(11);
Al1 = x(12);
Al2 = x(13);
Al3 = x(14);
Al4 = x(15);
Al5 = x(16);
Mcruise = x(17);
hcruise = x(18);
Wfuel_init = x(19);
LD_init = x(20);
Wstr_init = x(21);

%for consistency constraints

cc1 = LD - LD_init;
cc2 = Wstr - Wstr_init;
cc3 = Wfuel - Wfuel_init;

%finding the cruise CL
%Q3D_Loads
WAW=92985*9.81; %kg
LEsweep=atan((cr-cr*TRi)/6.048);
Geom=[0     0     0     cr         0;
      6.048*tan(LEsweep)  6.048   0     cr*TRi+0.001         0;
      b*tan(LEsweep)  b  0  (cr*TRi)*TRo  0];

[T,a,P,rho] = atmosisa(hcruise);

V=a*Mcruise;
A=((Geom(1,4)+Geom(2,4))*Geom(2,2))/2+((Geom(2,4)+Geom(3,4))*(Geom(3,2)-Geom(2,2)))/2;
MTOW = WAW + Wfuel + Wstr;
L = MTOW;

CLcruise=sum(L)/(0.5*rho*V^2*A);

%tank volume calculations
rho_fuel = 817.15;
f_tank = 0.93;
V_fuel = Wfuel/rho_fuel;

V_tank = 1;

%inequality constraints
c1 = (CLcruise*1.3)/(0.86*cosd(LEsweep));
c2 = (V_fuel-5)/(V_tank*f_tank)-1;
c3 = (MTOW/A)/(166694.981/113.724-1);

c = [c1,c2,c3];
ceq = [cc1,cc2,cc3];
disp(ceq)
end
