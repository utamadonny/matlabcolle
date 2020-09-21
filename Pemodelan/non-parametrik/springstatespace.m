%system parameters
k1=5;
k2=7;
m1=2;
m2=3;
d1=40;
d2=30;

%systems state space
A=[0 1 0 0; -k1/m1 -d1/m1 k1/m1 d1/m1; 0 0 0 1; k1/m2 d1/m2 -(k1+k2)/m2 -(d1+d2)/m2];
B=[0; 1/m1; 0; 0];
C=[0 0 0 1];
D=[0];

SS=ss(A,B,C,D);
tfc= tf(SS);
Ts=3;
DSS=c2d(SS,Ts);

% 
tfd= tf(DSS)
% impulse 
[ImportY,ImportT]=impulse(tfd,299)
opts = timeoptions;
opts.Grid = 'on';
impulseplot(tfd,opts)