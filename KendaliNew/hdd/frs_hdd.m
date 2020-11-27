% Frequency responses of the Hard Disk Drive Servo System
%
sim_hdd
clp = lft(sim_ic,K,1,1);
%
% closed-loop Bode plot
ref_loop = clp(1,1);
w = logspace(2,5,400);
figure(1)
bode(ref_loop.Nominal,'r-',ref_loop,'b--',w), grid
title('Closed-loop Bode plot')
legend('Nominal system','Random samples',3)
%
% output sensitivity to disturbance
sen_loop = clp(1,2);
w = logspace(-1,5,400);
figure(2)
bodemag(sen_loop.Nominal,'r-',sen_loop,'b--',w), grid
title('Output sensitivity to disturbance')
legend('Nominal system','Random samples',3)
%
% output sensitivity to noise
noise_loop = clp(1,3);
w = logspace(1,5,400);
figure(3)
bodemag(noise_loop.Nominal,'r-',noise_loop,'b--',w), grid
title('Output sensitivity to noise')
legend('Nominal system','Random samples',3)
%
% sensitivity of the control effort to the reference
ref_u = clp(2,1);
w = logspace(0,5,400);
figure(4)
bodemag(ref_u.Nominal,'r',ref_u,'b--',w), grid
title('T_{ur} magnitude plot')
legend('Nominal system','Random samples',2)
%
% sensitivity of the control effort to the disturbance
dist_u = clp(2,2);
w = logspace(0,5,400);
figure(5)
bodemag(dist_u.Nominal,'r',dist_u,'b--',w), grid
title('T_{ud} magnitude plot')
legend('Nominal system','Random samples',3)
%
% sensitivity of the control effort to the noise
noise_u = clp(2,3);
w = logspace(0,5,400);
figure(6)
bodemag(noise_u.Nominal,'r',noise_u,'b--',w), grid
title('T_{un} magnitude plot')
legend('Nominal system','Random samples',3)
%
% controller frequency response
w = logspace(-1,6,400);
figure(7)
bode(K,'r',w), grid
title('Controller Bode plot')
%
% open-loop frequency response
L = G(1,2)*K;
w = logspace(0,5,400);
figure(8)
bode(L.Nominal,'r-',L,'b--',w), grid
title('Open-loop Bode plot')
legend('Nominal system','Random samples',3)
%
wts_hdd
systemnames = ' G Wm Wn ';
inputvar = '[ ref; dist; noise; control ]';
outputvar = '[ G(1)-Wm; ref-G(1); ref-G(1)-Wn ]';
input_to_G = '[ dist; control ]';
input_to_Wm = '[ ref ]';
input_to_Wn = '[ noise ]';
sys = sysic;
%
% error frequency response
clp = lft(sys,K,1,1);
err_loop = clp(2,1);
w = logspace(1,5,400);
figure(9)
bodemag(err_loop.Nominal,'r',err_loop,'b--',w), grid
title('Error frequency response')
legend('Nominal system','Random samples',4)
%
% frequency response of the difference between the
% closed-loop system and the model
clp = lft(sys,K);
dif_loop = clp(1,1);
w = logspace(0,6,400);
figure(10)
bodemag(dif_loop.Nominal,'r',dif_loop,'b--',w), grid
title('System-model difference plot')
legend('Nominal system','Random samples',2)