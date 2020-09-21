N = 31; % orde filter
omegac = 0.8; % frekuensi cut-off digital
wn = omegac/pi;
b1 = fir1(N,wn); % function untuk mendesain filter FIR
[H,omega] = freqz(b1,1);
fase = 180/pi * angle(H);
subplot(221), plot(omega,0.707,omega,abs(H)), grid;
xlabel('frekuensi'), ylabel('magnitude');
subplot(222), plot(omega,unwrap(fase)), grid;
xlabel('frekuensi'), ylabel('sudut fase');
% *** Desain filter FIR secara sederhana ***
m = (N-1)/2; % penggeseran
n = 0:2*m; % penetapan titik untuk plot
h = omegac/pi * sinc(omegac*(n-m)/pi);
w = [ones(1,N) zeros(1,length(n)-N)]; % window
hd = h .* w;
[Hd,omega1] = freqz(hd,1);
fase1 = 180/pi * angle(H);
subplot(223), plot(omega1,0.707,omega1,abs(Hd)), grid;
xlabel('frekuensi'), ylabel('magnitude');
subplot(224), plot(omega1,unwrap(fase1)), grid;
xlabel('frekuensi'), ylabel('sudut fase');
