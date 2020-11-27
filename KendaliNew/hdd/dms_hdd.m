% mu-synthesis of the discrete-time Hard Disk Drive Servo System
%
nmeas = 1;
ncont = 1;
mu_ic = usubs(dsys_ic,'J','nom', ...
                      'w1','nom','w2','nom','w3','nom','w4','nom', ...
                      'z1','nom','z2','nom','z3','nom','z4','nom');
opt = dkitopt('DisplayWhileAutoIter','on', ...
              'NumberOfAutoIterations',6)
[K_dmu,CL_mu,bnd_mu,dkinfo] = dksyn(mu_ic,nmeas,ncont,opt);
KD = K_dmu;