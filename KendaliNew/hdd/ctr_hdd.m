% Nominal transient responses of the closed loop systems
% for three controllers
%
sim_hdd
%
% response to the reference
r = 1.2;                                % 1 track --> 1.2 V 
ti = 0.000001;                          % time increment
tfin = 0.004;                           % final time value
time = 0:ti:tfin;
nstep = size(time,2);
ref(1:nstep) = r;
dist(1:nstep) = 0.0;
noise(1:nstep) = 0.0;
%
% mu-controller
clp_mu = lft(sim_ic,K_mu,1,1);
[y,t] = lsim(clp_mu.Nominal(1:2,1:3),[ref',dist',noise'],time);
yr_mu = y(:,1);
ur_mu = y(:,2);
err_mu  = ref' - yr_mu;                 % PES in volts
errm_mu = err_mu/r;                     % PES in tracks
%
% Hinf controller
clp_hin = lft(sim_ic,K_hin,1,1);
[y,t] = lsim(clp_hin.Nominal(1:2,1:3),[ref',dist',noise'],time);
yr_hin = y(:,1);
ur_hin = y(:,2);
err_hin  = ref' - yr_hin;               % PES in volts
errm_hin = err_hin/r;                   % PES in tracks
%
% Loop shaping controller
clp_lsh = lft(sim_ic,K_lsh,1,1);
[y,t] = lsim(clp_lsh.Nominal(1:2,1:3),[ref',dist',noise'],time);
yr_lsh = y(:,1);
ur_lsh = y(:,2);
err_lsh  = ref' - yr_lsh;               % PES in volts
errm_lsh = err_lsh/r;                   % PES in tracks
%
figure(1)
plot(t,errm_mu,'r-',t,errm_hin,'b--',t,errm_lsh,'m-.')
grid
title('Closed-loop transient response')
xlabel('Time (secs)')
ylabel('Position Error Signal (tracks)')
legend('\mu-controller','H_\infty controller', ...
       'Loop shaping controller',4)
figure(2)
plot(t,ur_mu,'r-',t,ur_hin,'b--',t,ur_lsh,'m-.')
grid
axis([0 0.0005  -1  1.5])
title('Control action due to reference')
xlabel('Time (secs)')
ylabel('u (V)')
legend('\mu-controller','H_\infty controller', ...
       'Loop shaping controller',1)
clear ref, clear dist, clear noise
%
% response to the disturbance
r = 1.2;                                % 1 track --> 1.2 V 
ti = 0.000001;                          % time increment
tfin = 0.004;                           % final time value
time = 0:ti:tfin;
nstep = size(time,2);
ref(1:nstep) = 0.0;
dist(1:nstep) = 0.0005;                 % Td = 0.0005 N.m
noise(1:nstep) = 0.0;
%
% mu-controller
[y,t] = lsim(clp_mu.Nominal(1:2,1:3),[ref',dist',noise'],time);
yd_mu = y(:,1);
ud_mu = y(:,2);
err_mu  = ref' - yd_mu;                 % PES in volts
errm_mu = err_mu/r;                     % PES in tracks
%
% Hinf controller
[y,t] = lsim(clp_hin.Nominal(1:2,1:3),[ref',dist',noise'],time);
yd_hin = y(:,1);
ud_hin = y(:,2);
err_hin  = ref' - yd_hin;               % PES in volts
errm_hin = err_hin/r;                   % PES in tracks
%
% Loop shaping controller
[y,t] = lsim(clp_lsh.Nominal(1:2,1:3),[ref',dist',noise'],time);
yd_lsh = y(:,1);
ud_lsh = y(:,2);
err_lsh  = ref' - yd_lsh;               % PES in volts
errm_lsh = err_lsh/r;                   % PES in tracks
%
figure(3)
plot(t,errm_mu,'r-',t,errm_hin,'b--',t,errm_lsh,'m-.')
grid
title('Transient response to disturbance')
xlabel('Time (secs)')
ylabel('Position Error Signal (tracks)')
legend('\mu-controller','H_\infty controller', ...
       'Loop shaping controller',4)
figure(4)
plot(t,ud_mu,'r-',t,ud_hin,'b--',t,ud_lsh,'m-.')
grid
axis([0 0.002  -0.015 0.005])
title('Control action due to disturbance')
xlabel('Time (secs)')
ylabel('u (V)')
legend('\mu-controller','H_\infty controller', ...
       'Loop shaping controller',1)
clear ref, clear dist, clear noise