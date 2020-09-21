%Menampilkan sinyal dengan derau dan hasil FFT
n = 0:255;
N = 256;
T = 1/N;
derau = randn(size(n));
x = sin(2*pi*10*n*T) + derau;
F = fft(x,N);
mag = abs(F);
subplot(211), plot(n*T,x,'*-'), grid;
xlabel('waktu'), ylabel('amplitudo');
title('Sinyal sinus + derau (acak)');
freq = (0:N/2)/(N*T);
subplot(212);
plot(freq,mag(1:length(freq)),'ro-'), grid;
xlabel('frekuensi'), ylabel('amplitudo');
title('Spektrum sinyal');
