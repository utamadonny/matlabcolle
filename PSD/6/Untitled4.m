[z,p,k]=buttap(3);
[num,den]=zp2tf(z,p,k);
fc=2; %frek cutoff dalam HZ
wc=2*pi*fc;%frekuensi cutoff baru dalam rad/det
[n1,d1]=lp2lp(num,den,wc);
fs=50; %frek sampling
points=512;
[nd,dd]=bilinear(n1,d1,fs);
[h,w]=freqz(nd,dd,points,fs);
[h3,w]=freqz(0.707,1,points,fs);

subplot(121), plot(w,h3,w,abs(h)),grid;
xlabel('frekuensi (Hz)');
ylabel('magnitude');
title('Diagram Bode Filter');

mag=20*log10(abs(h));
m3=20*log10(h3);
subplot(122), semilogx(w,m3,w,mag), grid;
xlabel('frekuensi (Hz)');
ylabel('magnitude(dB)');
title('Diagram Bode Filter');