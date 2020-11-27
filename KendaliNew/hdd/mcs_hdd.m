% Transient responses of the closed-loop system
% for random values of the uncertain parameters
%
sim_hdd
clp = lft(sim_ic,K,1,1);
%
% response to the reference
r = 1.2;                                % 1 track --> 1.2 V 
ti = 0.000001;                          % time increment
tfin = 0.005;                           % final time value
time = 0:ti:tfin;
nstep = size(time,2);
ref(1:nstep) = r;
dist(1:nstep) = 0.0;
noise(1:nstep) = 0.0;
nsample = 30;
clp_30 = usample(clp,nsample);
for i = 1:nsample
    [y,t] = lsim(clp_30(1:2,1:3,i),[ref',dist',noise'],time);
    yr = y(:,1);
    err  = ref' - yr;                   % PES in volts
    errm = err/r;                       % PES in tracks
    figure(1)
    plot(t,errm,'b-')
    hold on
    ur = y(:,2);
    figure(2)
    plot(t,ur,'r-')
    axis([0 0.0005 -0.6 1.4])
    hold on
end
figure(1)
grid
title('Closed-loop transient response')
xlabel('Time (secs)')
ylabel('Position Error Signal (tracks)')
hold off
figure(2)
grid
title('Control action, due to reference')
xlabel('Time (secs)')
ylabel('u (V)')
hold off
clear ref, clear dist, clear noise
%
% response to the disturbance
r = 1.2;                                % 1 track --> 1.2 V 
ti = 0.000001;                           % time increment
tfin = 0.005;                           % final time value
time = 0:ti:tfin;
nstep = size(time,2);
ref(1:nstep) = 0.0;
dist(1:nstep) = 0.0005;                 % Td = 0.0005 N.m
noise(1:nstep) = 0.0;
nsample = 30;
clp_30 = usample(clp,nsample);
for i = 1:nsample
    [y,t] = lsim(clp_30(1:2,1:3,i),[ref',dist',noise'],time);
    yd = y(:,1);
    err  = ref' - yd;                   % PES in volts
    errm = err/r;                       % PES in tracks
    figure(3)
    plot(t,errm,'b-')
    hold on
    ud = y(:,2);
    figure(4)
    plot(t,ud,'r-')
    axis([0 0.0005 -0.02 0.01])
    hold on
end 
figure(3)
grid
title('Transient response to disturbance')
xlabel('Time (secs)')
ylabel('Position Error Signal (tracks)')
hold off
figure(4)
grid
title('Control action due to disturbance')
xlabel('Time (secs)')
ylabel('u (V)')
hold off
clear ref, clear dist, clear noise