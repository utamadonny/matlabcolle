% mu-synthesis of the triple inverted pendulum
%
nmeas = 6;
ncont = 2;
opt = dkitopt('DisplayWhileAutoIter','on', ...
              'NumberOfAutoIterations',4)
[K_mu,CL_mu,bnd_mu,dkinfo] = dksyn(pend_ic,nmeas,ncont,opt);
K = K_mu;