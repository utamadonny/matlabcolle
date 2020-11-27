% mu-synthesis of the Two-Wheeled Robot Control System
%
% closed-loop connection for the discrete-time system
Ts = 4.0*10^(-3);
[Mat,Delta,blkstruct] = lftdata(sys_ic);
M_d = c2d(Mat,Ts);
dsys_ic = lft(Delta,M_d);
nmeas = 9;
ncont = 2;
%
fv = linspace(0,pi/Ts,200);
opt = dkitopt('FrequencyVector',fv, ...
              'DisplayWhileAutoIter','on', ...
              'NumberOfAutoIterations',5)
[Kd,dclp] = dksyn(dsys_ic,nmeas,ncont,opt);
omega = logspace(-3,log10(pi/Ts),200);
figure(1)
clf
sigma(dclp,'r-',omega), grid
title('Full cost')
disp(' ')
get(Kd)
disp(' ')
[A_h,B_h,C_h,D_h] = ssdata(Kd);