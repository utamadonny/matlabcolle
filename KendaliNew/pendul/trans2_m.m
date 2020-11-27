% Approximation of the second actuator transfer function by using
% input multiplicative uncertainty
%
omega = logspace(1,4,100);
%
% first-order fit
Wm2 = tf([0.3803 60.8973],[1.0000 599.5829]);
Wm2_frd = frd(Wm2,omega);
K2 = ureal('K2',0.335,'Percentage',10);
T2 = ureal('T2',0.002,'Percentage',20);
G2 = tf([K2],[T2 1]);
G2nom_frd = frd(G2.Nominal,omega);
nsamp = 10;
G2_grid = gridureal(G2,'K2',nsamp,'T2',nsamp);
G2_frd = frd(G2_grid,omega);
reldiff = (G2_frd - G2nom_frd)/G2nom_frd;
bodemag(Wm2_frd,'r-',reldiff,'c--',omega)
grid
title('Approximation of the second actuator transfer function')
legend('|Wm2(j\omega)|','|(G2(j\omega)-G2nom(j\omega))/G2nom(j\omega)|',4)