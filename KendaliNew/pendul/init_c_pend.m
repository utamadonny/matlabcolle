% Set the parameters for the triple inverted pendulum simulation
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
% Controller
[Ak,Bk,Ck,Dk] = ssdata(K);
%
% Actuators
gd1 = 1.080; Td1 = 0.005;
gd2 = 0.335; Td2 = 0.002;