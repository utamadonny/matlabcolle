% Simulation of the triple inverted pendulum closed-loop system
%
sim_pend
clp = lft(pend_sm,K,2,6);
%
% response to the reference input
time = 0:0.02:20;
nstep = size(time,2);
ref1(1:nstep) = 0.0; ref2(1:nstep) = -0.1; ref3(1:nstep) = 0.2;
ref = [ref1' ref2' ref3'];
dist1(1:nstep) = 0.0; dist2(1:nstep) = 0.0; dist3(1:nstep) = 0.0;
dist = [dist1' dist2' dist3'];
noise1(1:nstep) = 0.0; noise2(1:nstep) = 0.0; noise3(1:nstep) = 0.0;
noise = [noise1' noise2' noise3'];
figure(1)
[y,t] = lsim(clp.Nominal(1:8,1:9),[ref,dist,noise],time);
plot(t,y(:,1),'b--',t,y(:,2),'g-.',t,y(:,3),'r-')
grid
title('Closed-loop transient response')
xlabel('Time (secs)')
ylabel('y_1, y_2, y_3 (rads)')
legend('y_1','y_2','y_3',4)
figure(2)
plot(t,y(:,4),'r-',t,y(:,5),'b--')
grid
title('Closed-loop control')
xlabel('Time (secs)')
ylabel('u_1, u_2 (V)')
legend('u_1','u_2',3)
clear ref1,   clear ref2,   clear ref3
clear dist1,  clear dist2,  clear dist3
clear noise1; clear noise2; clear noise3
%
% response to the disturbance
time = 0:0.02:20;
nstep = size(time,2);
ref1(1:nstep) = 0.0; ref2(1:nstep) = 0.0; ref3(1:nstep) = 0.0;
ref = [ref1' ref2' ref3'];
dist1(1:nstep) = 0.1; dist2(1:nstep) = 0.1; dist3(1:nstep) = 0.1;
dist = [dist1' dist2' dist3'];
noise1(1:nstep) = 0.0; noise2(1:nstep) = 0.0; noise3(1:nstep) = 0.0;
noise = [noise1' noise2' noise3'];
figure(3)
[y,t] = lsim(clp.Nominal(1:8,1:9),[ref,dist,noise],time);
plot(t,y(:,1),'b--',t,y(:,2),'g-.',t,y(:,3),'r-')
grid
title('Closed-loop disturbance response')
xlabel('Time (secs)')
ylabel('y_1, y_2, y_3 (rads)')
legend('y_1','y_2','y_3')
figure(4)
plot(t,y(:,4),'r-',t,y(:,5),'b--')
grid
title('Closed-loop control')
xlabel('Time (secs)')
ylabel('u_1, u_2 (V)')
legend('u_1','u_2',4)
clear ref1,   clear ref2,   clear ref3
clear dist1,  clear dist2,  clear dist3
clear noise1; clear noise2; clear noise3
%
% response to the noise
rand('state',0)
time = 0:0.02:20;
nstep = size(time,2);
ref1(1:nstep) = 0.0; ref2(1:nstep) = 0.0; ref3(1:nstep) = 0.0;
ref1(1:nstep) = 0.0; ref2(1:nstep) = 0.0; ref3(1:nstep) = 0.0;
ref = [ref1' ref2' ref3'];
dist1(1:nstep) = 0.0; dist2(1:nstep) = 0.0; dist3(1:nstep) = 0.0;
dist = [dist1' dist2' dist3'];
noise1(1:nstep) = 0.0; noise2(1:nstep) = 0.0; 
noise3(1:nstep) = 1.3*(rand(1,nstep)-0.5*ones(1,nstep));
noise = [noise1' noise2' noise3'];
figure(5)
[y,t] = lsim(clp.nom(1:8,1:9),[ref,dist,noise],time);
plot(t,y(:,3),'r-')
grid
title('Closed-loop noise response')
xlabel('Time (secs)')
ylabel('y_3 (rads)')
figure(6)
subplot(2,1,1)
plot(t,y(:,4),'r-')
grid
title('Closed-loop control')
xlabel('Time (secs)')
ylabel('u_1 (V)')
subplot(2,1,2)
plot(t,y(:,5),'r-')
grid
xlabel('Time (secs)')
ylabel('u_2 (V)')
clear ref1,   clear ref2,   clear ref3
clear dist1,  clear dist2,  clear dist3
clear noise1; clear noise2; clear noise3