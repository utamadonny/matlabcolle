% Generates the open-loop connection for the Two-Wheeled Robot Control 
% System
%
% plant model
mod_robot
figure(1)
sigma(G_unc.Nominal,'r-',G_unc,'b--'), grid
axis([10^(-1) 3*10^2 -5 25])
xlabel('Frequency')
ylabel('Singular values')
title('Singular value plot of the uncertain model')
legend('Nominal system','Random samples',1)
%
% performance weights
%---------------------
%    1
tol = 0.6*10.0^(-1); % 
nuWp = [0.4  1];     % 
dnWp = [5.0  tol];
gainWp = 0.95*10^(0); % 
Wp11 = gainWp*tf(nuWp,dnWp);
%---------------------
%    2
Wp22 = 0.93; %           
%---------------------
%    3
Wp33 = 0.15; % 
%---------------------
%    4
nuWp = [1.1 1]; 
dnWp = [1.0 1];
gainWp = 0.22*10^(0); % 
Wp44 = gainWp*tf(nuWp,dnWp);
%---------------------
%    5
tol = 0.6*10.0^(-1); %
nuWp = [0.4  1];     % 
dnWp = [5.0  tol];   %
gainWp = 1.8*10^(0); % 
Wp55 = gainWp*tf(nuWp,dnWp);
%----------------------------
Wp = [Wp11 0    0   0   0;
      0   Wp22  0   0   0;
      0    0  Wp33  0   0;
      0    0    0  Wp44 0;
      0    0    0   0  Wp55];
%-------------------------------------
figure(2)
bodemag(1/Wp11,'r-',1/Wp44,'b--',1/Wp55,'c-.',{10^(-3) 10^2})
grid
title('Inverse performance weighting functions')
legend('W_{p11}^{-1}','W_{p44}^{-1}','W_{p55}^{-1}',4)
%
% Noise shaping filters
Wn11 = 0.1*tf([1 2], [0.001 1]);  % 
Wn22 = 1.0*tf([1 2], [0.001 1]);  % 
%-------------------------------------
Wn = [Wn11  0
       0   Wn22];
%-------------------------------------
figure(3)
bodemag(Wn11,'r-',Wn22,'b--',{10^(-1) 10^4})
grid
title('Sensor noise weight')
legend('Wn11','Wn22',4)
%
% control action weights
nuWu = [1.2    1];    % 
dnWu = [0.0024  1];   % 
gainWu = 2.0*10^(-2); %
Wu11 = gainWu*tf(nuWu,dnWu);
%-------------------------------------
Wu = [Wu11 0
       0 Wu11];
%------------------------------------- 
figure(4)
bodemag(1/Wu11,'r-',{10^(-1) 10^4})
grid
title('Inverse control weighting functions')
%
s = tf('s');
Intg = 1/(s+10^(-6)); 
%
% open-loop connection with the weighting functions
% 2 dof controller
%         
systemnames    = ' G_unc Wn Wp Wu Intg ';
inputvar       = '[ ref{4}; noise{2}; control{2} ]';
outputvar      = '[ Wp; Wu; ref; -G_unc(1:2); -G_unc(3:4)-Wn; Intg ]';
input_to_G_unc = '[ control ]';
input_to_Wn    = '[ noise ]';
input_to_Wp    = '[ ref(1:4)-G_unc(1:4); Intg ]';  
input_to_Wu    = '[ control ]';
input_to_Intg  = '[ ref(1)-G_unc(1) ]';
sys_ic         = sysic;
%
C_hh = [1 0];
%