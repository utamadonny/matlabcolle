% Generates the open-loop connection for the Two-Wheeled Robot Control
% System simulation
%
% plant model
mod_robot
%
s = tf('s');
Intg1 = 1/(s+10^(-5)); 
%
systemnames    = ' G_unc Intg1 Wn ';
inputvar       = '[ ref{4}; noise{2}; control{2} ]';
outputvar      = '[ G_unc; control; ref; -G_unc(1:2); -G_unc(3:4)-Wn; Intg1 ]';
input_to_G_unc = '[ control ]';
input_to_Wn    = '[ noise ]';
input_to_Intg1 = '[ ref(1)-G_unc(1) ]';
sim_ic         = sysic;