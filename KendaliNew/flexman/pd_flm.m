% Generates the open-loop connection for the flexible manipulator 
% with PD controller
%
% Controller inputs:  1)  theta + noise
%                     2)  ref
%
mod_flm
%
% Actuator transfer function
nuWa = 1;
dnWa = [0.003   1];
gainWa = 1;
Wa = gainWa*tf(nuWa,dnWa);
%
% construct performance weighting functions
wts_flm
%
% open-loop connection with the weighting functions
systemnames = ' G Wa Wm Wn1 Wp Wu ';
inputvar = '[ ref; dist; noise; control ]';
outputvar = '[ Wp; Wu; ref; G(2) + Wn1 ]';
input_to_G = '[ Wa - dist ]';
input_to_Wa = '[ control ]';
input_to_Wm = '[ ref ]';
input_to_Wn1 = '[ noise ]';
input_to_Wp = '[ G(1) - Wm ]';
input_to_Wu = '[ control ]';
sys_ic_PD = sysic;
outputs = {'e_p' 'e_u' 'ref' 'y_s(1)'};
sys_ic_PD.OutputName = outputs;
%
% PD controller
% 
% PD coefficients
Kp = nd2sys(358,1);
Kd = nd2sys(28.5,1);
Td = 0.002;
%
K_ref = Kp;
nuWth = [(Kd + Kp*Td)  Kp];
dnWth = [Td  1];
gainWth = -1;  % negative feedback
K_theta = gainWth*tf(nuWth,dnWth);
K = ss([K_ref K_theta]);
%
% Generates the open-loop connection for the
% system simulation
systemnames = ' G Wa Wn1 ';
inputvar = '[ ref; dist; noise; control ]';
temp = '[ G(1); G(2); G(3); G(4); ';
outputvar = [temp ' control; ref; G(2) + Wn1 ]'];
input_to_G = '[ Wa - dist ]';
input_to_Wa = '[ control ]';
input_to_Wn1 = '[ noise ]';
sim_ic_PD = sysic;
outputs = {'alpha' 'theta' 'ddalpha' 'wL' 'control' 'ref' 'y_s(1)'};
sim_ic_PD.OutputName = outputs;
%
% Transient responses of the closed_loop
% system
%
% response to the reference
clp = lft(sim_ic_PD,K,1,2);
%
ti = 0.001;     % time increment                     
tfin1 = 1;
time1 = 0:ti:tfin1;
nstep1 = size(time1,2);
ref1(1:nstep1) = pi*time1(1:nstep1)/12-sin(2*pi*time1(1:nstep1))/24;
tfin2 = 3;      % final time value
time2 = tfin1+ti:ti:tfin2;
nstep2 = size(time2,2);
ref2(1:nstep2) = pi/12;
time = [time1, time2];
ref = [ref1,ref2]; 
dist(1:nstep1+nstep2) = 0;
noise(1:nstep1+nstep2) = 0;
nsample = 30;
clp_30 = usample(clp,nsample);
for i = 1:nsample
    [y,t] = lsim(clp_30(1:5,1:3,i),[ref',dist',noise'],time);
%
    alpha = y(:,1);
    theta = y(:,2);
    figure(1)
    plot(t,ref,'b--',t,alpha,'r-',t,theta,'c-.'), grid
    hold on
%
    wl = y(:,4);
    figure(2)
    plot(t,wl,'r-'), grid
    hold on
%
    ur = y(:,5);
    figure(3)
    plot(t,ur,'r-'), grid
    hold on
end
%
figure(1)
grid
title('Closed-loop transient response for the PD controller')
xlabel('Time (secs)')
ylabel('ref, \alpha, \theta')
legend('ref','\alpha','\theta',4)
hold off
figure(2)
grid
title('w_L')
xlabel('Time (secs)')
ylabel('w_L (m)')
hold off
figure(3)
grid
title('Closed-loop control')
xlabel('Time (secs)')
ylabel('u (V)')
hold off
%
clear ref1, clear ref2
clear dist, clear noise