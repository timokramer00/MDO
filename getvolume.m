function[Vtank] = getvolume(cr,TRi,TRo,b)

LEsweep=atan((cr-cr*TRi)/8.64);
Geom=[0     0     0     cr         0;
      8.64*tan(LEsweep)  8.64   0     cr*TRi+0.001         0;
      b*tan(LEsweep)  b  0  (cr*TRi)*TRo  0];



fid= fopen('airfoil1.dat','r'); % Filename can be changed as required
Coor = fscanf(fid,'%g %g',[2 Inf]) ; 
fclose(fid) ;


tankmaxo=0.85*b-8.64;
bout=b-8.64;
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

    crefin(1)=8.64*tan(LEsweep);
    din(1)=sqrt((crefin(1))^2+8.64^2);
    crefin(i-97)=abs(crefin(i-98)-Coor(1,i+1)*chordroot+Coor(1,i+1)*chordkink);
    din(i-97)=sqrt(crefin(i-97)^2+8.64^2);
end

for i = 1:length(Coor)
    if (tanklb <= Coor(1,i))&&(Coor(1,i) <= tankub)
    tankcoor(1,j)=Coor(1,i);
    tankcoor(2,j)=Coor(2,i);
    j=j+1;
    end
end
j=1;
for i = ceil(length(Coor)/2):length(Coor)
    if (tanklb <= Coor(1,i))&&(Coor(1,i) <= tankub)
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
    h1=abs(tankcoor(2,i))+abs(tankcoor(2,(end+1-i)));
    h2=abs(tankcoor(2,i+1))+abs(tankcoor(2,(end-i)));
    h=(h1+h2)/2;
    l=abs(tankcoor(1,i)-tankcoor(1,(i+1)));
    A3(i)=(h*chordtankmax)*(l*chordtankmax);
    A2(i)=(h*chordkink)*(l*chordkink);
    A1(i)=(h*chordroot)*(l*chordroot);
    Aout=(A3(i)+A2(i))/2;
    Ain=(A2(i)+A1(i))/2;
    Vout(i)=douttank(i)*Aout;
    Vin(i)=dintank(i)*Ain;
end



Vtank=sum(Vout)+sum(Vin);







