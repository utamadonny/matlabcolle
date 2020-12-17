% Generate the open-loop connection for the
% Disk Drive System
%
mod_hdd
%
% frequency response of G
olp_ic = G(1,2);
w = logspace(2,5,500);
figure(1)
olp_ic30 = usample(olp_ic,30);
bode(olp_ic.NominalValue,'r-',olp_ic30,'b--',w), grid
title('Bode plot of the uncertain plant')
legend('Nominal system','Random samples')
%
% construct performance weighting function
wts_hdd
w = logspace(-1,5,400);
figure(2)
bodemag(1/Wp,w), grid
title('Inverse Performance Weighting Function')
%
w = logspace(-1,6,100);
figure(3)
bodemag(Wu,'r',w), grid
title('Control Weighting Function')
%
w = logspace(0,4,100);
figure(4)
bodemag(Wn,'r',w), grid
title('Noise shaping filter frequency response')
%
% open-loop connection with the weighting function
systemnames = ' G Wm Wn Wp Wu ';
inputvar = '[ ref; dist; noise; control ]';
outputvar = '[ Wp; Wu; ref-G(1)-Wn ]';
input_to_G = '[ dist; control ]';
input_to_Wm = '[ ref ]';
input_to_Wn = '[ noise ]';
input_to_Wp = '[ G(1) - Wm ]';
input_to_Wu = '[ control ]';
sys_ic = sysic;
clear Wm, clear Wn, clear Wp, clear Wu
clear olp_ic, clear olp_ic30, clear w
clear inputvar, clear outputvar, clear systemnames
clear input_to_G, clear input_to_Wm, clear input_to_Wn
clear input_to_Wp, clear input_to_Wu