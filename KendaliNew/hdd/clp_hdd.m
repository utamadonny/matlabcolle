% Transient responses of the closed_loop system
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
[y,t] = lsim(clp.Nominal(1:2,1:3),[ref',dist',noise'],time);
yr = y(:,1);
ur = y(:,2);
ym = yr/r;
err  = ref' - yr;                        % PES in volts
errm = err/r;                            % PES in tracks
figure(1)
plot(t,errm,'c-')
grid
title('Closed-loop transient response')
xlabel('Time (secs)')
ylabel('Position Error Signal (tracks)')
disp(['overshoot: ' num2str(100*(norm(ym,inf)-1)) '%'])
figure(2)
plot(t,y(:,2),'r-')
axis([0 0.0005 -0.6 1.4])
grid
title('Control action, due to reference')
xlabel('Time (secs)')
ylabel('u (V)')
disp(['u_max: ' num2str(norm(ur,inf)) 'V'])
clear ref, clear dist, clear noise
%
% response to the disturbance
r = 1.2;                                % 1 track --> 1.2 V 
ti = 0.000001;                          % time increment
tfin = 0.005;                           % final time value
time = 0:ti:tfin;
nstep = size(time,2);
ref(1:nstep) = 0.0;
dist(1:nstep) = 0.0005;                 % Td = 0.0005 N.m
noise(1:nstep) = 0.0;
[y,t] = lsim(clp.Nominal(1:2,1:3),[ref',dist',noise'],time);
yd = y(:,1);
ud = y(:,2);
ym = yd/r;
err  = ref' - yd;                       % PES in volts
errm = err/r;                           % PES in tracks
figure(3)
plot(t,errm,'c-')
grid
title('Transient response to disturbance')
xlabel('Time (secs)')
ylabel('Position Error Signal (tracks)')
disp(['dist. error: ' num2str(100*(norm(ym,inf))) '%'])
figure(4)
plot(t,ud,'r-')
grid
title('Control action due to disturbance')
xlabel('Time (secs)')
ylabel('u (V)')
clear ref, clear dist, clear noise
%
% response to noise
rand('state',0)
r = 1.2;                                % 1 track --> 1.2 V 
ti = 0.000001;                          % time increment
tfin = 0.005;                           % final time value
time = 0:ti:tfin;
nstep = size(time,2);
ref(1:nstep) = 0.0;
dist(1:nstep) = 0.0;                 
noise(1:nstep) = 2.0*(rand(1,nstep)-0.5*ones(1,nstep));
[y,t] = lsim(clp.Nominal(1:2,1:3),[ref',dist',noise'],time);
yn = y(:,1);
un = y(:,2);
ym = yn/r;
err  = ref' - yn;                       % PES in volts
errm = err/r;                           % PES in tracks
figure(5)
plot(t,errm,'c-')
grid
title('Transient response to noise')
xlabel('Time (secs)')
ylabel('Position Error Signal (tracks)')
disp(['noise error: ' num2str(100*(norm(ym,inf))) '%'])
figure(6)
plot(t,un,'r-')
grid
title('Control action due to noise')
xlabel('Time (secs)')
ylabel('u (V)')
clear ref, clear dist, clear noise