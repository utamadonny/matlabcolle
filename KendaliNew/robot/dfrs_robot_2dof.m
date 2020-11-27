% Frequency responses of the Two-Wheeled Robot Control System
%
% closed-loop interconnection
sim_robot_2dof
%
s = tf('s');
Intg = 1/(s+10^(-5));
%Intg = 1/s;
%
systemnames      = ' sim_ic Intg ';
inputvar         = '[ ref{4}; noise{2}; control{2} ]';
outputvar        = '[ sim_ic(1:6); ref(1:4)-sim_ic(1:4); Intg; sim_ic(7:15) ]';
input_to_sim_ic  = '[ ref; noise; control ]';
input_to_Intg    = '[ ref(1)- sim_ic(1) ]';
clp_ic           = sysic;
%
Ts = 4.0*10^(-3);
[M,Delta,blkstruct] = lftdata(clp_ic);
M_d = c2d(M,Ts);
dclp_ic = lft(Delta,M_d);
clp = lft(dclp_ic,Kd);
%
dWp = c2d(Wp,Ts);
dWn = c2d(Wn,Ts);
dWu = c2d(Wu,Ts);
%
% closed-loop frequency response
ref_loop = clp(1,1);
omega = logspace(-3,log10(pi/Ts),500);
figure(1)
sigma(ref_loop,'r-',omega), grid
%xlabel('Frequency (rad/sec')
%ylabel('Singular values (dB)')
axis([10^(-3) 10^1 -10 10])
title('Singular value plot of the closed-loop system \Theta(z)/r(z)')
%
% singular values of the output sensitivity function
sen_loop = clp(7,1);
omega = logspace(-4,log10(pi/Ts),500);
figure(2)
sigma(sen_loop,'b-',inv(dWp(1,1)),'r--',omega), grid
%xlabel('Frequency (rad/sec')
%ylabel('Singular values (dB)')
title('Singular value plot of the output sensitivity e_\Theta(z)/r(z)')
legend('Output sensitivity','Inverse performance weighting function',4)
%
% singular values of the integral component
sen_loop = clp(11,1);
omega = logspace(-4,log10(pi/Ts),500);
figure(3)
sigma(sen_loop,'b-',inv(dWp(5,5)),'r--',omega), grid
title('Singular value plot of the integral error Int(e_\Theta)(z)/r(z)')
legend('Integral error','Inverse performance weighting function',3)
%
% sensitivity of control action to reference
cont_loop = clp([5:6],[1:4]);
omega = logspace(-4,log10(pi/Ts),500);
figure(4)
sigma(cont_loop,'b-',inv(dWu),'r--',omega), grid
axis([10^(-4) pi/Ts -150 100])
title('Sensitivity of control to references')
legend('Control action','Inverse control weighting function',3)
%
% sensitivity of control action to noises
cont_loop = clp([5:6],[5:6]);
omega = logspace(-4,log10(pi/Ts),500);
figure(5)
sigma(cont_loop,'b-',inv(dWu),'r--',omega), grid
axis([10^(-4) pi/Ts -300 100])
title('Sensitivity of control to noises')
legend('Control action due to noises', ...
       'Inverse control weighting function',4)
%
% sensitivity of control action to reference and noise
cont_loop = clp([5:6],[1:6]);
omega = logspace(-4,log10(pi/Ts),500);
figure(6)
sigma(cont_loop,'b-',inv(dWu),'r--',omega), grid
axis([10^(-4) pi/Ts -150 100])
title('Sensitivity of control to references and noises')
legend('Control action due to references and noises', ...
       'Inverse control weighting function',3)
%
% controller frequency responses
omega = logspace(-4,log10(pi/Ts),500);
figure(7)
sigma(Kd,'r-',omega), grid
%bode(Kd,'r-',omega), grid
axis([10^(-4) pi/Ts -50 100])
title('Singular value plot of the controller')
%title('Bode value plot of the controller')
%
% open-loop frequency response
Ts = 4.0*10^(-3);
[M,Delta,blkstruct] = lftdata(G_unc);
M_d = c2d(M,Ts);
Gunc_d = lft(Delta,M_d);
L = Gunc_d*Kd;
omega = logspace(-5,log10(pi/Ts),500);
figure(8)
sigma(L,'r-',omega), grid
axis([10^(-5) pi/Ts -50 150])
title('Singular value plot of the open-loop system')