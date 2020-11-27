% Worst case performance analysis of the closed-loop Two-Wheeled 
% Robot Control System 
%
% closed-loop interconnection
sim_robot_2dof
%
systemnames      = ' sim_ic ';
inputvar         = '[ ref{4}; noise{2}; control{2} ]';
outputvar        = '[ sim_ic(1:15) ]';
input_to_sim_ic  = '[ ref; noise; control ]';
clp_ic           = sysic;
%
Ts = 4.0*10^(-3);
[M,Delta,blkstruct] = lftdata(clp_ic);
M_d = c2d(M,Ts);
dclp_ic = lft(Delta,M_d);
dclp = lft(dclp_ic,Kd);
%
% determine worst case closed-loop uncertainty
T = dclp(1:4,1:4);
[maxgain,maxgainunc] = wcgain(T);
T_wc = usubs(T,maxgainunc);
%
% worst case closed-loop singular values
T_30 = usample(T,30);
omega = logspace(-2,1,200);
figure(1)
sigma(T_wc,'r.',T_30,'b--',omega), grid
axis([10^(-1) 5*10^0 -5 10])
title('Singular value plot of the uncertain closed-loop system')
legend('Worst case','Random samples',3)