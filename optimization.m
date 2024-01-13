clear all
close all
clc

%0.2337, 0.0796,0.2683, 0.0887, 0.2789, 0.3811, -0.2254, -0.1634, -0.0470,-0.4771, 0.0735, 0.3255
%Initial values:
x0 = ones(1,21);

%bounds
lb = [0.6,0.5,0.6,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.9,0.9,0.5,0.5,0.5];
ub = [1.4,1.3,1.33,2,1.7,1.7,1.7,1.7,1.7,1.7,1.7,1.7,1.7,1.7,1.7,1.7,1.1,1.1,1.5,1.5,1.5];




% Options for the optimization

options = optimset('fmincon');
options.Display         = 'iter-detailed';
options.Algorithm       = 'sqp';
options.FunValCheck     = 'off';
options.DiffMinChange   = 0.03;         % Minimum change while gradient searching
options.DiffMaxChange   = 1e-1;         % Maximum change while gradient searching
options.TolCon          = 5e-3;         % Maximum difference between two subsequent constraint vectors [c and ceq]
options.TolFun          = 5e-4;         % Maximum difference between two subsequent objective value
options.TolX            = 1e-6;         % Maximum difference between two subsequent design vectors
options.PlotFcns         = {@optimplotx,@optimplotfval,@optimplotfirstorderopt,@plotConstraints};
%options.FinDiffType     ='central';
options.MaxIter         = 60;           % Maximum iterations

tic;
[x,FVAL,EXITFLAG,OUTPUT] = fmincon(@(x) objective(x),x0,[],[],[],[],lb,ub,@(x) constraints_IDF_coup(x),options);
t=toc;

%optionally, call the objective again with the optimum values for x
[f] = objective(x)
