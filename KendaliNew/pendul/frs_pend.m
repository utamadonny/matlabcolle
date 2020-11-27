% Frequency responses of the family of perturbed closed-loop system
%
sim_pend
clp_ic = lft(pend_sm,K,2,6);
%
% singular values of the closed-loop transfer function
ref_loop = clp_ic(1:3,1:3);
omega = logspace(-4,2,400);
figure(1)
sigma(ref_loop.Nominal,'r-',ref_loop,'b--',omega);
axis([0.0001 100 -100 20])
grid
temp1 = 'Singular Value Plot of the';
temp2 = ' Closed-loop Transfer Function Matrix';
title([temp1,temp2])
legend('Nominal system','Random samples',3)
%
% singular values of the disturbance transfer function
dis_loop = clp_ic(1:3,4:6);
omega = logspace(-4,4,400);
figure(2)
sigma(dis_loop.Nominal,'r-',dis_loop,'b--',omega);
grid
title('Singular Value Plot of the Disturbance Transfer Function')
legend('Nominal system','Random samples',3)
%
% singular values of the noise transfer function
nos_loop = clp_ic(1:3,7:9);
omega = logspace(-4,4,400);
figure(3)
sigma(nos_loop.Nominal,'r-',nos_loop,'b--',omega);
axis([0.0001 10000 -200 0])
grid
title('Singular Value Plot of the Noise Transfer Function')
legend('Nominal system','Random samples',3)
%
% singular values of $T_{ur}$
ref_u = clp_ic(4:5,1:3);
omega = logspace(-4,4,400);
figure(4)
sigma(ref_u.Nominal,'r-',ref_u,'b--',omega);
grid
title('Singular Value Plot of T_{ur}')
legend('Nominal system','Random samples',3)
%
% singular values of $T_{ud}$
dist_u = clp_ic(4:5,4:6);
figure(5)
sigma(dist_u.Nominal,'r-',dist_u,'b--',omega);
grid
title('Singular Value Plot of T_{ud}')
legend('Nominal system','Random samples',3)
%
% singular values of $T_{u\eta}$
noise_u = clp_ic(4:5,7:9);
omega = logspace(-4,4,400);
figure(6)
sigma(noise_u,'r-',noise_u,'b--',omega);
grid
title('Singular Value Plot of T_{u\eta}')
legend('Nominal system','Random samples',2)
%
% singular values of the controller
omega = logspace(-4,4,400);
figure(7)
sigma(K,'r-',omega);
grid
title('Singular Value Plot of the Controller')