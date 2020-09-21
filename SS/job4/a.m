clear,clc;
t = [0:.000125:.50];

A = sin(2*pi*294*t);
B = sin(2*pi*330*t);
C = sin(2*pi*349*t);
D = sin(2*pi*392*t);
E = sin(2*pi*523*t);
F = sin(2*pi*466*t);
G = sin(2*pi*262*t);
G1= sin(2*pi*440*t);

line1 = [G,G,A,G,C,B];
line2 = [G,G,A,G,D,C];
line3 = [G,G,E,G1,C,B,A];
line4 = [F,F,E,C,D,C];


song  =  [line1,line2,line3,line4];
sound(song)
stem(song)
axis([0 50 -5 5])
