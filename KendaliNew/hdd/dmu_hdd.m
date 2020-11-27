% Mu-analysis of the discrete-time Hard Disk Drive Servo System
%
% discrete-time model
[M,Delta,blkstruct] = lftdata(sys_ic);
M_d = c2d(M,Ts);
dsys_ic = lft(Delta,M_d);
%
% closed-loop system
dclp_ic = lft(dsys_ic,KD,1,1);
w = logspace(2,log10(pi/Ts),100);
dclp_g = ufrd(dclp_ic,w);
%
% robust stability analysis
opt = robopt('Display','on');
[stabmarg,destabu,report,info] = robuststab(dclp_g,opt);
report
figure(1)
semilogx(info.MussvBnds(1,1),'r-',info.MussvBnds(1,2),'b--')
grid
xlabel('Frequency (rad/sec)')
ylabel('mu')
title('Robust stability')
legend('\mu-upper bound','\mu-lower bound',2)
%
% nominal performance
figure(2)
sv = sigma(dclp_ic.Nominal,w);
sys = frd(sv(1,:),w);
semilogx(sys,'r-')
%axis([10 10^5 0.01 10])
grid
xlabel('Frequency (rad/sec)')
title('Nominal performance')
%
% robust performance
opt = robopt('Display','on')
[perfmarg,perfmargunc,report,info] = robustperf(dclp_g,opt);
report
figure(3)
loglog(info.MussvBnds(1,1),'r-',info.MussvBnds(1,2),'b--')
grid
xlabel('Frequency (rad/sec)')
ylabel('mu')
title('Robust performance')
legend('\mu-upper bound','\mu-lower bound',3)