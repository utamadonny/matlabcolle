orde=input('masukan orde dari filter prototipe:');
[z,p,k]=buttap(orde);
[num,den]=zp2tf(z,p,k);
w=logspace(-1,2);
[mag,phase]=bode(num,den,w);
[m1,ph1]=bode(0.707,1,w);
logmag=20*log10(mag);
logm1=20*log10(m1);%garis -3dB
semilogx(w,logm1,w,logmag),grid;
xlabel('frekuensi (rad/det)');
ylabel('magnitude(dB)');
title('Diagram Bode Filter Prototype');
