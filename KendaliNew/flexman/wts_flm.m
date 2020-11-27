% Performance weighting functions for the flexible manipulator
% system with noncollocated controller
%
% Model transfer function
Wm = tf(625, [1 50 625]);
%
% Performance weighting function
Wp = tf([1 25 150], [1 22 0.15]);
%
% Control weighting function
Wu = 10^(-3)*tf(1);
%
% Noise shaping filter Wn1
Wn1 = 0.00001*tf([0.5 1], [0.005 1]);
%
% Noise shaping filter Wn2
Wn2 = 0.001*tf([1 1], [0.01 1]);