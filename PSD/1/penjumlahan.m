% sinyal sinus 10 Hz + 100 Hz
n=0:199;
T=0.002;
y=sin(2*pi*10*n*T);
z=sin(2*pi*50*n*T);
x=y+z;
stem(n*T,x,'k'), grid;