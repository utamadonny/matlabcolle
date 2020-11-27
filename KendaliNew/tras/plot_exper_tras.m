% Plot the experimental results for Twin-Rotor Aerodynamic System
%
% plot azimuth rpm
figure(1)
subplot(2,1,1)
plot(rt_RPM.time,rt_RPM.signals(1).values(:,1)), grid
xlabel('Time (secs)')
ylabel('\omega_h')
title('Azimuth rpm')
%
% plot pich rpm
subplot(2,1,2)
plot(rt_RPM.time,rt_RPM.signals(1).values(:,2)), grid
xlabel('Time (secs)')
ylabel('\omega_v')
title('Pitch rpm')
%
% plot azimuth angle and reference
figure(2)
subplot(2,1,1)
plot(rt_AngleReference1.time, ...
     rt_AngleReference1.signals(1).values(:,1),'b--', ...
     rt_AngleReference1.time, ...
     rt_AngleReference1.signals(1).values(:,2),'r-'), grid
axis([0 120 -0.6 0.6])  % alpha_h_ref = 0.4
%axis([0 120 -0.2 0.2]) % alpha_h_ref = 0.1
xlabel('Time (secs)')
ylabel('\alpha_h')
title('Experimental transient responses')
%
% plot pitch angle and reference
subplot(2,1,2)
plot(rt_AngleReference1.time, ...
     rt_AngleReference1.signals(2).values(:,1),'b--', ...
     rt_AngleReference1.time, ...
     rt_AngleReference1.signals(2).values(:,2),'r-'), grid
axis([0 120 -0.2 0.15]) 
xlabel('Time (secs)')
ylabel('\alpha_v')
%
% plot azimuth control action
figure(3)
subplot(2,1,1)
plot(rt_AngleCtrl2.time,rt_AngleCtrl2.signals(1).values,'r-'), grid
xlabel('Time (secs)')
ylabel('u_h')
title(rt_AngleCtrl2.signals(1).title)
%
% plot pitch control action
subplot(2,1,2)
plot(rt_AngleCtrl3.time,rt_AngleCtrl3.signals(1).values,'r-'), grid
xlabel('Time (secs)')
ylabel('u_v')
title(rt_AngleCtrl3.signals(1).title)
%
% plot filtrated control actions
%
% azimuth control action
time_1 = rt_AngleCtrl2.time; time_1 = [0; time_1];
control_1 = rt_AngleCtrl2.signals(1).values; control_1 = [0.8; control_1];
f_s = 0.24;
[num_1,den_1] = butter(1,2*pi*f_s,'s'); % 1st order Butterworth filter
[u_1,x_1] = lsim(num_1,den_1,control_1,time_1);
figure(4)
subplot(2,1,1)
plot(time_1,u_1,'r-'), grid
axis([0 120 -0.4 0.4])
xlabel('Time (secs)')
ylabel('u_h')
title('Azimuth control')
%
% pitch control action
time_2 = rt_AngleCtrl3.time;
control_2 = rt_AngleCtrl3.signals(1).values;
f_s = 0.16;
[num_2,den_2] = butter(1,2*pi*f_s,'s'); % 1st order Butterworth filter
[u_2,x_2] = lsim(num_2,den_2,control_2,time_2);
subplot(2,1,2)
plot(time_2,u_2,'r-'), grid
axis([0 120 0.1 0.5]) 
xlabel('Time (secs)')
ylabel('u_v')
title('Pitch control')
