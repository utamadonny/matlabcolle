clear
clc

T=100;
t=0:1/T:2;
f1=1;
a2=input('nilai pengali yangd digunakan (>0):  ');
y1=a2*sin(2*pi*t);
subplot(3,1,1)
plot(t,y1)

a=input('nilai pengali yangd digunakan (>0):  ');
y2=a*sin(2*pi*t);
subplot(3,1,2)
plot(t,y2)

a1=input('nilai pengali yangd digunakan (>0):  ');
y3=a1*sin(2*pi*t);
subplot(3,1,3)
plot(t,y3)