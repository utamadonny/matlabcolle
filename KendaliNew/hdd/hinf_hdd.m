% H_infinity design for the Disk Drive System
%
nmeas = 1;
ncon = 1;
gmin = 0;
gmax = 10;
tol = 0.001;
hin_ic = sys_ic.Nom;
[K_hin,clp_hin,gopt] = hinfsyn(hin_ic,nmeas,ncon,gmin,gmax,tol);
gmin = 1.1*gopt;
[K_hin,clp_hin,gfin] = hinfsyn(hin_ic,nmeas,ncon,gmin,gmin,tol);
disp(' ')
get(K_hin)
disp(' ')
disp('Closed-loop poles')
sp = pole(clp_hin)
omega = logspace(-2,6,100);
sigma(clp_hin,omega)
title('Singular Value Plot of clp')
xlabel('Frequency (rad/sec)')
ylabel('Magnitude')
K = K_hin;