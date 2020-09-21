T=100;
t=0:1/T:2;
f1=1;
y1=sin(2*pi*t);

plot(t,y1)
hold on
y2=4*sin(2*pi*t);
plot(t,y2)
hold off