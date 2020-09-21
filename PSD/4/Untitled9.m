%fungsi FFT
N = 256;
T = 1/512;
n = 0:N-1;
A = input('Amplitudo untuk f = 10 Hz : ');
B = input('Amplitudo untuk f = 40 Hz : ');
y = A*sin(2*pi*10*n*T) + B*sin(2*pi*40*n*T);
F = fft(y);
mag = abs(F);
subplot(211);
plot(n*T,y,'-o'), grid;
xlabel('waktu'), ylabel('amplitudo');
title('Sinyal Sinus gabungan');
freq = (0:63)/(N*T);
subplot(212);
plot(freq,mag(1:length(freq)),'r-.'), grid;
xlabel('frekuensi (Hz)'), ylabel('amplitudo');
title('Spektrum sinyal sinus gabungan');
