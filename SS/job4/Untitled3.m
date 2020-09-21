clear 
clc
 
Fs=1000;
t=0:1/Fs:0.25; 
f=700;
x=sin(2*pi*t*f);
sound(x,Fs)
stem(x)