% Construct the actuators models for the
% triple inverted pendulum
%
%
% First actuator
gd1 = 1.080; Td1 = 0.005;
G1  = tf([gd1],[Td1 1]);
Wm1 = tf([0.3877 25.6011],[1.0000 246.3606]);
Delta_act1 = ultidyn('Delta_act1',[1 1]);
Act1 = G1*(1 + Wm1*Delta_act1);
%
% Second actuator
gd2 = 0.335; Td2 = 0.002;
G2  = tf([gd2],[Td2 1]);
Wm2 = tf([0.3803 60.8973],[1.0000 599.5829]);
Delta_act2 = ultidyn('Delta_act2',[1 1]);
Act2 = G2*(1 + Wm2*Delta_act2);