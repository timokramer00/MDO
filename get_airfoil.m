function get_airfoil(Au,Al)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
X_vect = linspace(0,1,99)'; 
[Xtu,Xtl,C,Thu,Thl,Cm] = D_airfoil2(Au,Al,X_vect);


Xtu = flipud(Xtu);
Xtu(length(Xtu),:)=[];
X=[Xtu;Xtl];



fid = fopen('airfoil1.dat', 'wt');
for j = 1:length(X(:,1))
    fprintf(fid, '%f %f\n', X(j,1),X(j,2));
end

fclose (fid);
fid = fopen('airfoil2.dat', 'wt');
for j = 1:length(X(:,1))
    fprintf(fid, '%f %f\n', X(j,1),X(j,2));
end

fclose (fid);

fid = fopen('airfoil3.dat', 'wt');
for j = 1:length(X(:,1))
    fprintf(fid, '%f %f\n', X(j,1),X(j,2));
end

fclose (fid);
