clear
clc

Fs=10;
t=(0:Fs-1)/Fs; 
s1=sin(2*pi*t*2);
subplot(231)
stem(t,s1)
axis([0 1 -1.2 1.2])

Fs=12; 
t=(0:Fs-1)/Fs; 
s2=sin(2*pi*t*2);
subplot(232)
stem(t,s2)
axis([0 1 -1.2 1.2])

Fs=14; 
t=(0:Fs-1)/Fs; 
s2=sin(2*pi*t*2);
subplot(233)
stem(t,s2)
axis([0 1 -1.2 1.2])

Fs=16; 
t=(0:Fs-1)/Fs; 
s2=sin(2*pi*t*2);
subplot(234)
stem(t,s2)
axis([0 1 -1.2 1.2])

Fs=20; 
t=(0:Fs-1)/Fs; 
s2=sin(2*pi*t*2);
subplot(235)
stem(t,s2)
axis([0 1 -1.2 1.2])

Fs=30; 
t=(0:Fs-1)/Fs; 
s2=sin(2*pi*t*2);
subplot(236)
stem(t,s2)
axis([0 1 -1.2 1.2])