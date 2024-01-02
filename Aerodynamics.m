function Cdaw = Aerodynamics(b,cr,TRi,TRo,berncoef,hcruise,Wstr,Wfuel,Mcruise)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
Res=Q3D_Aero(b,cr,TRi,TRo,berncoef,hcruise,Wstr,Wfuel,Mcruise);

%Q3D_Loads
WAW=90000; %kg
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

for i = 1:length (Cd)
    Cdaw=(Cl(i)/LDref)-Cd;

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
    
    %Atest(i)=(c1+c2)*(w)/2;
    L(i)=0.5*rho*V^2*Cl(i)*(c1+c2)*(w)/2;
    D(i)=0.5*rho*V^2*Cd(i)*Chord(i)*(c1+c2)*(w)/2;
end

end