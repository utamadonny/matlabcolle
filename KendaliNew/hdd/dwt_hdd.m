% Performance weighting functions for the discrete-time
% Disk Drive Controller Design
%
% Model transfer function
nuWm = 1;
dnWm = [0.00000000375 0.00012 1];
gainWm = 1;
Wm = gainWm*tf(nuWm,dnWm);
%
% Performance weighting function
nuWp = [1  400000  2500000000];  
dnWp = [1  390000  625000    ];
gainWp = 0.0001; 
Wp = gainWp*tf(nuWp,dnWp);
%
% Control weighting function
%
% fs = 24 kHz
nuWu = [4       2      1];
dnWu = [0.002   0.002  1];
gainWu = 1.0*10^(-7);
%
% fs = 36  kHz 
%nuWu = [1.04     2      1];
%dnWu = [0.000075  0.002  1]; 
%gainWu = 1.0*10^(-7);
Wu = gainWu*tf(nuWu,dnWu);
%
% Sensor noise
nuWn = [0.1    1];
dnWn = [0.001  1];
gainWn = 0.0006;
Wn = gainWn*tf(nuWn,dnWn);