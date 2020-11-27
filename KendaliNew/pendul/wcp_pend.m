% Worst case performance analysis of the triple inverted pendulum
%
sim_pend
clp_ic = lft(pend_sm,K,2,6);
%
% determine worst case uncertainty
T = clp_ic(1:3,1:3);
[maxgain,maxgainunc] = wcgain(T);
Twc = usubs(T,maxgainunc);
%
% worst case singular values
T20 = usample(T,20);
omega = logspace(-2,2,400);
figure(1)
sigma(Twc,'r-',T20,'b-.',omega), grid
axis([10^(-2) 10^2 -100 50])
title('Uncertain closed-loop system singular values')
legend('Worst case','Random samples')
%
% worst case transient response
clp = usubs(clp_ic,maxgainunc);
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
figure(2)
[y,t] = lsim(clp(1:8,1:9),[ref,dist,noise],time);
plot(t,y(:,1),'b--',t,y(:,2),'g-.',t,y(:,3),'r-')
grid
title('Worst case closed-loop transient response')
xlabel('Time (secs)')
ylabel('y_1, y_2, y_3 (rads)')
legend('y_1','y_2','y_3',4)
figure(3)
plot(t,y(:,4),'r-',t,y(:,5),'b--')
grid
title('Worst case closed-loop control')
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
figure(4)
[y,t] = lsim(clp(1:8,1:9),[ref,dist,noise],time);
plot(t,y(:,1),'b--',t,y(:,2),'g-.',t,y(:,3),'r-')
grid
title('Worst case closed-loop disturbance response')
xlabel('Time (secs)')
ylabel('y_1, y_2, y_3 (rads)')
legend('y_1','y_2','y_3')
figure(5)
plot(t,y(:,4),'r-',t,y(:,5),'b--')
grid
title('Worst case closed-loop control')
xlabel('Time (secs)')
ylabel('u_1, u_2 (V)')
legend('u_1','u_2',4)
clear ref1,   clear ref2,   clear ref3
clear dist1,  clear dist2,  clear dist3
clear noise1; clear noise2; clear noise3