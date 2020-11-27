% Sample-data system transient responses of the Twin-Rotor
% Aerodynamic System (nominal parameters)
%
sim_tras
%
% response to the reference input
r1 = 0.4;     % rad
r2 = 0.1;     % rad
ti = 0.01;    % sampling time
[ref,time] = gensig('square',50,120,ti);
ref1 = r1*(2*ref - 1);
[ref,time] = gensig('square',60,120,ti);
%[ref,time] = gensig('sin',60,120,ti);
ref2 = r2*(2*ref - 1);
nstep = size(time,1);
dist1(1:nstep) = 0.0;
dist2(1:nstep) = 0.0;
noise1(1:nstep) = 0.0;
noise2(1:nstep) = 0.0;
[v,y,u,t] = sdlsim(sim_ic.Nom(1:12,1:8),Kd,[dist1',dist2',ref1,ref2,noise1',noise2'],time);
nstep = size(t{1},1);
figure(1)
subplot(2,1,1)
plot(t{:},v{2}(:,1),'b-')
grid
xlabel('Time (secs)')
ylabel('\omega_h')
title('Azimuth and pitch rpm')
subplot(2,1,2)
plot(t{:},v{2}(:,4),'b-')
grid
xlabel('Time (secs)')
ylabel('\omega_v')
figure(2)
subplot(2,1,1)
plot(t{:},v{2}(:,2),'b-')
grid
xlabel('Time (secs)')
ylabel('\Omega_h')
title('Azimuth and pitch velocities')
subplot(2,1,2)
plot(t{:},v{2}(:,5),'b-')
grid
xlabel('Time (secs)')
ylabel('\Omega_v')
figure(3)
subplot(2,1,1)
plot(time,ref1,'b--')
hold on
plot(t{:},v{2}(:,3),'r-')
grid
title('Closed-loop Transient Responses')
xlabel('Time (secs)')
ylabel('\alpha_h')
hold off
subplot(2,1,2)
plot(time,ref2,'b--')
hold on
plot(t{:},v{2}(:,6),'r-')
grid
xlabel('Time (secs)')
ylabel('\alpha_v')
hold off
figure(4)
subplot(2,1,1)
plot(t{:},v{2}(:,7),'r-')
grid
xlabel('Time (secs)')
ylabel('u_h')
title('Azimuth and pitch control actions')
subplot(2,1,2)
plot(t{:},v{2}(:,8),'r-')
grid
xlabel('Time (secs)')
ylabel('u_v')
%
clear ref1, clear ref2
clear dist1, clear dist2
clear noise1, clear noise2