% sinyal sinus 10 Hz
n=0:199;
T=0.002;
x=sin(2*pi*50*n*T);
plot(n*T,x,'k'), grid;