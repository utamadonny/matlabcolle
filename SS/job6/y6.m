clear all
[y,Fs]=audioread('gundul.wav')
Fs=16000;
%sound(y,Fs)
subplot(211)
plot(y)
subplot(212)
Y=fft(y);
plot((abs(Y(1:4000))))