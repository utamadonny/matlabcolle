%Program P2_1
%Ilustrasi dalam proses sampling domain waktu
clf;
F=200;
t=0:1/F:1;
f=13;
xa=cos(2*pi*f*t);
subplot(211)
plot(t,xa); grid;
xlabel('time, msec'); ylabel('Amplitudo');
title('Countinous time signal x_{a}{t}');
axis([0 1 -1.2 1.2])
subplot(212)
F=400;
n=0:1/F:1;
xs=cos(2*pi*f*n);
k= 0:length(n)-1;
stem(k,xs);grid;
xlabel('time Index'); ylabel('Amplitudo');
title('diskrit time signal x_{a}{t}');
axis([0 length(n) -1.2 1.2])
