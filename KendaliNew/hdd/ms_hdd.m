% mu-synthesis of the Disk Drive System
%
nmeas = 1;
ncont = 1;
mu_ic = usubs(sys_ic,'w1','nom','w2','nom','w3','nom','w4','nom', ...
                     'z1','nom','z2','nom','z3','nom','z4','nom')
fv = logspace(1,5,30);
opt = dkitopt('FrequencyVector',fv, ...
               'DisplayWhileAutoIter','on', ...
              'NumberOfAutoIterations',4)
[K_mu,CL_mu,bnd_mu,dkinfo] = dksyn(mu_ic,nmeas,ncont,opt);
K = K_mu;