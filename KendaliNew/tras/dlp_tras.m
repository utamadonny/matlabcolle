% Generates the open-loop connection for the
% Twin-Rotor Aerodynamic System
%
mod_tras
%
% singular values of G
omega = logspace(-3,3,200);
figure(1)
sigma(G([3,6],3:4),'b-',omega)
grid
title('Singular Value Plot of G')
xlabel('Frequency')
ylabel('Magnitude')
%
% construct weighting functions
%wts_tras_hin       % Hinf control
wts_tras_mu        % mu-synthesis
%
omega = logspace(-2,1,400);
figure(2)
bodemag(wm1,'r-',wm2,'b--',omega), grid
title('Model frequency responses')
xlabel('Frequency')
ylabel('Magnitude')
legend('wm1','wm2')
%
omega = logspace(-2,2,200);
figure(3)
bodemag(wn,'m-',omega), grid
title('Sensor Noise Weight')
xlabel('Frequency')
ylabel('Magnitude')
%
omega = logspace(-8,2,200);
figure(4)
bodemag(1/wp1,'r-',1/wp2,'b--',omega), grid
title('Inverse Performance Weighting Function')
xlabel('Frequency')
ylabel('Magnitude')
legend('1/wp1','1/wp2',2)
%
omega = logspace(0,5,200);
figure(5)
bodemag(1/wu1,'r-',1/wu2,'b--',omega), grid
title('Control Action Inverse Weighting Function')
xlabel('Frequency')
ylabel('Magnitude')
legend('1/wu1','1/wu2',1)
%
% open-loop connection with the weighting functions
% 2 dof controller
systemnames = ' G Wm Wn Wp Wu ';
inputvar    = '[ dist{2}; ref{2}; noise{2}; control{2} ]';
outputvar   = '[ Wp; Wu; ref(1); ref(2); -G(3)-Wn(1); -G(6)-Wn(2) ]';
input_to_G  = '[ dist; control ]';
input_to_Wm =  '[ ref ]';
input_to_Wn = '[ noise ]';
input_to_Wp = '[ G(3)-Wm(1); G(6)-Wm(2) ]';
input_to_Wu = '[ control ]';
sys_ic      = sysic;