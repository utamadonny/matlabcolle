% Simulation of the discrete-time closed-loop Hard Disk Drive
% Servo system with sampled controller
%
sim_hdd
%
% sampling interval
Ts = input ('Enter sampling period Ts = ');
%
% discrete-time plant
[M,Delta] = lftdata(sim_ic);
Md = c2d(M,Ts);
dsim_ic = lft(Delta,Md);
%
% sampled controller
KD = c2d(K,Ts);
%
% discrete-time closed-loop system
dclp = lft(dsim_ic,KD,1,1);
% response to the reference
r = 1.2;                                % 1 track --> 1.2 V 
ti = 0.00001;                           % time increment
tfin = 0.005;                           % final time value
time = 0:ti:tfin;
nstep = size(time,2);
ref(1:nstep) = r;
dist(1:nstep) = 0.0;
noise(1:nstep) = 0.0;
nsample = 30;
sim_30 = usample(sim_ic,nsample);
for i = 1:nsample
    [v,y,u,t] = sdlsim(sim_30(1:3,1:4,i),KD,[ref',dist',noise'],time);
    err  = y{2};                        % PES in volts
    errm = err/r;                       % PES in tracks
    figure(1)
    plot(t{:},errm,'c-')
    hold on
    figure(2)
    plot(t{:},u{2},'r-')
    axis([0 0.0005 -0.8 1.5])
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
ti = 0.00001;                           % time increment
tfin = 0.005;                           % final time value
time = 0:ti:tfin;
nstep = size(time,2);
ref(1:nstep) = 0.0;
dist(1:nstep) = 0.0005;                 % Td = 0.0005 N.m
noise(1:nstep) = 0.0;
for i = 1:nsample
    [v,y,u,t] = sdlsim(sim_30(1:3,1:4,i),KD,[ref',dist',noise'],time);
    err  = y{2};                        % PES in volts
    errm = err/r;                       % PES in tracks
    figure(3)
    plot(t{:},errm,'c-')
    hold on
    figure(4)
    plot(t{:},u{2},'r-')
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