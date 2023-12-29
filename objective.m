function [out] = objective(x)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%Design vector x = [b,  ̃cr ,  ̃ψk,r ,  ̃ψt,k,  ̃Au0,  ̃Au1,  ̃Au2,  ̃Au3,
%̃Au4,  ̃Au5,  ̃Al0, l1,  ̃Al2,  ̃Al3,  ̃Al4,  ̃Al5,  ̃Mcruise,  ̃hcruise,  ̃Wfuel,  ̃L/D,  ̃Wstr,wing]
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




Wfuel=Performance(Wstr_init,LD_init,Mcruise,hcruise,Wfuel_init);
LD=Q3D_Aero(b,cr,TRI,TRo,[Au0,Au1,Au2,Au3,Au4,Au5,Al0,Al1,Al2,Al3,Al4,Al5],hcruise,Wstr_init);
[Res]=Q3D_Loads_func(b,cr,TRi,TRo,[Au0,Au1,Au2,Au3,Au4,Au5,Al0,Al1,Al2,Al3,Al4,Al5],hcruise,Wstr_init,Wfuel_init);
Wstr=Structures(b,cr,TRi,TRo,berncoef,Wstr_init,Wfuel,Res);

out=3.16*Wfuel;
end