%  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Structures Discipline
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [Wstr]=Structures(b,cr,TRi,TRo,berncoef,Wstr,Wfuel,L,M,Y)
%Q3D_Loads
WAW=90000; %kg
LEsweep=atan((cr-cr*TRi)/6.048);
Geom=[0     0     0     cr         0;
      6.048*tan(LEsweep)  6.048   0     cr*TRi+0.001         0;
      b*tan(LEsweep)  b  0  (cr*TRi)*TRo  0];

A=((Geom(1,4)+Geom(2,4))*Geom(2,2))/2+((Geom(2,4)+Geom(3,4))*(Geom(3,2)-Geom(2,2)))/2;
MTOW=WAW+Wfuel+Wstr;
MEW=WAW+Wstr;

X_planf=[Geom(1,4),Geom(1,1),Geom(2,1), Geom(3,1),Geom(3,1)+Geom(3,4),Geom(2,1)+Geom(2,4), Geom(2,1), Geom(2,1)+Geom(2,4), Geom(1,4)];
Y_planf=[Geom(1,2),Geom(1,2),Geom(2,2), Geom(3,2),Geom(3,2), Geom(2,2), Geom(2,2),Geom(2,2), Geom(1,2)];
figure 
plot (Y_planf,X_planf)
axis equal
axis([min(Y_planf)-1 max(Y_planf)+1 min(X_planf)-1 max(X_planf)+1])


fid = fopen('IL62.load', 'wt');
for j = 1:length(Y)
fprintf(fid,'%f  %f %f\n',Y(j),L(j),M(j));
end
fclose(fid);


fid = fopen('IL62.init', 'wt');
fprintf(fid,'%f %f', MTOW, MEW);
fprintf(fid, '\n%f', 2.5);
fprintf(fid, '\n%f %f %i %i',A*2,b*2,3,2);
fprintf(fid, '\n%i %s',0,'withcomb135');
fprintf(fid, '\n%i %s',1,'withcomb135');
fprintf(fid, '\n%f %f %f %f %f %f',Geom(1,4),Geom(1,1),Geom(1,2),Geom(1,3),0.175,0.575);
fprintf(fid, '\n%f %f %f %f %f %f',Geom(2,4),Geom(2,1),Geom(2,2),Geom(2,3),0.175,0.575);
fprintf(fid, '\n%f %f %f %f %f %f',Geom(3,4),Geom(3,1),Geom(3,2),Geom(3,3),0.175,0.575);
fprintf(fid, '\n%f %f',0,0.85);
fprintf(fid, '\n%i',0);
fprintf(fid, '\n%e %f %e %e',70e9, 2800, 2.95e008, 2.95e008);
fprintf(fid, '\n%e %f %e %e',70e9, 2800, 2.95e008, 2.95e008);
fprintf(fid, '\n%e %f %e %e',70e9, 2800, 2.95e008, 2.95e008);
fprintf(fid, '\n%e %f %e %e',70e9, 2800, 2.95e008, 2.95e008);
fprintf(fid, '\n%f %f',0.96,0.5);
fprintf(fid, '\n%i', 1);
fclose(fid);



EMWET IL62

fid = fopen('IL62.weight','r');
Wstring = strsplit(fgetl(fid),'Wing total weight(kg) ');
Wstr=str2double(Wstring(2));

fclose(fid);




