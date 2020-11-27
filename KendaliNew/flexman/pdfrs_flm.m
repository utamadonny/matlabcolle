% Frequency responses of the flexible manipulator system
% with PD controller
%
% Controller inputs:  2)  ref
%                     2)  theta + noise 
%
mod_flm
%
% Actuator transfer function
nuWa = 1;
dnWa = [0.003   1];
gainWa = 1;
Wa = gainWa*tf(nuWa,dnWa);
%
% construct weighting functions
wts_flm
%
% PD controller
% 
% PD coefficients
Kp = nd2sys(358,1);
Kd = nd2sys(28.5,1);
Td = 0.002;
%
K_ref = Kp;
nuWth = [(Kd + Kp*Td)  Kp];
dnWth = [Td  1];
gainWth = -1;  % negative feedback
K_theta = gainWth*tf(nuWth,dnWth);
K = ss([K_ref K_theta]);
%
% Generates the open-loop connection 
systemnames = ' G Wa Wn1 ';
inputvar = '[ ref; dist; noise; control ]';
temp = '[ G(1); G(2); G(3); G(4); ';
outputvar = [temp ' control; ref; G(2) + Wn1 ]'];
input_to_G = '[ Wa - dist ]';
input_to_Wa = '[ control ]';
input_to_Wn1 = '[ noise ]';
sim_ic = sysic;
outputs = {'alpha' 'theta' 'ddalpha' 'wL' 'control' 'ref' 'y_s(1)'};
sim_ic.OutputName = outputs;
%
% closed-loop interconnection
clp = lft(sim_ic,K,1,2);
%
% closed-loop frequency response
ref_loop = clp(1,1); % from ref to alpha
omega = logspace(0,3,100);
figure(1)
bode(ref_loop,omega), grid
title('Bode plot of the closed-loop system')
%
% wl frequency response
wl_loop = clp(4,1);  % from ref to wl
omega = logspace(-1,3,100);
figure(2)
bode(wl_loop,omega), grid
title('wl frequency response')
%
% output sensitivity to the disturbance
sen_loop = clp(1,2); % from dist to alpha
omega = logspace(-3,3,300);
figure(3)
bodemag(sen_loop,'r',omega), grid
title('Sensitivity to the disturbance')
%
% output sensitivity to the noise
noise1_loop = clp(1,3); % from noise to alpha
omega = logspace(-2,3,100);
figure(4)
bodemag(noise1_loop,'r-',omega), grid
title('Sensitivity to the noise')
%
% controller frequency responses
K_1 = K(1,1);
K_2 = K(1,2);
omega = logspace(-2,4,300);
figure(5)
bode(K_1,'r-',K_2,'b-.',omega), grid
title('Controller Bode plot')
legend('K_{ u r}','K_{ u \vartheta}',2)
%
% open-loop frequency response
G_theta_u = sim_ic([6,7],4);
L = K*G_theta_u;
omega = logspace(-2,3,100);
figure(6)
bode(L,omega), grid
title('Open-loop Bode plot')