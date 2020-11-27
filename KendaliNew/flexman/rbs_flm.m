% Robust stability analysis of the flexible manipulator system 
% 
if size(K,2) == 2
   cls = lft(sys_ic_PD,K,1,2); % PD controller
elseif size(K,2) == 3
   cls = lft(sys_ic,K,1,3);    % Hinf or mu-controller
end
omega = logspace(0,4,100);
cls_g = ufrd(cls(1,1),omega);
opt = robopt('Display','on','Sensitivity','off');
[stabmarg,destabunc,report,info] = robuststab(cls_g,opt);
stabmarg
report
semilogx(info.MussvBnds(1,1),'r',info.MussvBnds(1,2),'b--')
grid
title('Robust stability')
xlabel('Frequency (rad/s)')
ylabel('mu')
legend('\mu-upper bound','\mu-lower bound',4)