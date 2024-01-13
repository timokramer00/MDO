
% Ncoeff = width(A)/2;
% Au = A(1:Ncoeff);
% Al = A((Ncoeff+1):end);
global couplings;

Au = couplings.Au;
Al = couplings.Al;
croot = couplings.chordroot;
ckink = couplings.chordkink;
Chord = couplings.Chord;

X_planf = couplings.X_planf;
Y_planf = couplings.Y_planf;

b = 24.4192;
b_list = linspace(0,b,100);

% disp(croot);
% disp(ckink);
% disp(Chord)

%Chord = linspace(1,7,100);
Chord = 3;

X_airfoilplot = linspace(0, 1, 100)';
[Xtu,Xtl] = D_airfoil2(Au,Al,X_airfoilplot);
hold on
view(3)
plot3(Xtu(1:end,1).*Chord, Xtu(1:end,2).*Chord,b_list, "r")
plot3(Xtl(1:end,1).*Chord, Xtl(1:end,2).*Chord,b_list, "g")
axis equal;
xlabel("x-coordinate [m]");
ylabel("z-coordinate [m]");
