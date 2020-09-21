%Program P2_3
%Ilustrasi efek aliasing dalam domain frekuensi
clf;
t=0:0.005:10;
xa=2*t.*exp(-t);
subplot(221)
plot(t,xa); grid;
xlabel('time, msec'); ylabel('Amplitudo');
title('Countinous time signal x_{a}{t}');

subplot(222)
wa=0:10/511:10;
ha=freqs(2,[1 2 1],wa);
plot(wa/(2*pi),abs(ha));grid;
xlabel('Frequency, kHz'); ylabel('Amplitudo');
title('X_{a}(j/Omega)');
axis([0 5/pi 0 1.2])
subplot(223)

T=1;
n=0:T:10;
xs=2*n.*exp(-n);
k= 0:length(n)-1;
stem(k,xs);grid;
xlabel('time Index n'); ylabel('Amplitudo');
title('diskrit time signal x[n]');

subplot(224)
wd=0:10/511:10;
hd=freqz(xs,1,wd);
plot(wd/(T*pi),T*abs(hd));grid;
xlabel('Frequency, kHz'); ylabel('Amplitudo');
title('X_(e^(j/Omega)');
axis([0 1/T 0 2])