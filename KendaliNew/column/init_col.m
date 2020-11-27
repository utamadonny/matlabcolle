% Parameters for the nonlinear simulation
% of the distillation column
%
% Saves data in file init_col.mat
%
% Generate steady-state data for column A
%% Do this by simulating 20000 min with stabilized LV-model:
[t,x] = ode15s(@cola_lv,[0 20000],0.5*ones(1,82)'); 
lengthx = size(x); Xinit = x(lengthx(1),:)';
%
% Nominal inputs
LT = 2.70629;                          % Reflux
VB = 3.20629;                          % Boilup
D = 0.5;                               % Distillate
B = 0.5;                               % Bottom products
F = 1.0;                               % Feedrate
zF = 0.5;                              % Feed composition
qF = 1.0;                              % Feed liquid fraction
Uinit = [ LT VB D B F zF qF]';

clear x; clear t; clear LT; clear VB; clear D; clear B;
clear F; clear zF; clear qF;
%
% Rescaling the controller
S = blkdiag(So,So);
K_u = K*S;
%
% Unpack the controller
[Ak,Bk,Ck,Dk] = ssdata(K_u);
%
% Noise shaping filters for the unscaled plant
kf1 = 0.01/So(1,1); Tf11 = 1;   Tf12 = 1;
kf2 = 0.01/So(2,2); Tf21 = 1;   Tf22 = 1;

save init_col  % saves in init_col.mat