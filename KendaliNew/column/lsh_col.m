% Loop Shaping Design of the Distillation Column
% 1-degree of freedom controller
mod_col
%
% set the precompensator
nuW1 = [1.1   1];
dnW1 = [10    0];
gainW1 = 1.7;

w1 = gainW1*tf(nuW1,dnW1);
W1 = blkdiag(w1,w1);
%
% compute the loop shaping controller
[K_0,cl,gam,info] = ncfsyn(G,W1);
emax = info.emax;
disp(['The nugap robustness emax = ' num2str(emax)]);
%
% frequency responses of the plant and shaped plant
Gs = info.Gs;
omega = logspace(-4,2,100);
figure(1)
sigma(G,'b-',Gs,'r--',omega), grid
xlabel('Frequency (rad/min)'), ylabel('Magnitude')
title('Frequency responses of the original plant and shaped plant')
legend('Original plant','Shaped plant')
%
% construct the negative feedback controller
K_lsh = -K_0; K = K_lsh;