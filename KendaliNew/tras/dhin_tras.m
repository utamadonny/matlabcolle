% H_infinity design of Twin-Rotor Aerodynamic System
%
hin_ic = sys_ic.Nominal;
Ts = 0.01; % s
dhin_ic = c2d(hin_ic,Ts);
nmeas = 4;
ncont = 2;
gmin = 0.1;
gmax = 100;
tol = 0.001;
[DK_hin,clp,gopt] = hinfsyn(dhin_ic,nmeas,ncont,gmin,gmax,tol);
disp(' ')
get(DK_hin)
disp(' ')
disp('Closed-loop poles')
sp = pole(clp)
omega = logspace(-3,log10(pi/Ts),100);
sigma(clp,'m-',omega), grid
title('Singular Value Plot of clp')
xlabel('Frequency (rad/min)')
ylabel('Magnitude')
Kd = DK_hin;