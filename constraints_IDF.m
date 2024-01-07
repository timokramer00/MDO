function [c,ceq] = constraints_IDF(x)
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

hcruise = x(18);
Mcruise = x(17);

[T,a,P,rho] = atmosisa(hcruise);
Vcruise = a*Mcruise;

eta = exp(-(((Vcruise -Vcruiseref)^2)/(2*70^2))*((hcruise-hcruiseref)^2/(2*2500^2)));
CT = CTdash/eta;

weightratio = exp((R*CT)/(Vcruise*LD));
MTOW = WAW + Wfuel + Wstr;

%for consistency constraints
LD_c = x(20);
Wstr_c = x(21);
MTOW_c = WAW + x(18) + x(21);

cc1 = LD - LD_c;
cc2 = Wstr - Wstr_c;
cc3 = MTOW - MTOW_c;

%finding the cruise CL

Res = Q3D_solver(AC);

%Q3D_Loads
WAW=92985*9.81; %kg
LEsweep=atan((cr-cr*TRi)/6.048);
Geom=[0     0     0     cr         0;
      6.048*tan(LEsweep)  6.048   0     cr*TRi+0.001         0;
      b*tan(LEsweep)  b  0  (cr*TRi)*TRo  0];
Y=Res.Wing.Yst;
[T,a,P,rho] = atmosisa(hcruise);

V=a*Mcruise;
Cl=Res.Wing.cl;
Cd=Res.Wing.cdi;
Chord=Res.Wing.chord;
LDref=16;
A=((Geom(1,4)+Geom(2,4))*Geom(2,2))/2+((Geom(2,4)+Geom(3,4))*(Geom(3,2)-Geom(2,2)))/2;

qref=0.5*0.3104*221.3022^2;
q=0.5*rho*V^2;
qratio=q/qref;
CDaw=0.0254*qratio;

for i = 1:length(Cl)
    if i == 1
        w=Y(i)*2;
        c1=Geom(1,4);
        c2=Chord(i)-(c1-Chord(i));
    end
    if i~=1
        w=(Y(i)-(Y(i-1)+w/2))*2;
        c1=c2;
        c2=Chord(i)-(c1-Chord(i));
    end
    
 
    L(i)=0.5*rho*V^2*Cl(i)*(c1+c2)*(w)/2;
    D(i)=0.5*rho*V^2*Cd(i)*(c1+c2)*(w)/2;
    
end
CLwing=sum(L)/(0.5*rho*V^2*A);

CLcruise = CLwing;

%tank volume calculations
rho_fuel = 817.15;
f_tank = 0.93;
V_fuel = Wfuel/rho_fuel;

V_tank = 

%inequality constraints
c1 = (CLcruise*1.3)/(0.86*cos());
c2 = (V_fuel-5)/(V_tank*f_tank)-1;
c3 = (MTOW/A)/(166694.981/113.724-1);

c = [c1,c2,c3];
ceq = [cc1,cc2,cc3];

end
