% Performance weighting functions for the Hard Disk Drive System
% design
%
% Model transfer function
nuWm = 1;
dnWm = [0.00000000375 0.00012 1]; 
gainWm = 1;
Wm = gainWm*tf(nuWm,dnWm);
%
% Performance weighting function
%nuWp = [1  80000  100000000];          % Version 1
%dnWp = [1  70000  25000    ];
%gainWp = 0.00012;
%
nuWp = [1  400000  2500000000];        % Version 2 
dnWp = [1  390000  625000    ];
gainWp = 0.00015; 
%
%nuWp = [1  1150000  36000000000];      % Version 3
%dnWp = [1  1050000  9000000   ];
%gainWp = 0.000085; 
%
Wp = gainWp*tf(nuWp,dnWp);
%
% Control weighting function
%
%nuWu = [0.70    1      1];             % Version 1
%dnWu = [0.0001  0.002  1]; 
%gainWu = 0.00000093;
%
nuWu = [0.55    1      1];             % Version 2                  
dnWu = [0.0001  0.002  1];            
gainWu = 0.0000015;
%
%nuWu = [0.405    1       1];           % Version 3                  
%dnWu = [0.0001  0.002   1];            
%gainWu = 0.0000041;
%
Wu = gainWu*tf(nuWu,dnWu);
%
% Sensor noise
nuWn = [0.1    1];
dnWn = [0.001  1];
gainWn = 0.0006;
Wn = gainWn*tf(nuWn,dnWn);
%
clear nuWm, clear dnWm, clear gainWm
clear nuWp, clear dnWp, clear gainWp
clear nuWu, clear dnWu, clear gainWu
clear nuWn, clear dnWn, clear gainWn