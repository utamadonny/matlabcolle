% Sensor noise
%
nuWn = [10 1];
dnWn = [0.1 1];
gainWn = 0.00002;
wn = tf(gainWn*nuWn,dnWn);
Wn = blkdiag(wn,wn,wn);