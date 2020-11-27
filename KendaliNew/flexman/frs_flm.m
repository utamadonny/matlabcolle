% Frequency responses of the flexible manipulator system
%
% Controller inputs:  1)  ref
%                     2)  theta + noise1
%                     3)  d2alpha/dt2 + noise2 
%
% closed-loop interconnection
sim_flm
clp = lft(sim_ic,K,1,3);
%
% closed-loop frequency response
ref_loop = clp(1,1); % from ref to alpha
omega = logspace(0,3,100);
figure(1)
bode(ref_loop,'b-',Wm,'r--',omega), grid
title('Bode plot of the closed-loop system')
legend('Closed-loop system','Model',3)
%
% wL frequency response
wl_loop = clp(4,1); % from ref to wL
omega = logspace(-1,3,100);
figure(2)
bode(wl_loop,omega), grid
title('wL frequency response')
%
% output sensitivity to the disturbance
sen_loop = clp(1,2); % from dist to alpha
omega = logspace(-3,3,300);
figure(3)
bodemag(sen_loop,'r',omega), grid
title('Sensitivity to the disturbance')
%
% output sensitivity to the noise 1
noise1_loop = clp(1,3); % from noise1 to alpha
omega = logspace(-2,3,100);
figure(4)
bodemag(noise1_loop,'r-',omega), grid
title('Sensitivity to the noise 1')
%
% output sensitivity to the noise 2
noise2_loop = clp(1,4); % from noise2 to alpha
omega = logspace(-2,3,100);
figure(5)
bodemag(noise2_loop,'r-',omega), grid
title('Sensitivity to the noise 2')
%
% controller frequency responses
K_1 = K(1,1);
K_2 = K(1,2);
K_3 = K(1,3);
omega = logspace(-3,3,300);
figure(6)
bode(K_1,'r-',K_2,'b--',K_3,'m-.',omega), grid
title('Controller Bode plot')
legend('K_{ r}','K_{ \vartheta}','K_{ d^2\alpha/dt^2}',3)
%
% open-loop frequency response
G_theta_u = sim_ic([6:8],5);
L = K*G_theta_u;
omega = logspace(-2,3,100);
figure(7)
bode(L,omega), grid
title('Open-loop Bode plot')