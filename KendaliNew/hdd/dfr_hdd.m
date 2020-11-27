% Frequency responses of the discrete-time Hard Disk Drive Servo System
%
sim_hdd
%
% discrete-time model
[M,Delta] = lftdata(sim_ic);
M_d = c2d(M,Ts);
dsim_ic = lft(Delta,M_d);
dclp = lft(dsim_ic,KD,1,1);
%
% closed-loop frequency response
ref_loop = dclp(1,1);
w = logspace(2,log10(pi/Ts),400);
figure(1)
bode(ref_loop.Nominal,'r-',ref_loop,'b--',w), grid
title('Closed-loop Bode plot')
legend('Nominal system','Random samples',3)
%
% sensitivity function
sen_loop = dclp(1,2);
w = logspace(0,log10(pi/Ts),400);
figure(2)
bodemag(sen_loop.Nominal,'r-',sen_loop,'b--',w), grid
title('Output sensitivity to disturbance')
legend('Nominal system','Random samples',3)
%
% sensitivity to the noise
noise_loop = dclp(1,3);
w = logspace(0,log10(pi/Ts),400);
figure(3)
bodemag(noise_loop.Nominal,'r-',noise_loop,'b--',w), grid
title('Output sensitivity to noise')
legend('Nominal system','Random samples',3)
%
% sensitivity of the control effort to the reference
ref_u = dclp(2,1);
w = logspace(0,log10(pi/Ts),400);
figure(4)
bodemag(ref_u.Nominal,'r',ref_u,'b--',w), grid
title('T_{ur} magnitude plot')
legend('Nominal system','Random samples',2)
%
% sensitivity of the control effort to the disturbance
dist_u = dclp(2,2);
figure(5)
bodemag(dist_u.Nominal,'r',dist_u,'b--',w), grid
title('T_{ud} magnitude plot')
legend('Nominal system','Random samples',3)
%
% sensitivity of the control effort to the noise
noise_u = dclp(2,3);
figure(6)
bodemag(noise_u.Nominal,'r',noise_u,'b--',w), grid
title('T_{un} magnitude plot')
legend('Nominal system','Random samples',3)
%
% controller frequency response
w = logspace(-2,log10(pi/Ts),400);
figure(7)
bode(KD,'r-',w), grid
title('Controller Bode plot')
%
% open-loop frequency response
w = logspace(-1,log10(pi/Ts),400);
[M,Delta] = lftdata(G);
M_d = c2d(M,Ts);
G_d = lft(Delta,M_d);
L = G_d(1,1)*KD;
figure(8)
bode(L.Nominal,'r-',L,'b--',w), grid
title('Open-loop Bode plot')
legend('Nominal system','Random samples',3)