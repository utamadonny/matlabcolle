% H_infinity design for the Distillation Column system
%
% 1 dof controller
%nmeas = 2;
%ncont = 2;
%sys_ic = sys_ic_1dof;
% 2 dof controller;
nmeas = 4;
ncont = 2;
sys_ic = sys_ic_2dof;
gmin = 0.1;
gmax = 10;
tol = 0.001;
[hin_ic,Delta] = lftdata(sys_ic);
[K_hin,clp,gopt] = hinfsyn(hin_ic,nmeas,ncont,gmin,gmax,tol);
disp(' ')
get(K_hin)
disp(' ')
disp('Closed-loop poles')
sp = pole(clp)
omega = logspace(-2,6,100);
sigma(clp,'m-',omega), grid
title('Singular Value Plot of clp')
xlabel('Frequency (rad/min)')
ylabel('Magnitude')
K = K_hin;