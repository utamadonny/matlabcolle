% Mu analysis of the Two-Wheeled Robot Control System
% 
% closed-loop connection for the discrete-time system
Ts = 4.0*10^(-3);
[M,Delta,blkstruct] = lftdata(sys_ic);
M_d = c2d(M,Ts);
dsys_ic = lft(Delta,M_d);
%
% closed-loop system
dclp_ic = lft(dsys_ic,Kd,2,9);
omega = logspace(-3,log10(pi/Ts),200);
dclp_g = ufrd(dclp_ic,omega);
%
% robust stability analysis
opt = robopt('Display','on');
[stabmarg,destabu,report,info] = robuststab(dclp_g,opt);
report
figure(1)
semilogx(info.MussvBnds(1,1),'r-',info.MussvBnds(1,2),'b--')
grid
title('Robust stability')
xlabel('Frequency (rad/sec)')
ylabel('mu')
legend('\mu-upper bound','\mu-lower bound')
%
% nominal performance
figure(2)
sv = sigma(dclp_ic.Nominal,omega);
sys = frd(sv(1,:),omega);
semilogx(sys,'r-')
grid
xlabel('Frequency (rad/sec)')
title('Nominal performance')
%
% robust performance
opt = robopt('Display','on');
[perfmarg,perfmargunc,report,info] = robustperf(dclp_g,opt);
report
figure(3)
semilogx(info.MussvBnds(1,1),'r-',info.MussvBnds(1,2),'b--')
grid
xlabel('Frequency (rad/sec)')
ylabel('mu')
title('Robust performance')
legend('\mu-upper bound','\mu-lower bound')