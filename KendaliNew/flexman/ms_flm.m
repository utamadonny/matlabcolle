% mu-synthesis of the flexible manipulator system
% with noncollocated controller
%
nmeas = 3;
ncont = 1;
mu_ic = usubs(sys_ic,'m_L','Nom');
fv = logspace(-1,3,100);
opt = dkitopt('FrequencyVector',fv,...
              'DisplayWhileAutoIter','on',...
              'NumberOfAutoIterations',3)
[K_mu,CL_mu,bnd_mu,dkinfo] = dksyn(mu_ic,nmeas,ncont,opt);
K = K_mu;
[Ak,Bk,Ck,Dk] = ssdata(K);