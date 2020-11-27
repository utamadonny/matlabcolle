% Generates the open-loop connection for the
% flexible manipulator system with noncollocated
% controller and plots frequency responses
%
% Uncertain model of a flexible manipulator
mod_flm
%
% Actuator transfer function
Wa = tf(1,[0.004 1]);
%
% Performance weighting functions
wts_flm
%
% Open-loop connection with the weighting functions
systemnames = ' G Wa Wm Wn1 Wn2 Wp Wu ';
inputvar = '[ ref; dist; noise{2}; control ]';
outputvar = '[ Wp; Wu; ref; G(2) + Wn1; G(3) + Wn2 ]';
input_to_G = '[ Wa - dist ]';
input_to_Wa = '[ control ]';
input_to_Wm = '[ ref ]';
input_to_Wn1 = '[ noise(1) ]';
input_to_Wn2 = '[ noise(2) ]';
input_to_Wp = '[ G(1) - Wm ]';
input_to_Wu = '[ control ]';
sys_ic = sysic;
outputs = {'e_p' 'e_u' 'ref' 'y_s(1)' 'y_s(2)'};
sys_ic.OutputName = outputs;
%
% Frequency responses
omega = logspace(0,3,300);
figure(1)
olp_ic1 = G(1,1);  % from tau to alpha
bode(olp_ic1.Nominal,'r-',olp_ic1,'b--',omega), grid
title('Bode plots of the uncertain plant')
legend('Nominal system','Random samples',3)
%
omega = logspace(0,3,300);
figure(2)
olp_ic2 = G(2,1);  % from tau to theta
bode(olp_ic2.Nominal,'r-',olp_ic2,'b--',omega), grid
title('Bode plots of the uncertain plant')
legend('Nominal system','Random samples',1)
%
omega = logspace(0,3,300);
figure(3)
olp_ic4 = G(4,1);  % from tau to wL
bode(olp_ic4.Nominal,'r-',olp_ic4,'b--',omega), grid
title('Bode plots of the uncertain plant')
legend('Nominal system','Random samples',3)
%
omega = logspace(-1,3,300);
figure(4)
bodemag(Wm,omega), grid
title('Model frequency response')
%
omega = logspace(-4,3,300);
figure(5)
bodemag(inv(Wp),omega), grid
title('Inverse of performance weighting function')
%
omega = logspace(-3,3,300);
figure(6)
bodemag(inv(Wu),omega), grid
title('Inverse of control action weighting function')
%
omega = logspace(-1,4,300);
figure(7)
bodemag(Wn1,omega), grid
title('Noise shaping filter W_{n1}')
%
omega = logspace(-1,4,300);
figure(8)
bodemag(Wn2,omega), grid
title('Noise shaping filter W_{n2}')