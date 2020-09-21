n = 0:150;
T = 0.2; % periode sampling
f1 = 1/(2*pi); f2 = 5/(2*pi); % frekuensi sinyal (Hz)
x = cos(2*pi*f1*T*n) + cos(2*pi*f2*T*n); % sinyal input
subplot(211), plot(n*T,x), grid;
title('sinyal sebelum difilter');
xlabel('waktu'), ylabel('simpangan');
[z,p,k] = buttap(3); % orde filter IIR = 3;
[num,den] = zp2tf(z,p,k);
wc = 2; % frekuensi cutoff (rad/detik)
[n1,d1] = lp2lp(num,den,wc);
[nd,dd] = bilinear(n1,d1,1/T);
% frekuensi digital = wc * T
y1 = filter(nd,dd,x);
subplot(223), plot(n*T,y1), grid;
xlabel('waktu'), ylabel('simpangan');
title('hasil LPF IIR orde 3');
omegac = 0.4; % frekuensi cut-off digital
N = 21; % orde filter FIR
m = (N-1)/2; % penggeseran
h = omegac/pi * sinc(omegac*(n-m)/pi);
w = [ones(1,N) zeros(1, length(n)-N)]; % window
hd = h .* w;
y2 = filter(hd,1,x); % sinyal output
subplot(224), plot(n*T,y2), grid;
title('hasil LPF FIR orde 120');
xlabel('waktu'), ylabel('simpangan');
