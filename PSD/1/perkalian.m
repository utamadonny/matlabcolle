% sinyal sinus 5 Hz * 100 Hz
n=0:199;
T=0.002;
y=sin(2*pi*5*n*T);
z=sin(2*pi*100*n*T);
x=y.*z;
figure(1);
plot(n*T,x,'k'), grid;

% sinyal sinus 5 Hz + random
n=0:199;
T=0.002;
y=sin(2*pi*5*n*T)+randn(size(n));
figure(2);
stem(n*T,y,'k'), grid;

% sinyal kosinus 3 Hz * kotak 20 Hz
n=0:199;
T=0.002;
y=sin(2*pi*3*n*T);
z=square(2*pi*20*n*T);
x=y.*z;
figure(3);
stem(n*T,x,'k'), grid;
