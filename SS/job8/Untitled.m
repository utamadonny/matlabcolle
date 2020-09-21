clear
clc 
syms t;
x=exp(-t);
y=x*cos(10*t);
X=laplace(x)
Y=laplace(y)

figure;
subplot(221);
ezplot(x,[0,5]);
grid
axis([0 5 0 1.1])
title('x(t)=exp(-t)u(t)')
subplot(222)
numx=[0,1]; denx=[1 1];
sys=tf(numx,denx);
pzmap(sys)

subplot(223)
ezplot(y,[-1,5]);grid;
axis([0 5 -1.1 1.1]); 
title('y(t)=cos(10t)exp(-t)u(t)')
numy=[0 1 1]; deny=[1 2 101];
sys2=tf(numy,deny)
subplot(224)
pzmap(sys2)


