% Generates the open-loop connection for the
% system simulation
%
% Controller inputs:  1)  ref
%                     2)  theta + noise1
%                     3)  d2alpha/dt2 + noise2
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
% open-loop connection
systemnames = ' G Wa Wn1 Wn2 ';
inputvar = '[ ref; dist; noise{2}; control ]';
temp = '[ G(1); G(2); G(3); G(4); ';
outputvar = [temp ' control;  ref; G(2) + Wn1; G(3) + Wn2 ]'];
input_to_G = '[ Wa - dist ]';
input_to_Wa = '[ control ]';
input_to_Wn1 = '[ noise(1) ]';
input_to_Wn2 = '[ noise(2) ]';
sim_ic = sysic;
outputs = {'alpha' 'theta' 'ddalpha' 'wL' 'control' 'ref' 'y_s(1)' 'y_s(2)'};
sim_ic.OutputName = outputs;
