% mu-analysis of the distillation column
% closed-loop system
%
if size(K,2) == 2
%  1 dof controller
   clp_ic = lft(sys_ic_1dof,K,2,2); 
elseif size(K,2) == 4
%      2 dof controller
       clp_ic = lft(sys_ic_2dof,K,2,4);
end
omega = logspace(-3,3,100);
clp_g = ufrd(clp_ic,omega);
%
% robust stability
opt = robopt('Display','on');
[stabmarg,destabu,report,info] = robuststab(clp_g,opt);
report
figure(1)
loglog(info.MussvBnds(1,1),'r-',info.MussvBnds(1,2),'b--')
grid
title('Robust stability')
xlabel('Frequency (rad/min)')
ylabel('mu')
legend('\mu-upper bound','\mu-lower bound',3)
%
% nominal performance
figure(2)
sv = sigma(clp_ic.Nominal(1:4,1:4),omega);
nom_perf = frd(sv(1,:),omega);
semilogx(nom_perf,'r-')
grid
title('Nominal performance')
xlabel('Frequency (rad/min)')
%
% robust performance
opt = robopt('Display','on');
[perfmarg,perfmargunc,report,info] = robustperf(clp_g,opt);
report
figure(3)
semilogx(info.MussvBnds(1,1),'r-',info.MussvBnds(1,2),'b--')
grid
title('Robust performance')
xlabel('Frequency (rad/min)')
ylabel('mu')
legend('\mu-upper bound','\mu-lower bound',3)