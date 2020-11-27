% Weighting functions for H_inf and mu-synthesis
%
% Model transfer function
nuWm1 = 1;
dnWm1 = [10.0^2  14.0   1]; % T = 10.0, omega = 0.10, ksi = 0.70
gainWm = 1;
wm1 = gainWm*tf(nuWm1,dnWm1);
nuWm2 = 1;
dnWm2 = [5.0^2  7.0   1];   % T = 5.0,  omega = 0.20, ksi = 0.70
wm2 = gainWm*tf(nuWm2,dnWm2);
nuWm3 = 1;
dnWm3 = [3.0^2  4.2   1];   % T = 3.0,  omega = 0.33, ksi = 0.70 
wm3 = gainWm*tf(nuWm3,dnWm3);
Wm = blkdiag(wm1,wm2,wm3);
%
% performance weights
nuWp1 = [ 1  2    4   ];   
dnWp1 = [ 1  1.5  0.1 ];
gainWp1 = 0.01;
wp1 = gainWp1*tf(nuWp1,dnWp1);
nuWp2 = [ 1  2    4   ];   
dnWp2 = [ 1  1.5  0.01];
gainWp2 = 0.02;
wp2 = gainWp2*tf(nuWp2,dnWp2);
nuWp3 = [ 1  2    4   ]; 
dnWp3 = [ 1  1.5  0.01];
gainWp3 = 0.04;
wp3 = gainWp3*tf(nuWp3,dnWp3);
Wp = blkdiag(wp1,wp2,wp3);
%
% control weights
nuWu = [1 1]; 
dnWu = [0.001 1]; 
gainWu = 10^(-6);
wu = gainWu*tf(nuWu,dnWu);
Wu = blkdiag(wu,wu);