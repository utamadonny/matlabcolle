% Generate the open-loop connection for
% the Distillation Column simulation in case
% of maximum input delays
%
mod_col
%
k1 = 1; k2 = 1;
Theta1 = 1; Theta2 = 1;
%
[num1,den1] = pade(Theta1,6);
del1 = tf(num1,den1);
[num2,den2] = pade(Theta2,6);
del2 = tf(num2,den2);
Del1 = k1*del1;
Del2 = k2*del2;
Del = blkdiag(Del1,Del2);
Gd = G*Del;
%
systemnames = ' Gd Wn ';
inputvar = '[ ref{2}; noise{2}; control{2} ]';
outputvar = '[ Gd; control; ref-Gd-Wn ]';
input_to_Gd = '[ control ]';
input_to_Wn = '[ noise ]';
sim_ic_1dof = sysic;
%
systemnames = ' Gd Wn ';
inputvar = '[ ref{2}; noise{2}; control{2} ]';
outputvar = '[ Gd; control; -Gd-Wn; ref ]';
input_to_Gd = '[ control ]';
input_to_Wn = '[ noise ]';
sim_ic_2dof = sysic;