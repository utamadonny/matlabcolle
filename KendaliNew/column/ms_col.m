% Mu-synthesis of the Distillation Column system
%
% 1 dof controller
%nmeas = 2;
%ncont = 2;
%sys_ic = sys_ic_1dof;
% 2 dof controller;
nmeas = 4;
ncont = 2;
sys_ic = sys_ic_2dof;
%
fv = logspace(-3,3,100);
opt = dkitopt('FrequencyVector',fv, ...
              'DisplayWhileAutoIter','on', ...
              'NumberOfAutoIterations',3)
[K_mu,CL_mu,bnd_mu,dkinfo] = dksyn(sys_ic,nmeas,ncont,opt);
K = K_mu;