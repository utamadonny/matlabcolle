% H_infinity design for the flexible manipulator
%
% Controller inputs:  1)  ref
%                     2)  theta + noise1
%                     3)  d2alpha/dt2 + noise2 
%
nmeas = 3;
ncon = 1;
gmin = 0.1;
gmax = 10;
tol = 0.001;
hin_ic = sys_ic.Nominal;
[K_hin,clp,gopt] = hinfsyn(hin_ic,nmeas,ncon,gmin,gmax,tol);
gamma = 1.1*gopt;
[K_hin,clp] = hinfsyn(hin_ic,nmeas,ncon,gamma,gamma,tol);
disp(' ')
get(K_hin)
disp(' ')
disp('Controller poles')
sp = pole(K_hin)
omega = logspace(-6,4,500);
sigma(clp,'r-'), grid
title('Singular Value Plot of clp')
K = K_hin;