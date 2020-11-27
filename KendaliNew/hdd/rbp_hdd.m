% Robust performance comparison for three  controllers
%
w = logspace(2,5,100);
rp = ucomplexm('rp',zeros(3,2));
%
% mu-controller
clp_mu = lft(sys_ic,K_mu,1,1);
clp2 = lft(clp_mu,rp);
[M,Delta,blkstruct] = lftdata(clp2);
Mfrd = frd(M,w);
bnd_mu = mussv(Mfrd(1:17,1:18),blkstruct);
%
% H_infinity controller
clp_hin = lft(sys_ic,K_hin,1,1);
clp2 = lft(clp_hin,rp);
[M,Delta,blkstruct] = lftdata(clp2);
Mfrd = frd(M,w);
bnd_hin = mussv(Mfrd(1:17,1:18),blkstruct);
%
% Loop Shaping controller
clp_lsh = lft(sys_ic,K_lsh,1,1);
clp2 = lft(clp_lsh,rp);
[M,Delta,blkstruct] = lftdata(clp2);
Mfrd = frd(M,w);
bnd_lsh = mussv(Mfrd(1:17,1:18),blkstruct);
%
figure(1)
loglog(bnd_mu(:,1),'r-',bnd_hin(:,1),'b--',bnd_lsh(:,1),'m-.')
grid
xlabel('Frequency (rad/sec)')
ylabel('Upper bound of \mu')
title('Robust performance for three controllers')
legend('\mu-controller','H_\infty controller','Loop Shaping controller',1)