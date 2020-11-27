% H_infinity design of the triple inverted pendulum
%
nmeas = 6;
ncon = 2;
gmin = 0;
gmax = 10;
tol = 0.001;
hin_ic = pvget(pend_ic,'NominalValue');
[K_hin,clp,gfin] = hinfsyn(hin_ic,nmeas,ncon,gmin,gmax,tol);
sigma(clp), grid
title('Singular value plot of clp')
K = K_hin;