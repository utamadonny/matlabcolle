% Open-loop interconnection of the triple inverted
% pendulum system
%
clear all
mod_pend
S = ss(-eye(3),zeros(3),zeros(3),Cp);
%
% singular values of G
figure(1)
sigma(G.Nominal(1:3,4:5),'r-',G(1:3,4:5),'b--')
grid
title('Singular value plot of G')
legend('Nominal system','Random samples',3)
%
% actuators
act_pend
figure(2)
bodemag(Act1.Nominal,'r-',Act1,'b--',{10 10^4})
grid
title('Bode plot of the first actuator')
legend('Nominal system','Random samples',3)
figure(3)
bodemag(Act2.Nominal,'r-',Act2,'b--',{10 10^4})
grid
title('Bode plot of the second actuator')
legend('Nominal system','Random samples',3)
%
% construct weighting functions
wsn_pend
wts_pend     
figure(4)
bodemag(wn)
grid
title('Sensor noise weight')
figure(5)
bodemag(wm1,'r-',wm2,'b--',wm3,'m-.',{10^(-2) 10^2})
grid
title('Model frequency responses')
legend('w_{m1}','w_{m2}','w_{m3}',3)
figure(6)
bodemag(1/wp1,'r-',1/wp2,'b--',1/wp3,'m-.',{10^(-6) 10^4})
grid
title('Inverse performance weighting functions')
legend('w_{p1}^{-1}','w_{p2}^{-1}','w_{p3}^{-1}',4)
%
% open-loop connection with weighting functions
systemnames = ' Act1 Act2 G S Wm Wn Wp Wu ';
inputvar = '[ ref{3}; dist{3}; noise{3}; control{2} ]';
outputvar = '[ Wp; Wu; -G(4:6) - Wn; S ]';
input_to_Act1 = '[ control(1) ]';
input_to_Act2 = '[ control(2) ]';
input_to_G = '[ dist; Act1; Act2 ]';
input_to_S = '[ ref ]';
input_to_Wm = '[ ref ]';
input_to_Wn = '[ noise ]';
input_to_Wp = '[ G(1:3) - Wm ]';
input_to_Wu = '[ control ]';
pend_ic = sysic;