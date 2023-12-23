%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Structures Discipline
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Q3D
Y=Res.Wing.Yst;
rho=AC.Aero.rho;
V=AC.Aero.V;
Cl=Res.Wing.cl;
Cm=Res.Wing.cm_c4;

A=((AC.Wing.Geom(1,4)+AC.Wing.Geom(2,4))*AC.Wing.Geom(2,2))/2+((AC.Wing.Geom(2,4)+AC.Wing.Geom(3,4))*AC.Wing.Geom(3,2))/2;
L=[];
for i = 1:length(Cl)
    L(i)=0.5*rho*V^2*Cl(i)*A;
end




X_planf=[AC.Wing.Geom(1,4),AC.Wing.Geom(1,1),AC.Wing.Geom(2,1), AC.Wing.Geom(3,1),AC.Wing.Geom(3,1)+AC.Wing.Geom(3,4),AC.Wing.Geom(2,1)+AC.Wing.Geom(2,4), AC.Wing.Geom(2,1), AC.Wing.Geom(2,1)+AC.Wing.Geom(2,4), AC.Wing.Geom(1,4)];
Y_planf=[AC.Wing.Geom(1,2),AC.Wing.Geom(1,2),AC.Wing.Geom(2,2), AC.Wing.Geom(3,2),AC.Wing.Geom(3,2), AC.Wing.Geom(2,2), AC.Wing.Geom(2,2), AC.Wing.Geom(2,2), AC.Wing.Geom(1,2)];
%X_planf=[AC.Wing.Geom(1,4),AC.Wing.Geom(1,1),AC.Wing.Geom(2,1),AC.Wing.Geom(2,1)+AC.Wing.Geom(2,4),AC.Wing.Geom(1,4)];
%Y_planf=[AC.Wing.Geom(1,2),AC.Wing.Geom(1,2),AC.Wing.Geom(2,2),AC.Wing.Geom(2,2),AC.Wing.Geom(1,2)];
figure 
plot (Y_planf,X_planf)
axis equal
axis([min(Y_planf)-1 max(Y_planf)+1 min(X_planf)-1 max(X_planf)+1])