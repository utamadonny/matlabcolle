%Tanggapan Waktu Dari Sistem Diskrit
zeta =0.7; %koef redaman
Ts = 0.5;
num =1 ;
den=[1, 2*zeta,1]; %system orde2
sys=tf(num,den);
t=0:Ts:19;
x=ones(size(t));
z=lsim(sys,x,t);
subplot(211), plot(t,x,t,z),grid;
[nd,dd]=c2dm(num,den,Ts,'zoh');
n=0:Ts:19;
xd=ones(size(n));
z1=filter(nd,dd,xd);
subplot(212), plot(n,xd,n,z1,'o-'), grid;