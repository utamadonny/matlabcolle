% Generate the open-loop connection for the
% discrete-time Hard Disk Drive Servo System
%
% discretization interval
Ts = input ('Enter sampling period Ts = ');
% 
% Disk Drive Servo System model
mod_hdd
%
% construct performance weighting function
dwt_hdd
%
% open-loop connection with the weighting function
systemnames = ' G Wm Wn Wp Wu ';
inputvar = '[ ref; dist; noise; control ]';
outputvar = '[ Wp; Wu; ref-G(1)-Wn ]';
input_to_G = '[ dist; control ]';
input_to_Wm = '[ ref ]';
input_to_Wn = '[ noise ]';
input_to_Wp = '[ G(1) - Wm ]';
input_to_Wu = '[ control ]';
sys_ic = sysic;
%
% discrete-time model
[M,Delta] = lftdata(sys_ic);
M_d = c2d(M,Ts);
dsys_ic = lft(Delta,M_d);
%
% frequency response of the discrete-time plant
[M,Delta] = lftdata(G);
M_d = c2d(M,Ts);
G_d = lft(Delta,M_d);
w = logspace(2,log10(pi/Ts),400);
figure(1)
bode(G(1,2).NominalValue,'b-',G_d(1,2).NominalValue,'r--',w), grid
title('Bode plots of continuous-time and discrete-time plants')
legend('Continuous-time plant','Discrete-time plant',3)
%
G_d30 = usample(G_d,30);
w = logspace(2,log10(pi/Ts),400);
figure(2)
bode(G_d(1,2).NominalValue,'r-',G_d30(1,2),'b-.',w), grid
title('Bode plot of the uncertain discrete-time plant')
legend('Nominal system','Random samples',3)
%
% performance weighting frequency response
w = logspace(-2,log10(pi/Ts),400);
Wpi_d = c2d(1/Wp,Ts);
figure(3)
bodemag(Wpi_d,'r',w), grid
title('Inverse Performance Weighting Function')
%
% control weighting frequency response
w = logspace(-2,log10(pi/Ts),400);
Wu_d = c2d(Wu,Ts);
figure(4)
bodemag(Wu_d,'r',w), grid
title('Control Weighting Function')