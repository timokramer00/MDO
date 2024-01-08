cr=5;
TRi=0.6;
TRo=0.4;
b=21.6;
LEsweep=atan((cr-cr*TRi)/6.048);
Geom=[0     0     0     cr         0;
      6.048*tan(LEsweep)  6.048   0     cr*TRi+0.001         0;
      b*tan(LEsweep)  b  0  (cr*TRi)*TRo  0];



fid= fopen('airfoil.dat','r'); % Filename can be changed as required
Coor = fscanf(fid,'%g %g',[2 Inf]) ; 
fclose(fid) ;


tankmaxo=0.85*b-6.048;
bout=b-6.048;
frac=tankmaxo/bout;
chordtankmax=Geom(2,4)-(Geom(2,4)-Geom(3,4))*frac;
chordkink=Geom(2,4);
chordroot=Geom(1,4);

tankub=0.575;
tanklb=0.175;
j=1;
crefout=zeros(1,length(Coor)-98);
crefin=zeros(1,length(Coor)-98);
dout=zeros(1,length(Coor)-98);
din=zeros(1,length(Coor)-98);

for i = ceil(length(Coor)/2):(length(Coor))
    if i == length(Coor)
        break
    end
    crefout(1)=bout*tan(LEsweep);
    dout(1)=sqrt((crefout(1))^2+bout^2);
    crefout(i-97)=abs(crefout(i-98)-Coor(1,i+1)*chordkink+Coor(1,i+1)*chordtankmax);
    dout(i-97)=sqrt(crefout(i-97)^2+bout^2);

    crefin(1)=6.048*tan(LEsweep);
    din(1)=sqrt((crefin(1))^2+6.048^2);
    crefin(i-97)=abs(crefin(i-98)-Coor(1,i+1)*chordroot+Coor(1,i+1)*chordkink);
    din(i-97)=sqrt(crefin(i-97)^2+6.048^2);
end

for i = 1:length(Coor)
    if (0.175 <= Coor(1,i))&&(Coor(1,i) <= 0.575)
    tankcoor(1,j)=Coor(1,i);
    tankcoor(2,j)=Coor(2,i);
    j=j+1;
    end
end
j=1;
for i = ceil(length(Coor)/2):length(Coor)
    if (0.175 <= Coor(1,i))&&(Coor(1,i) <= 0.575)
    douttank(j)=dout(i-98);
    dintank(j)=din(i-98);
    j=j+1;
    end

end


A1=zeros(1,floor(length(tankcoor)/2));
A2=zeros(1,floor(length(tankcoor)/2));
A3=zeros(1,floor(length(tankcoor)/2));
Vout=zeros(1,floor(length(tankcoor)/2));
Vin=zeros(1,floor(length(tankcoor)/2));



for i = 1:(floor(length(tankcoor)/2))
    h1=tankcoor(2,i)+abs(tankcoor(2,(end+1-i)));
    h2=tankcoor(2,i+1)+abs(tankcoor(2,(end-i)));
    h=(h1+h2)/2;
    l=tankcoor(1,i)-tankcoor(1,(i+1));
    A3(i)=(h*chordtankmax)*(l*chordtankmax);
    A2(i)=(h*chordkink)*(l*chordkink);
    A1(i)=(h*chordroot)*(l*chordroot);
    Vout(i)=(douttank(i)/3)*(A3(i)+A2(i)+sqrt(A3(i)*A2(i)));
    Vin(i)=(dintank(i)/3)*(A3(i)+A2(i)+sqrt(A3(i)*A2(i)));
end

n=(length(tankcoor)-1);
disp(sum(A1))
disp(sum(A2))
disp(sum(A3))
V=((n*bout)/12)*(sum(A2)^2+(sum(A2)*sum(A3))+(sum(A3)^2))*(1/tand(pi/n))+((n*6.048)/12)*(sum(A1)^2+(sum(A1)*sum(A2))+(sum(A2)^2))*(1/tand(pi/n))







