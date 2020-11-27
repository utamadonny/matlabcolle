% Transient responses of the Two-Wheeled Robot Control System
% for random values of uncertain parameters
%
% closed-loop interconnection
sim_robot_2dof
%
systemnames      = ' sim_ic ';
inputvar         = '[ ref{4}; noise{2}; control{2} ]';
outputvar        = '[ sim_ic(1:15) ]';
input_to_sim_ic  = '[ ref; noise; control ]';
clp_ic           = sysic;
%
% response to the reference input
time = 0:0.01:25;
nstep = size(time,2);
for i = 1:nstep
    if time(i) <= 5
      ref1(i) = 0.0;
      ref2(i) = 0.0;
    elseif time(i) <= 10
      ref1(i) = 7.5*(time(i) - 5); 
      ref2(i) = 7.5;
    elseif time(i) <= 15
      ref1(i) = 37.5; 
      ref2(i) = 0.0;
    elseif time(i) <= 20
      ref1(i) = 37.5 - 7.5*(time(i) - 15);  
      ref2(i) = -7.5;
    else  
      ref1(i) = 0.0; 
      ref2(i) = 0.0;
    end   
end    
ref3(1:nstep) = 0.0;
ref4(1:nstep) = 0.0;
ref = [ref1' ref2' ref3' ref4'];
noise1(1:nstep) = 0.0; 
noise2(1:nstep) = 0.0;
noise = [noise1' noise2'];
%
nsample = 20;
sim_20 = usample(clp_ic,nsample);
for i = 1:nsample
    [v,y,u,t] = sdlsim(sim_20(1:15,1:8,i),Kd,[ref,noise],time);
    nstep = size(t{1},1);
    figure(1)
    plot(time,ref1,'r--',t{:},v{2}(:,1),'b-')
    hold on
    figure(2)
    plot(time,ref2,'r--',t{:},v{2}(:,3),'b-')
    hold on
    figure(3)
    plot(t{:},v{2}(:,2)*180/pi,'b-')
    hold on
    figure(4)
    plot(t{:},v{2}(:,4)*180/pi,'b-')
    hold on
    figure(5)
    plot(t{:},v{2}(:,5),'r-')
    hold on
    figure(6)
    plot(t{:},v{2}(:,6),'r-')
    hold on
end     
%
figure(1)
grid
xlabel('Time (secs)')
ylabel('Wheels angle \theta (rad)')
title('Closed-loop transient response')
legend('\theta_{ref}','\theta')
hold off
figure(2)
grid
xlabel('Time (secs)')
ylabel('Wheels angular velocity d\theta/dt (rad/s)')
title('Closed-loop transient response')
legend('d\theta_{ref}/dt','d\theta/dt')
hold off
figure(3)
grid
xlabel('Time (secs)')
ylabel('Body pitch angle \psi (deg)')
title('Closed-loop transient response')
axis([0 25 -10 10])
hold off
figure(4)
grid
xlabel('Time (secs)')
ylabel('Body velocity d\psi/dt (deg/s)')
title('Closed-loop transient response')
axis([0 25 -10 10])
hold off
figure(5)
grid
xlabel('Time (secs)')
ylabel('Left motor control u_l (V)')
title('Control action')
hold off
figure(6)
grid
xlabel('Time (secs)')
ylabel('Right motor control u_r (V)')
title('Control action')
hold off
%
clear time
clear ref1,   clear ref2,   clear ref3, clear ref4
clear noise1; clear noise2; 