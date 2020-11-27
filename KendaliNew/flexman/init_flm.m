% Set the parameters for the flexible manipulator simulation
%
% Controller
[Ak,Bk,Ck,Dk] = ssdata(K);
%
% Noise shaping filters
kf1 = 0.001;   Tf11 = 0.5; Tf12 = 0.005;
kf2 = 0.00001; Tf21 = 1;   Tf22 = 0.01;
