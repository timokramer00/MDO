global couplings;

Au = couplings.Au;
Al = couplings.Al;
croot = couplings.chordroot;
ckink = couplings.chordkink;
Chord = couplings.Chord;

X_planf = couplings.X_planf;
Y_planf = couplings.Y_planf;

b = 24.4192;
x_kink = 8.64;
le_sweep = 9.2761867;
te_sweep = 9.39;
b_list = linspace(0,b,222);


X_airfoilplot = linspace(0, 1, 100)';
[Xtu,Xtl] = D_airfoil2(Au,Al,X_airfoilplot);
hold on
view(3)

for i = 1:222
    if (b_list(i) <= x_kink)
        chord = (croot - tand(te_sweep)*b_list(i));
        start_x = 0;
    else
        chord = (ckink - tand(te_sweep)*(b_list(i)-x_kink) - tand(le_sweep)*(b_list(i)-x_kink));
        start_x = tand(le_sweep)*(b_list(i)-x_kink);
    end
    plot3(start_x + Xtu(1:end,1).*chord,b_list(i)*ones(100), Xtu(1:end,2).*chord, "b")
    plot3(start_x + Xtl(1:end,1).*chord,b_list(i)*ones(100), Xtl(1:end,2).*chord, "b")
end

axis equal;
xlabel("c [m]");
ylabel("b [m]");




