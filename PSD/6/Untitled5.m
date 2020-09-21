n=0:250;
T=0.01;
f1=2; 
f2=30; %frekuensi sinyal dalam Hz
x=sin(2*pi*f1*n*T)+sin(2*pi*f2*n*T);
subplot(211),plot(n*T,x),grid;
xlabel('waktu(detik)');
ylabel('simpangan');
title('sinyal sebelum di filter');

[z,p,k]=buttap(2);
[num,den]=zp2tf(z,p,k);
fc=5; %frek cutoff dalam HZ
wc=2*pi*fc;%frekuensi cutoff baru dalam rad/det
[n1,d1]=lp2lp(num,den,wc);
[nd,dd]=bilinear(n1,d1,1/T);
y=filter(nd,dd,x);
subplot(212), plot(n*T,y), grid;
xlabel('waktu(detik)');
ylabel('simpangan');
title('sinyal setelah di filter');
