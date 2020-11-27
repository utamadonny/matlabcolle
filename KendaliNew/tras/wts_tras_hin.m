% Weighting functions for Two Rotor Aerodynamical System
%
% model
nuWm1 = 1;
dnWm1 = [1.5^2  2*0.4*1.5  1];  % T = 1.5s, ksi=0.4 
gainWm1 = 1.0;
wm1 = gainWm1*tf(nuWm1,dnWm1);
nuWm2 = 1;
dnWm2 = [2.0^2  2*0.4*2.0  1]; % T = 2s, ksi=0.4    
gainWm2 = 1.0;
wm2 = gainWm2*tf(nuWm2,dnWm2);
wm12 = 0.;
wm21 = 0.;
Wm = [wm1  wm12
      wm21 wm2 ];
%
% performance weight
tol = 10^(-3);
nuWp1 = [80  1];
dnWp1 = [80  tol];
gainWp1 = 0.0648;
wp1 = gainWp1*tf(nuWp1,dnWp1);
nuWp2 = [500  1];   
dnWp2 = [500  tol];
gainWp2 = 0.50; 
wp2 = gainWp2*tf(nuWp2,dnWp2);
wp12 = -0.01;  
wp21 = 0.03;
Wp = [ wp1   wp12
       wp21  wp2  ];
%
% control action weight
nuWu1 = [0.08    1];
dnWu1 = [0.0001  1];
gainWu1 = 5.5*10^(-4);
wu1 = gainWu1*tf(nuWu1,dnWu1);
nuWu2 = [0.26     1];
dnWu2 = [0.0001  1];
gainWu2 = 1.86*10^(-4);
wu2 = gainWu2*tf(nuWu2,dnWu2);
Wu = blkdiag(wu1,wu2);
%
% noise shaping filter
nuWn = [1 0];
dnWn = [1 1];
gainWn = 10^(-2);
wn = gainWn*tf(nuWn,dnWn);
Wn = blkdiag(wn,wn);