t=0:0.001:2;
f1=2;
f2=30;%dalam Hz
x=sin(2*pi*f1*t)+sin(2*pi*f2*t);
subplot(211), plot(t,x), grid;
xlabel('waktu(det)'),ylabel('simpangan');
title ('sinyal sebelum di filter');
[z,p,k]=buttap(2);
[n,d]=zp2tf(z,p,k);
fc=5;%dalam Hz
wc=2*pi*fc;%frekuensi cutoff baru dalam rad/det
[n1,d1]=lp2lp(n,d,wc);
sys=tf(n1,d1);
y=lsim(sys,x,t);
subplot(212),plot(t,y),grid;
xlabel('waktu (det)');
ylabel('simpangan');
title('Sinyal setelahh diFilter');