% Transient responses of the closed_loop
%
% Controller inputs:  1)  ref
%                     2)  theta + noise1
%                     3)  d2alpha/dt2 + noise2
%
% response to the reference
sim_flm
clp = lft(sim_ic,K,1,3);
%
ti = 0.001;     % time increment                     
tfin1 = 1;
time1 = 0:ti:tfin1;
nstep1 = size(time1,2);
ref1(1:nstep1) = pi*time1(1:nstep1)/12-sin(2*pi*time1(1:nstep1))/24;
tfin2 = 3;      % final time value
time2 = tfin1+ti:ti:tfin2;
nstep2 = size(time2,2);
ref2(1:nstep2) = pi/12;
time = [time1, time2];
ref = [ref1,ref2]; 
dist(1:nstep1+nstep2) = 0;
noise1(1:nstep1+nstep2) = 0;
noise2(1:nstep1+nstep2) = 0;
nsample = 30;
clp_30 = usample(clp,nsample);
for i = 1:nsample
    [y,t] = lsim(clp_30(1:5,1:4,i),[ref',dist',noise1',noise2'],time);
%
    alpha = y(:,1);
    theta = y(:,2);
    figure(1)
    plot(t,ref,'b--',t,alpha,'r-',t,theta,'c-.'), grid
    hold on
%
    wl = y(:,4);
    figure(2)
    plot(t,wl,'r-'), grid
    hold on
%
    ur = y(:,5);
    figure(3)
    plot(t,ur,'r-'), grid
    hold on
end
%
figure(1)
grid
title('Closed-loop transient response')
xlabel('Time (secs)')
ylabel('ref, \alpha, \theta')
legend('ref','\alpha','\theta',4)
hold off
figure(2)
grid
title('w_L')
xlabel('Time (secs)')
ylabel('w_L (m)')
hold off
figure(3)
grid
title('Closed-loop control')
xlabel('Time (secs)')
ylabel('u (V)')
hold off
%
clear ref1, clear ref2
clear noise1, clear noise2