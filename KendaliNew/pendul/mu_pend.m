% Robustness analysis of the triple inverted pendulum
% closed-loop system
%
clp_ic = lft(pend_ic,K,2,6);
omega = logspace(-1,3,100);
clp_g = ufrd(clp_ic,omega);
%
% robust stability analysis
opt = robopt('Display','on');
[stabmarg,destabu,report,info] = robuststab(clp_g,opt);
report
figure(1)
loglog(info.MussvBnds(1,1),'r-',info.MussvBnds(1,2),'b--')
grid
title('Robust stability')
xlabel('Frequency (rad/s)')
ylabel('mu')
legend('\mu-upper bound','\mu-lower bound',3)
%
% nominal performance
figure(2)
sv = sigma(clp_ic.Nominal,omega);
sys_frd = frd(sv(1,:),omega);
semilogx(sys_frd,'r-')
grid
title('Nominal performance')
xlabel('Frequency (rad/s)')
%
% robust performance
opt = robopt('Display','on')
[perfmarg,perfmargunc,report,info] = robustperf(clp_g,opt);
report
figure(3)
semilogx(info.MussvBnds(1,1),'r-',info.MussvBnds(1,2),'b--')
grid
title('Robust performance')
xlabel('Frequency (rad/s)')
ylabel('mu')
legend('\mu-upper bound','\mu-lower bound',3)