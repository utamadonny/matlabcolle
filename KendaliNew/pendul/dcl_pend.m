% Simulation of the sampled-data closed-loop triple inverted
% pendulum system
%
sim_pend
%
% sampling interval
Ts = input ('Enter sampling period Ts = ');
%
% discrete-time controller
KD = c2d(K,Ts);
%
% response to the reference input
ti = 0.1;
tfin = 20;
time = 0:ti:tfin;
nstep = size(time,2);
ref1(1:nstep) = 0.0; ref2(1:nstep) = -0.1; ref3(1:nstep) = 0.2;
ref = [ref1' ref2' ref3'];
dist1(1:nstep) = 0.0; dist2(1:nstep) = 0.0; dist3(1:nstep) = 0.0;
dist = [dist1' dist2' dist3'];
noise1(1:nstep) = 0.0; noise2(1:nstep) = 0.0; noise3(1:nstep) = 0.0;
noise = [noise1' noise2' noise3'];
nsample = 30;
pend_30 = usample(pend_sm,nsample);
for i = 1:nsample
    [v,y,u,t] = sdlsim(pend_30(1:14,1:11,i),KD,[ref,dist,noise],time);
    figure(1)
    plot(t{:},v{2}(:,1),'b--',t{:},v{2}(:,2),'g-.',t{:},v{2}(:,3),'r-')
    hold on
    figure(2)
    plot(t{:},v{2}(:,4),'r-',t{:},v{2}(:,5),'b--')
    hold on
end
figure(1)
grid
title('Closed-loop transient response')
xlabel('Time (secs)')
ylabel('y_1, y_2, y_3 (rads)')
legend('y_1','y_2','y_3',3)
hold off
figure(2)
grid
title('Closed-loop control')
xlabel('Time (secs)')
ylabel('u_1, u_2 (V)')
legend('u_1','u_2',3)
hold off
clear v, clear y, clear u, clear t
clear ref1,   clear ref2,   clear ref3
clear dist1,  clear dist2,  clear dist3
clear noise1; clear noise2; clear noise3
%
% response to the disturbance
ti = 0.1;
time = 0:ti:20;
nsamp = size(time,2);
ref1(1:nsamp) = 0.0; ref2(1:nsamp) = 0.0; ref3(1:nsamp) = 0.0;
ref = [ref1' ref2' ref3'];
dist1(1:nsamp) = 0.1; dist2(1:nsamp) = 0.1; dist3(1:nsamp) = 0.1;
dist = [dist1' dist2' dist3'];
noise1(1:nsamp) = 0.0; noise2(1:nsamp) = 0.0; noise3(1:nsamp) = 0.0;
noise = [noise1' noise2' noise3'];
for i = 1:nsample
    [v,y,u,t] = sdlsim(pend_30(1:14,1:11,i),KD,[ref,dist,noise],time);
    figure(3)
    plot(t{:},v{2}(:,1),'b--',t{:},v{2}(:,2),'g-.',t{:},v{2}(:,3),'r-')
    hold on
    figure(4)
    plot(t{:},v{2}(:,4),'r-',t{:},v{2}(:,5),'b--')
    hold on
end
figure(3)
grid
title('Closed-loop disturbance response')
xlabel('Time (secs)')
ylabel('y_1, y_2, y_3 (rads)')
legend('y_1','y_2','y_3')
hold off
clear v, clear y, clear u, clear t
figure(4)
grid
title('Closed-loop control')
xlabel('Time (secs)')
ylabel('u_1, u_2 (V)')
legend('u_1','u_2',4)
hold off
clear v, clear y, clear u, clear t
clear ref1,   clear ref2,   clear ref3
clear dist1,  clear dist2,  clear dist3
clear noise1; clear noise2; clear noise3