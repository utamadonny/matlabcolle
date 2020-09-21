%Tanggapan Waktu Dari Sistem Diskrit Untuk Periode Sampling Yang
%Berbeda

Ts1=0.5;%periode sampling 0,5
n1=0:Ts1:25;
Ts2=2;%periode sampling 2
n2=0:Ts2:25;
num =[1 1];
den =[1 0.5 1];
[nd1,dd1]=c2dm(num,den,Ts1,'zoh');
[nd2,dd2]=c2dm(num,den,Ts2,'zoh');
sys1=tf(nd1,dd1,Ts1);
sys2=tf(nd2,dd2,Ts2);
sys_1=feedback(sys1,0.1);
sys_2=feedback(sys2,0.1);
[numd1,dend1]=tfdata(sys_1,'v');
[numd2,dend2]=tfdata(sys_2,'v');
xd1=ones(size(n1));
z1=filter(numd1,dend1,xd1);
subplot(211),plot(n1,xd1,n1,z1,'o-'),grid;
xd2=ones(size(n2));
z2=filter(numd2,dend2,xd2);
subplot(212),plot(n2,xd2,n2,z2,'o-'),grid;
