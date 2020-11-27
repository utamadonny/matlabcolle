% Nominal frequency responses of the Hard Disk Drive Servo System
% for three controllers
%
% Closed-loop frequency response
%
sim_hdd
w = logspace(3,4.301,400);
%
% mu-controller
clp_mu = lft(sim_ic,K_mu,1,1);
ref_mu = clp_mu(1,1);
%
% Hinf controller
clp_hin = lft(sim_ic,K_hin,1,1);
ref_hin = clp_hin(1,1);
%
% Loop Shaping controller
clp_lsh = lft(sim_ic,K_lsh,1,1);
ref_lsh = clp_lsh(1,1);
%
figure(1)
bode(ref_mu.Nom,'r-',ref_hin.Nom,'b--',ref_lsh.Nom,'m-.',w), grid
legend('\mu-controller','H_\infty controller','Loop Shaping controller',3)
title('Closed-loop Bode plots for three controllers')
%
% Output sensitivity to disturbance
w = logspace(-1,5,100);
%
% mu controller
clp_mu = lft(sim_ic,K_mu,1,1);
sen_mu = clp_mu(1,2);
%
% Hinf controller
clp_hin = lft(sim_ic,K_hin,1,1);
sen_hin = clp_hin(1,2);
%
% Loop Shaping controller
clp_lsh = lft(sim_ic,K_lsh,1,1);
sen_lsh = clp_lsh(1,2);
%
figure(2)
bodemag(sen_mu.Nom,'r-',sen_hin.Nom,'b--',sen_lsh.Nom,'m-.',w), grid
title('Output sensitivity to disturbance')
legend('\mu-controller','H_\infty controller','Loop Shaping controller',4)
%
% Output sensitivity to noise
w = logspace(0,5,100);
%
% mu controller
noise_mu = clp_mu(1,3);
%
% Hinf controller
noise_hin = clp_hin(1,3);
%
% Loop Shaping controller
noise_lsh = clp_lsh(1,3);
%
figure(3)
bodemag(noise_mu.Nom,'r-',noise_hin.Nom,'b--',noise_lsh.Nom,'m-.',w), grid
title('Output sensitivity to noise')
legend('\mu-controller','H_\infty controller','Loop Shaping controller',3)