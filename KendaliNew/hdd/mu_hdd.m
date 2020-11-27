% Robustness analysis of the Hard Disk Drive Servo System
%
clp_ic = lft(sys_ic,K,1,1);
w = logspace(3,5,100);
clp_g = ufrd(clp_ic,w);
%
% robust stability analysis
opt = robopt('Display','on');
[stabmarg,destabu,report,info] = robuststab(clp_g,opt);
stabmarg
report
figure(1)
semilogx(info.MussvBnds(1,1),'r-',info.MussvBnds(1,2),'b--')
grid
title('Robust stability')
xlabel('Frequency (rad/s)')
ylabel('mu')
legend('\mu-upper bound','\mu-lower bound',3)
%
% nominal performance
w = logspace(2,5,100);
figure(2)
sv = sigma(clp_ic.Nominal,w);
sys_frd = frd(sv(1,:),w);
semilogx(sys_frd,'r-')
grid
title('Nominal performance')
xlabel('Frequency (rad/s)')
%
% robust performance
w = logspace(3,5,100);
opt = robopt('Display','on');
[perfmarg,perfmargunc,report,info] = robustperf(clp_g,opt);
perfmarg
report
figure(3)
semilogx(info.MussvBnds(1,1),'r-',info.MussvBnds(1,2),'b--')
grid
title('Robust performance')
xlabel('Frequency (rad/s)')
ylabel('mu')
legend('\mu-upper bound','\mu-lower bound',3)