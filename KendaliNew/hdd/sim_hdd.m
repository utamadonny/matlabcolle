% Generate the open-loop connection for the
% system simulation
%
mod_hdd
wts_hdd
systemnames = ' G Wn ';
inputvar = '[ ref; dist; noise; control ]';
outputvar = '[ G(1); control; ref-G(1)-Wn ]';
input_to_G = '[ dist; control ]';
input_to_Wn = '[ noise ]';
sim_ic = sysic;