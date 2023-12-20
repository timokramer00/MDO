clear all
close all
clc


%% Aerodynamic solver setting

% Wing planform geometry 
%                x    y     z   chord(m)    twist angle (deg) 
AC.Wing.Geom = [0     0     0     5         0;
                2  6.048   0     3         0;
                2+15.552*sind(18.3)  15.552  0  1.2  0];

% Wing incidence angle (degree)
AC.Wing.inc  = 0;   
            
            
% Airfoil coefficients input matrix
%                    | ->     upper curve coeff.                <-|   | ->       lower curve coeff.       <-| 
AC.Wing.Airfoils   = [0.2171    0.3450    0.2975    0.2685    0.2893  -0.1299   -0.2388   -0.1635   -0.0476    0.0797;
                      0.2171    0.3450    0.2975    0.2685    0.2893  -0.1299   -0.2388   -0.1635   -0.0476    0.0797];
                  
AC.Wing.eta = [0;1];  % Spanwise location of the airfoil sections

% Viscous vs inviscid
AC.Visc  = 1;              % 0 for inviscid and 1 for viscous analysis

% Flight Condition
AC.Aero.V     = 236;            % flight speed (m/s)
AC.Aero.rho   = 0.3639;         % air density  (kg/m3)
AC.Aero.alt   = 11000;             % flight altitude (m)
AC.Aero.Re    = 1.7e7;        % reynolds number (bqased on mean aerodynamic chord)
AC.Aero.M     = 0.8;           % flight Mach number 
AC.Aero.CL    = 0.4;          % lift coefficient - comment this line to run the code for given alpha%
% AC.Aero.Alpha = 2;             % angle of attack -  comment this line to run the code for given cl 


%% 
tic

try 
Res = Q3D_solver(AC);
catch error
    CD = inf;
end

t=toc