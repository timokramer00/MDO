function [f,vararg] = objective(x)
%UNTITLED Summary of this function goes here
%objective(ones(1,21))

%Reference aircraft input: objective([21.6,5,0.6,0.4,   0.2337, 0.0796,0.2683, 0.0887, 0.2789, 0.3811, -0.2254, -0.1634, -0.0470,-0.4771, 0.0735, 0.3255,0.75, 12009.12, 70400*9.81, 16, 3680.9816*9.81])
%   Detailed explanation goes here
%Design vector x = [b,  ̃cr ,  ̃ψk,r ,  ̃ψt,k,  ̃Au0,  ̃Au1,  ̃Au2,  ̃Au3,
x0 = [21.6,10.32,0.69,0.39,   0.2337, 0.0796,0.2683, 0.0887, 0.2789, 0.3811, -0.2254, -0.1634, -0.0470,-0.4771, 0.0735, 0.3255,0.75, 12009.12, 70400*9.81, 16, 25065.9*9.81];
%̃Au4,  ̃Au5,  ̃Al0, l1,  ̃Al2,  ̃Al3,  ̃Al4,  ̃Al5,  ̃Mcruise,  ̃hcruise,  ̃Wfuel,  ̃L/D,  ̃Wstr,wing]
b = x(1)*x0(1);
cr = x(2)*x0(2);
TRi = x(3)*x0(3);
TRo = x(4)*x0(4);
Au0 = x(5)*x0(5);
Au1 = x(6)*x0(6);
Au2 = x(7)*x0(7);
Au3 = x(8)*x0(8);
Au4 = x(9)*x0(9);
Au5 = x(10)*x0(10);
Al0 = x(11)*x0(11);
Al1 = x(12)*x0(12);
Al2 = x(13)*x0(13);
Al3 = x(14)*x0(14);
Al4 = x(15)*x0(15);
Al5 = x(16)*x0(16);
Mcruise = x(17)*x0(17);
hcruise = x(18)*x0(18);
Wfuel_init = x(19)*x0(19);
LD_init = x(20)*x0(20);
Wstr_init = x(21)*x0(21);

Wfuel=Performance(Wstr_init,LD_init,Mcruise,hcruise,Wfuel_init)/x0(19);
LD=Aerodynamics(b,cr,TRi,TRo,[Au0,Au1,Au2,Au3,Au4,Au5,Al0,Al1,Al2,Al3,Al4,Al5],hcruise,Wstr_init,Wfuel_init,Mcruise)/x0(20);
[L,M,Y]=Q3D_Loads_func(b,cr,TRi,TRo,[Au0,Au1,Au2,Au3,Au4,Au5,Al0,Al1,Al2,Al3,Al4,Al5],hcruise,Wstr_init,Wfuel_init);
Wstr=(Structures(b,cr,TRi,TRo,[Au0,Au1,Au2,Au3,Au4,Au5,Al0,Al1,Al2,Al3,Al4,Al5],Wstr_init,Wfuel_init,L,M,Y)*9.81)/x0(21);


global couplings;
    
vararg = {Wfuel,Wfuel_init,LD,LD_init,Wstr,Wstr_init};
couplings.Wfuel = Wfuel;
couplings.LD = LD;
couplings.Wstr = Wstr;
f=Wfuel;
end