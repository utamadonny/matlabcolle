[z,p,k]=buttap(2);
[n,d]=zp2tf(z,p,k);
fc=5;%dalam Hz
wc=2*pi*fc;%frekuensi cutoff baru dalam rad/det
[n1,d1]=lp2lp(num,den,wc);
w=logspace(-1,3);
[mag,phase]=bode(n1,d1,w);
[m1,ph1]=bode(0.707,1,w);
logmag=20*log10(mag);
logm1=20*log10(m1);%garis -3dB
semilogx(w,logm1,w,logmag),grid;
xlabel('frekuensi (rad/det)');
ylabel('magnitude(dB)');
title('Diagram Bode Filter');