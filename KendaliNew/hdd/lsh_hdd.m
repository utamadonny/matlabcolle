% Loop Shaping Design for the Hard Disk Drive System
%
mod_hdd
%
% set the precompensator
nuW1 = [0.05 1];
dnW1 = [1 0];
gainW1 = 4;
W1 = gainW1*tf(nuW1,dnW1);
%
% compute the loop shaping controller
[K_0,cl,gam,info] = ncfsyn(G(1,2).Nom,W1);
emax = info.emax;
disp(['The nugap robustness emax = ' num2str(emax)]);
%
% frequency responses of the plant and shaped plant
Gs = info.Gs;
w = logspace(-1,5,400);
figure(1)
bodemag(G(1,2).Nom,'b-',Gs,'r--',w), grid
title('Frequency responses of the plant and shaped plant')
legend('Original plant','Shaped plant')
%
% obtain the negative feedback controller
K_lsh = -K_0; K = K_lsh;