% Frequency responses of all controllers
%
w = logspace(-1,6,400);
%
figure(1)
bode(K_mu,'r-',K_hin,'b--',K_lsh,'m-.',w), grid
title('Bode plots of three controllers')
legend('\mu-controller','H_\infty controller','Loop Shaping controller',2)