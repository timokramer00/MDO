%% Aerodynamic solver setting
function [Res]=Q3D_Aero(b,cr,TRi,TRo,berncoef,hcruise,Wstr,Wfuel,Mcruise)

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
[T,a , P, rho, nu] = atmosisa(hcruise);

MACin=cr*(2/3)*((1+TRi+TRi^2)/(1+TRi));
MACout=cr*TRi*(2/3)*((1+TRo+TRo^2)/(1+TRo));
MAC=(MACin+MACout)/2;


A=((AC.Wing.Geom(1,4)+AC.Wing.Geom(2,4))*AC.Wing.Geom(2,2))/2+((AC.Wing.Geom(2,4)+AC.Wing.Geom(3,4))*AC.Wing.Geom(3,2))/2;
AC.Aero.V     = a*Mcruise;            % flight speed (m/s)
AC.Aero.rho   = rho;         % air density  (kg/m3)
AC.Aero.alt   = hcruise;             % flight altitude (m)
AC.Aero.Re    = (AC.Aero.V*MAC)/nu;        % reynolds number (bqased on mean aerodynamic chord)
AC.Aero.M     = Mcruise;           % flight Mach number
L=(Wstr+Wfuel+WAW);
AC.Aero.CL    = L/(0.5*AC.Aero.rho*2*A*AC.Aero.V^2);          % lift coefficient - comment this line to run the code for given alpha%
%AC.Aero.Alpha = 2;             % angle of attack -  comment this line to run the code for given cl 


%% 
Res = Q3D_solver(AC);