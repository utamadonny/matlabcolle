% Simulation of the triple inverted pendulum closed-loop system
% for random values of uncertain parameters
%
sim_pend
clp_ic = lft(pend_sm,K,2,6);
%
% response to the reference input
time = 0:0.03:30;
nstep = size(time,2);
ref1(1:nstep) = 0.0; ref2(1:nstep) = -0.1; ref3(1:nstep) = 0.2;
ref = [ref1' ref2' ref3'];
dist1(1:nstep) = 0.0; dist2(1:nstep) = 0.0; dist3(1:nstep) = 0.0;
dist = [dist1' dist2' dist3'];
noise1(1:nstep) = 0.0; noise2(1:nstep) = 0.0; noise3(1:nstep) = 0.0;
noise = [noise1' noise2' noise3'];
nsample = 30;
clp_ic30 = usample(clp_ic,nsample);
figure(1)
hold off
figure(2)
hold off
for i = 1:nsample
    [y,t] = lsim(clp_ic30(1:8,1:9,i),[ref,dist,noise],time);
    figure(1)
    plot(t,y(:,1),'b--',t,y(:,2),'g-.',t,y(:,3),'r-')
    hold on
    figure(2)
    plot(t,y(:,4),'r-',t,y(:,5),'b--')
    hold on
end 
figure(1)
grid
title('Closed-loop transient response')
xlabel('Time (secs)')
ylabel('y_1, y_2, y_3 (rads)')
legend('y_1','y_2','y_3',3)
figure(2)
grid
title('Closed-loop control')
xlabel('Time (secs)')
ylabel('u_1, u_2 (V)')
legend('u_1','u_2',3)
clear ref1,   clear ref2,   clear ref3
clear dist1,  clear dist2,  clear dist3
clear noise1, clear noise2, clear noise3
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
nsample = 30;
clp_ic30 = usample(clp_ic,nsample);
figure(3)
hold off
figure(4)
hold off
for i = 1:nsample
    [y,t] = lsim(clp_ic30(1:8,1:9,i),[ref,dist,noise],time);
    figure(3)
    plot(t,y(:,1),'b--',t,y(:,2),'g-.',t,y(:,3),'r-')
    hold on
    figure(4)
    plot(t,y(:,4),'r-',t,y(:,5),'b--')
    hold on
end  
figure(3)
grid
title('Closed-loop disturbance response')
xlabel('Time (secs)')
ylabel('y_1, y_2, y_3 (rads)')
legend('y_1','y_2','y_3')
figure(4)
grid
title('Closed-loop control')
xlabel('Time (secs)')
ylabel('u_1, u_2 (V)')
legend('u_1','u_2',4)
clear ref1,   clear ref2,   clear ref3
clear dist1,  clear dist2,  clear dist3
clear noise1, clear noise2, clear noise3