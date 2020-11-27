% Set the parameters for the discrete-time triple inverted pendulum
% simulation
%
% Noise shaping filters
kf = 0.00002; Tf1 = 10; Tf2 = 0.1;
%
% Sensors
alf1 = 1.146; alf2 = 1.146; alf3 = 0.9964;
Cp = [ alf1    0   0  
      -alf2  alf2  0  
        0   -alf3 alf3];
%
% Actuators
gd1 = 1.080; Td1 = 0.005;
gd2 = 0.335; Td2 = 0.002;
%
% sampling interval
Ts = input ('Enter sampling period Ts = ');
%
% Discrete-time controller
KD = c2d(K,Ts);
%
% calculation delay
tau = Ts;
[num,den] = pade(tau,1);
delay = tf(num,den);
ddelay = c2d(delay,Ts);
K2 = series(blkdiag(ddelay,ddelay,ddelay,ddelay,ddelay,ddelay),KD);
[Akd,Bkd,Ckd,Dkd] = ssdata(K2);
%
% ADC and DAC parameters
u_adc =  5;      % V
B_adc = 14;      % digits
u_dac =  5;      % V 
B_dac = 14;      % digits 