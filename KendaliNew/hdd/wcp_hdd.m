% Worst case performance of the Hard Disk Drive Servo system
%
sim_hdd
clp_ic = lft(sim_ic,K,1,1);
%
% determine worst case uncertainty
T = clp_ic(1,1);
[maxgain,maxgainunc] = wcgain(T);
Twc = usubs(T,maxgainunc);
T20 = usample(T,20);
%
% worst case frequency response
w = logspace(2,5,400);
figure(1)
bodemag(Twc,'r-',T20,'b-.',w), grid
title('Uncertain closed-loop system Bode plots')
legend('Worst case','Random samples',3)
%
% worst case transient response
clp = usubs(clp_ic,maxgainunc);
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
[y,t] = lsim(clp(1:2,1:3),[ref',dist',noise'],time);
yr = y(:,1);
ur = y(:,2);
ym = yr/r;
err  = ref' - yr;                       % PES in volts
errm = err/r;                           % PES in tracks
figure(2)
plot(t,errm,'c-')
grid
title('Worst case closed-loop transient response')
xlabel('Time (secs)')
ylabel('Position Error Signal (tracks)')
disp(['overshoot: ' num2str(100*(norm(ym,inf)-1)) '%'])
figure(3)
plot(t,y(:,2),'r-')
axis([0 0.0005 -0.6 1.2])
grid
title('Worst case control action, due to reference')
xlabel('Time (secs)')
ylabel('u (V)')
disp(['u_max: ' num2str(norm(ur,inf)) 'V'])
clear ref, clear dist, clear noise
%
% disturbance response 
r = 1.2;                                % 1 track --> 1.2 V 
ti = 0.000001;                          % time increment
tfin = 0.005;                           % final time value
time = 0:ti:tfin;
nstep = size(time,2);
ref(1:nstep) = 0.0;
dist(1:nstep) = 0.0005;                 % Td = 0.0005 N.m
noise(1:nstep) = 0.0;
[y,t] = lsim(clp(1:2,1:3),[ref',dist',noise'],time);
yd = y(:,1);
ud = y(:,2);
ym = yd/r;
err  = ref' - yd;                       % PES in volts
errm = err/r;                           % PES in tracks
figure(4)
plot(t,errm,'c-')
grid
title('Worst case transient response to disturbance')
xlabel('Time (secs)')
ylabel('Position Error Signal (tracks)')
disp(['dist. error: ' num2str(100*(norm(ym,inf))) '%'])
figure(5)
plot(t,ud,'r-')
grid
title('Worst case control action due to disturbance')
xlabel('Time (secs)')
ylabel('u (V)')
clear ref, clear dist, clear noise