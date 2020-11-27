% Open-loop connection for simulation of the triple inverted
% pendulum system
%
mod_pend
S = ss(-eye(3),zeros(3),zeros(3),Cp);
act_pend
wsn_pend
systemnames = ' Act1 Act2 G S Wn ';
inputvar = '[ ref{3}; dist{3}; noise{3}; control{2} ]';
outputvar = '[ G(1:3); control; Wn; -G(4:6) - Wn; S ]';
input_to_Act1 = '[ control(1) ]';
input_to_Act2 = '[ control(2) ]';
input_to_G = '[ dist; Act1; Act2 ]';
input_to_S = '[ ref ]';
input_to_Wn = '[ noise ]';
pend_sm = sysic;