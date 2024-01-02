%% Aerodynamic solver setting
function [L,M,Y]=Q3D_Loads_func(b,cr,TRi,TRo,berncoef,hcruise,Wstr,Wfuel)

WAW=92985*9.81; %kg

% Wing planform geometry 
LEsweep=atan((cr-cr*TRi)/6.048);
%                x    y     z   chord(m)    twist angle (deg) 
AC.Wing.Geom = [0     0     0     cr         0;
                6.048*tan(LEsweep)  6.048   0     cr*TRi+0.001         0;
                b*tan(LEsweep)  b  0  (cr*TRi)*TRo  0];

% Wing incidence angle (degree)
AC.Wing.inc  = 0;   
            
            
% Airfoil coefficients input matrix
%                    | ->     upper curve coeff.                <-|   | ->       lower curve coeff.       <-| 
AC.Wing.Airfoils   = [berncoef;
                      berncoef];
                  
AC.Wing.eta = [0;1];  % Spanwise location of the airfoil sections

% Viscous vs inviscid
AC.Visc  = 1;              % 0 for inviscid and 1 for viscous analysis

% Flight Condition
[T,a,P,rho] = atmosisa(hcruise);

nmax=2.5;
A=((AC.Wing.Geom(1,4)+AC.Wing.Geom(2,4))*AC.Wing.Geom(2,2))/2+((AC.Wing.Geom(2,4)+AC.Wing.Geom(3,4))*(AC.Wing.Geom(3,2)-AC.Wing.Geom(2,2)))/2;
AC.Aero.V     = 250.0200;            % flight speed (m/s)
AC.Aero.rho   = rho;         % air density  (kg/m3)
AC.Aero.alt   = hcruise;             % flight altitude (m)
AC.Aero.Re    = 1.14e7;        % reynolds number (bqased on mean aerodynamic chord)
AC.Aero.M     = AC.Aero.V/a;           % flight Mach number
L=(Wstr+Wfuel+WAW)*nmax;
AC.Aero.CL    = L/(0.5*AC.Aero.rho*A*2*AC.Aero.V^2);          % lift coefficient - comment this line to run the code for given alpha%d
disp(AC.Aero.CL)
%AC.Aero.Alpha = 2;             % angle of attack -  comment this line to run the code for given cl 


%% 
tic


Res = Q3D_solver(AC);
Y=Res.Wing.Yst;
Cl=Res.Wing.cl;
Cm=Res.Wing.cm_c4;
Chord=Res.Wing.chord;
for i = 1:length(Cl)
    if i == 1
        w=Y(i)*2;
        c1=AC.Wing.Geom(1,4);
        c2=Chord(i)-(c1-Chord(i));
    end
    if i~=1
        w=(Y(i)-(Y(i-1)+w/2))*2;
        c1=c2;
        c2=Chord(i)-(c1-Chord(i));
    end
    
    %Atest(i)=(c1+c2)*(w)/2;
    L(i)=0.5*rho*AC.Aero.V^2*Cl(i)*(c1+c2)*(w)/2;
    M(i)=0.5*rho*AC.Aero.V^2*Cm(i)*Chord(i)*(c1+c2)*(w)/2;
end

%Change in line 12 the x value for exercise 3
t=toc