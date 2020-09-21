%fungsi DFT
T = 0.01;
n = 0:100;
f1 = 10; f2 = 40; % frekuensi dalam Hz
y = sin(2*pi*f1*n*T) + sin(2*pi*f2*n*T);
N = length(y);
F = fft(y); % harus sudah dibuat
mag = abs(F);
fase = angle(F);
subplot(211), plot(n*T,y,'k-*'), grid;
xlabel('Waktu'), ylabel('Amplitudo');
title('Sinyal sinus gabungan');
frek = (0:N/2-1)/(N*T);
subplot(223);
plot(frek,mag(1:N/2),'r-o'), grid;
xlabel('Frekuensi (Hz)'), ylabel('Magnitude');
set(gca,'XTick',[f1 f2]);
subplot(224);
plot(frek,fase(1:N/2)*180/pi,'b-s'), grid;
xlabel('Frekuensi (Hz)'), ylabel('Sudut fase');
set(gca,'XTick',[f1 f2]);
