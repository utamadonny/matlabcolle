[y1,Fs]=audioread('Alarm05.wav');
Fs=8192;
sound(y1,Fs)
amp=0.1;
y2=amp*y1;
sound(y2,Fs);
subplot(251);
plot(y1)
subplot(256);
plot(y2)

amp=0.5;
y2=amp*y1;
sound(y2,Fs);
subplot(252);
plot(y1)
subplot(257);
plot(y2)

amp=1;
y2=amp*y1;
sound(y2,Fs);
subplot(253);
plot(y1)
subplot(258);
plot(y2)

amp=1.5;
y2=amp*y1;
sound(y2,Fs);
subplot(254);
plot(y1)
subplot(259);
plot(y2)

amp=2;
y2=amp*y1;
sound(y2,Fs);
subplot(255);
plot(y1)
subplot(2,5,10);
plot(y2)