% Generates the open-loop connection for the
% Distillation Column system
%
mod_col
%
% singular values of G
omega = logspace(-4,2,100);
figure(1)
sigma(G,'r-',G82,'b-.',omega)
grid
title('Singular Value Plots of G and G_4')
xlabel('Frequency (rad/min)')
ylabel('Magnitude')
legend('Singular values of G','Singular values of G4')
%
% construct weighting functions
wts_col
%
omega = logspace(-4,2,100);
figure(2)
bodemag(wm,'r-',omega), grid
title('Model frequency response')
xlabel('Frequency (rad/min)')
ylabel('Magnitude')
%
omega = logspace(-4,2,100);
figure(3)
bodemag(wn,'m-',omega), grid
title('Sensor Noise Weight')
xlabel('Frequency (rad/min)')
ylabel('Magnitude')
%
omega = logspace(-6,2,100);
figure(4)
sigma(1/wp,omega), grid
title('Inverse Performance Weighting Function')
xlabel('Frequency (rad/min)')
ylabel('Magnitude')
%
omega = logspace(-4,4,100);
figure(5)
sigma(wu,'r-',omega), grid
title('Control Action Weighting Function')
xlabel('Frequency (rad/min)')
ylabel('Magnitude')
%
Delta_1 = ultidyn('Delta_1',[1 1]);
Delta_2 = ultidyn('Delta_2',[1 1]);
Delta = blkdiag(Delta_1,Delta_2);
%
% open-loop connection with the weighting functions
% 1 dof controller
systemnames = ' G Delta W_Delta Wm Wn Wp Wu ';
inputvar = '[ ref{2}; noise{2}; control{2} ]';
outputvar = '[ Wp; Wu; ref-G-Wn ]';
input_to_G = '[ control+Delta ]';
input_to_Delta = '[ W_Delta ]';
input_to_W_Delta = '[ control ]';
input_to_Wm =  '[ ref ]';
input_to_Wn = '[ noise ]';
input_to_Wp = '[ G-Wm ]';
input_to_Wu = '[ control ]';
sys_ic_1dof = sysic;
% 2 dof controller
systemnames = ' G Delta W_Delta Wm Wn Wp Wu ';
inputvar = '[ ref{2}; noise{2}; control{2} ]';
outputvar = '[ Wp; Wu; -G-Wn; ref ]';
input_to_G = '[ control+Delta ]';
input_to_Delta = '[ W_Delta ]';
input_to_W_Delta = '[ control ]';
input_to_Wm =  '[ ref ]';
input_to_Wn = '[ noise ]';
input_to_Wp = '[ G-Wm ]';
input_to_Wu = '[ control ]';
sys_ic_2dof = sysic;