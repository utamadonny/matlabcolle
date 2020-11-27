% Nominal performance for three controllers
%
w = logspace(2,5,100);
%
% mu-controller
clp_mu = lft(sys_ic,K_mu);
prf_mu = clp_mu(1:2,1:3);
sv = sigma(prf_mu.Nominal,w);
frd_mu = frd(sv(1,:),w);
%
% Hinf controller
clp_hin = lft(sys_ic,K_hin);
prf_hin = clp_hin(1:2,1:3);
sv = sigma(prf_hin.Nominal,w);
frd_hin = frd(sv(1,:),w);
%
% Loop Shaping controller
clp_lsh = lft(sys_ic,K_lsh);
prf_lsh = clp_lsh(1:2,1:3);
sv = sigma(prf_lsh.Nominal,w);
frd_lsh = frd(sv(1,:),w);
%
figure(1)
loglog(frd_mu,'r-',frd_hin,'b--',frd_lsh,'m-.')
grid
xlabel('Frequency (rad/sec)')
title('Nominal performance for three controllers')
legend('\mu-controller','H_\infty controller', ...
       'Loop shaping controller',3)