% Generate the open-loop connection for
% the Two Rotor Aerodynmic System
%
mod_tras
%
systemnames = ' G Wn ';
inputvar    = '[ dist{2}; ref{2}; noise{2}; control{2} ]';
outputvar   = '[ G; control; ref(1); ref(2); -G(3)-Wn(1); -G(6)-Wn(2) ]';
input_to_G  = '[ dist; control ]';
input_to_Wn = '[ noise ]';
sim_ic      = sysic;