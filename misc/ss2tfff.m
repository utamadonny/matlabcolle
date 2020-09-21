clear 
clc
%Input argumen dari SS
A=[0 1; -0.005 -0.15];
B=[0; 0.1];
C=[1 0];
D=[0];
%ss ke fungsi alih
SS=ss(A,B,C,D);
Ts=2;
discreateSS=c2d(SS,Ts);
%hasil tf
%tfc=tf(Y,U);
tfd=tf(discreateSS)