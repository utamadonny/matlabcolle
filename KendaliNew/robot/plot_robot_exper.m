% Plot the results of Two-Wheeled Robot Control experiments
%
M = csvread('data_robot_2dof.csv',1,0);
[n,m] = size(M);
i_0 = 2650;                           % initial measurement
i_0 = 1;
i_f = 6500;                           % final measurement
%i_f = n;                           
T_0 = M(i_0,1)/1000;                  % initial time (s)
T_f = M(i_f,1)/1000;                  % final time (s)
for i = i_0:i_f
    time(i-i_0+1) = M(i,1)/1000 - T_0;% shift time
end 
%
% Left pwm
pwm_l = M(i_0:i_f,2);
figure(1)
plot(time,pwm_l,'r-'), grid
axis([0 T_f-T_0 -100 100])
xlabel('Time (s)')
ylabel('pwm_l (%)')
title('PWM signal to left motor')
%
% Right pwm
pwm_r = M(i_0:i_f,3);
figure(2)
plot(time,pwm_r,'r-'), grid
axis([0 T_f-T_0 -100 100])
xlabel('Time (s)')
ylabel('pwm_r (%)')
title('PWM signal to right motor')
%
% Battery
battery = M(i_0:i_f,4)/1000;
figure(3)
plot(time,battery), grid
axis([0 T_f-T_0 7.5 8.2])
xlabel('Time (s)')
ylabel('Battery (V)')
title('Battery voltage')
%
% Motor Rev B
rev_b = M(i_0:i_f,6);
figure(4)
plot(time,rev_b), grid
xlabel('Time (s)')
ylabel('Motor B')
title('Motor Revolutions')
%
% Motor Rev C
rev_c = M(i_0:i_f,7);
figure(5)
plot(time,rev_c), grid
xlabel('Time (s)')
ylabel('Motor C')
title('Motor Revolutions')
%
% Body angle
psi = M(i_0:i_f,8)/1024;
%
% remove the gyro bias
psi_dtrend = detrend(psi);
figure(6)
plot(time,psi_dtrend), grid
axis([0 T_f-T_0 -20 20])
xlabel('Time (s)')
ylabel('\Psi (deg)')
title('Body angle')
%
clear time


