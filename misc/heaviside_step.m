clc
clear

t=-20:0.001:20;
y=heaviside(t);

plot(t,y)
axis([-10 10 -2 2])
