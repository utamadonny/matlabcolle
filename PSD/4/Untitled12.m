%f.	Analisa spektrum audio
[y,fs] = audioread('WindowsLogon.wav');
T = 1/fs;
N = length(y);
t = (0:N-1)*T;
subplot(211), plot(t,y), grid;
xlabel('waktu');
ylabel('amplitudo');
title('Tampilan sinyal');
Y = fft(y);
mag = abs(Y);
freq = (0:(N/2)-1)/(N*T);
subplot(212), plot(freq,mag(1:N/2)), grid;
xlabel('frekuensi');
ylabel('magnitude');
title('Spektrum sinyal');
