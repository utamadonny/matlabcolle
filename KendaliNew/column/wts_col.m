% Weighting functions for Distillation Column system
%
% uncertainty weight
nuW_Delta1 = [2.2138 15.9537 27.6702  4.9050];
dnW_Delta1 = [1.      8.3412 21.2393 22.6705];
gainW_Delta1 = 1;
w_Delta1 = gainW_Delta1*tf(nuW_Delta1,dnW_Delta1);
%
nuW_Delta2 = [2.2138 15.9537 27.6702  4.9050];
dnW_Delta2 = [1.      8.3412 21.2393 22.6705];
gainW_Delta2 = 1;
w_Delta2 = gainW_Delta2*tf(nuW_Delta2,dnW_Delta2);
%
W_Delta = blkdiag(w_Delta1,w_Delta2);
%
% model
nuWm = 1;
dnWm = [6.0^2  2*0.8*6.0  1]; 
gainWm = 1.0;
wm = gainWm*tf(nuWm,dnWm);
wm12 = 0.;
wm21 = 0.;
Wm = [wm  wm12
      wm21 wm ];
%
% performance weight
tol = 10^(-4);
nuWp = [9.5 3];
dnWp = [9.5 tol];
gainWp = 0.55;
wp = gainWp*tf(nuWp,dnWp);
wp12 = 0.3;  
wp21 = 0.3;
Wp = [wp   wp12
      wp21 wp  ];
%
% control action weight
nuWu = [1  1];     
dnWu = [0.01   1];
gainWu = 8.7*10^(-1);
wu = gainWu*tf(nuWu,dnWu);
Wu = blkdiag(wu,wu);
%
% noise shaping filter
nuWn = [1 0];
dnWn = [1 1];
gainWn = 10^(-2);
wn = gainWn*tf(nuWn,dnWn);
Wn = blkdiag(wn,wn);