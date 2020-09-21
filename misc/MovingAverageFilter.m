clc
clear all
close all
t=0:0.11:20;
x=2*t-50+50*exp(-0.04*t);
n=randn(1,length(t));
x=x+n;
a=input('Enter the no.:');
t2=ones(1,a);
num=(1/a)*t2;
den=[1];
y=filter(num,den,x);
stem(x,'b');
hold on;
stem(y,'r','linewidth',2);
legend('Noisy signal','Filtered signal');
