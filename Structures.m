%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Structures Discipline
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Q3D_Loads
Y=Res.Wing.Yst;
rho=AC.Aero.rho;
V=AC.Aero.V;
Cl=Res.Wing.cl;
Cm=Res.Wing.cm_c4;
Chord=Res.Wing.chord;
Chord(15)=AC.Wing.Geom(3,4);
Y(15)=AC.Wing.Geom(3,2);

%A=((AC.Wing.Geom(1,4)+AC.Wing.Geom(2,4))*AC.Wing.Geom(2,2))/2+((AC.Wing.Geom(2,4)+AC.Wing.Geom(3,4))*AC.Wing.Geom(3,2))/2;
L=[];
M=[];
for i = 1:length(Cl)
    L(i)=0.5*rho*V^2*Cl(i)*(Chord(i)+Chord(i+1))*(Y(i+1)-Y(i))/2;
    M(i)=0.5*rho*V^2*Cm(i)*Chord(i)*(Chord(i)+Chord(i+1))*(Y(i+1)-Y(i))/2;
end

X_planf=[AC.Wing.Geom(1,4),AC.Wing.Geom(1,1),AC.Wing.Geom(2,1), AC.Wing.Geom(3,1),AC.Wing.Geom(3,1)+AC.Wing.Geom(3,4),AC.Wing.Geom(2,1)+AC.Wing.Geom(2,4), AC.Wing.Geom(2,1), AC.Wing.Geom(2,1)+AC.Wing.Geom(2,4), AC.Wing.Geom(1,4)];
Y_planf=[AC.Wing.Geom(1,2),AC.Wing.Geom(1,2),AC.Wing.Geom(2,2), AC.Wing.Geom(3,2),AC.Wing.Geom(3,2), AC.Wing.Geom(2,2), AC.Wing.Geom(2,2), AC.Wing.Geom(2,2), AC.Wing.Geom(1,2)];
%X_planf=[AC.Wing.Geom(1,4),AC.Wing.Geom(1,1),AC.Wing.Geom(2,1),AC.Wing.Geom(2,1)+AC.Wing.Geom(2,4),AC.Wing.Geom(1,4)];
%Y_planf=[AC.Wing.Geom(1,2),AC.Wing.Geom(1,2),AC.Wing.Geom(2,2),AC.Wing.Geom(2,2),AC.Wing.Geom(1,2)];
figure 
plot (Y_planf,X_planf)
axis equal
axis([min(Y_planf)-1 max(Y_planf)+1 min(X_planf)-1 max(X_planf)+1])

Y(15)=[];

fid = fopen('IL62.load', 'wt');
for j = 1:length(Y)
fprintf(fid,'%6.4f  %5.4f %5.4f\n',Y(j),L(j),M(j));
end
fclose(fid);


EMWET IL62









