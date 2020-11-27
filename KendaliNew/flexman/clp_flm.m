% Transient responses of the closed_loop
%
% Controller inputs:  1) ref 
%                     2) theta
%                     3) d2alpha/dt2 
%
% response to the reference
sim_flm
clp = lft(sim_ic,K,1,3);
%
ti = 0.001;     % time increment                     
tfin1 = 1;
time1 = 0:ti:tfin1;
nstep1 = size(time1,2);
ref1(1:nstep1) = pi*time1(1:nstep1)/12 - sin(2*pi*time1(1:nstep1))/24;
tfin2 = 3;      % final time value
time2 = tfin1+ti:ti:tfin2;
nstep2 = size(time2,2);
ref2(1:nstep2) = pi/12;
time = [time1, time2];
ref = [ref1,ref2];
dist(1:nstep1+nstep2) = 0;
noise1(1:nstep1+nstep2) = 0;
noise2(1:nstep1+nstep2) = 0;
[y,t] = lsim(clp.Nominal,[ref',dist',noise1',noise2'],time);
%
alpha = y(:,1);
theta = y(:,2);
figure(1)
plot(t,ref,'b--',t,alpha,'r-',t,theta,'c-.'), grid
title('Closed-loop transient response')
xlabel('Time (secs)')
ylabel('ref, \alpha, \theta')
legend('ref','\alpha','\theta',4)
disp(['overshoot: ' num2str(100*(norm(alpha,inf)-pi/12)) '%'])
%
wl = y(:,4);
figure(2)
plot(t,wl,'r-'), grid
title('w_L')
xlabel('Time (secs)')
ylabel('w_L (m)')
disp(['wL_max: ' num2str(norm(wl,inf))])
%
ur = y(:,5);
figure(3)
plot(t,ur,'r-'), grid
title('Closed-loop control')
xlabel('Time (secs)')
ylabel('u (V)')
disp(['u_max: ' num2str(norm(ur,inf))])
%
clear ref1, clear ref2, clear dist
clear noise1, clear noise2