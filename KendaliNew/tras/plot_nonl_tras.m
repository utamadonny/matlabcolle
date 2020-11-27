% Plot results from simulation of the nonlinear 
% Two Rotor Aerodynamic System
%
figure(1)
%
% plot azimuth angle and reference
subplot(2,1,1)
plot(t,y(:,1),'b--',t,y(:,3),'r-'), grid
axis([0 120 -0.6 0.6])
xlabel('Time (secs)')
ylabel('\alpha_h')
title('Nonlinear system transient responses')
%
% plot pitch angle and reference
subplot(2,1,2)
plot(t,y(:,2),'b--',t,y(:,4),'r-'), grid
axis([0 120 -0.2 0.15]) 
xlabel('Time (secs)')
ylabel('\alpha_v')
%
figure(2)
%
% plot azimuth control action
subplot(2,1,1)
plot(t,y(:,5),'r-'), grid
axis([0 120 -0.4 0.4])
xlabel('Time (secs)')
ylabel('u_h')
title('Nonlinear system control actions')
%
% plot pitch control action
subplot(2,1,2)
plot(t,y(:,6),'r-'), grid
axis([0 120 0.2 0.4]) 
xlabel('Time (secs)')
ylabel('u_v')