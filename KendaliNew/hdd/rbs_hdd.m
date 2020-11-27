% Robust stability of the closed-loop system
% for the Hard Disk Drive System
%
w = logspace(2,5,100);
%
% mu-controller
clp_mu = lft(sys_ic,K_mu);
[M,Delta,blkstruct] = lftdata(clp_mu);
Mfrd = frd(M,w);
rbnds_mu = mussv(Mfrd(1:15,1:15),blkstruct);
%
% Hinf controller
clp_hin = lft(sys_ic,K_hin);
[M,Delta,blkstruct] = lftdata(clp_hin);
Mfrd = frd(M,w);
rbnds_hin = mussv(Mfrd(1:15,1:15),blkstruct);
%
% Loop Shaping controller
clp_lsh = lft(sys_ic,K_lsh);
[M,Delta,blkstruct] = lftdata(clp_lsh);
Mfrd = frd(M,w);
rbnds_lsh = mussv(Mfrd(1:15,1:15),blkstruct);
%
figure(1)
semilogx(rbnds_mu(:,1),'r-',rbnds_hin(:,1),'b--',rbnds_lsh(:,1),'m-.')
grid
xlabel('Frequency (rad/sec)')
ylabel('Upper bound of \mu')
title('Robust stability for three controllers')
legend('\mu-controller','H_\infty controller','Loop Shaping controller',2)