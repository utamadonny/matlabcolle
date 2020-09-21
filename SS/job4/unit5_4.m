[Y,Fs]=audioread('gundul.wav');
Fs=16000;
%sound(Y,Fs)

noise=randn(length(Y),1)
Y_noise=Y+0.08*noise;
%sound(Y_noise,Fs)

satu=ones(4,1);

Y_c=conv(satu,Y_noise);
%sound(Y_c,Fs)
subplot(311);
plot(Y)
subplot(312);
plot(Y_noise)
subplot(313);
plot(Y_c)