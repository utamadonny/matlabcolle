% Nominal and robust performance analysis
% of the flexible manipulator system
%
if size(K,2) == 2
   csys = lft(sys_ic_PD,K,1,2); % PD controller
elseif size(K,2) == 3
   csys = lft(sys_ic,K,1,3);    % Hinf or mu-controller
end
omega = logspace(-1,4,200);
%
% Nominal performance
figure(1)
sv = sigma(csys.Nominal,omega);
semilogx(omega,sv(1,:),'r',omega,sv(2,:),'b'),grid
title('Nominal performance')
xlabel('Frequency (rad/s)')
%
% Robust performance
csys_g = ufrd(csys,omega);
opt = robopt('Display','on','Sensitivity','off');
[perfmarg,perfmargunc,report,info] = robustperf(csys_g,opt);
perfmarg
report
figure(2)
semilogx(info.MussvBnds(1,1),'r',info.MussvBnds(1,2),'b--')
grid
title('Robust performance')
xlabel('Frequency (rad/s)')
ylabel('mu')
legend(' Upper bound',' Lower bound',1)