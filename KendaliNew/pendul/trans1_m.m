% Approximation of the first actuator transfer function by using
% input multiplicative uncertainty
%
omega = logspace(1,4,100);
%
% first-order fit
Wm1 = tf([0.3877 25.6011],[1.0000 246.3606]);
Wm1_frd = frd(Wm1,omega);
K1 = ureal('K1',1.08,'Percentage',10);
T1 = ureal('T1',0.005,'Percentage',20);
G1 = tf([K1],[T1 1]);
G1nom_frd = frd(G1.Nominal,omega);
nsamp = 10;
G1_grid = gridureal(G1,'K1',nsamp,'T1',nsamp);
G1_frd = frd(G1_grid,omega);
reldiff = (G1_frd - G1nom_frd)/G1nom_frd;
bodemag(Wm1_frd,'r-',reldiff,'c--',omega)
grid
title('Approximation of the first actuator transfer function')
legend('|Wm1(j\omega)|','|(G1(j\omega)-G1nom(j\omega))/G1nom(j\omega)|',4)