% Controller order reduction for the Distillation Column system
%
omega = logspace(-2,6,100);
[Kred,redinfo] = reduce(K,12);
%
% frequency responses of the controllers
figure(1)
sigma(K,'r-',Kred,'c--'), grid
tmp1 = 'Singular values of the controller';
tmp2 = ' transfer matrices';
title([tmp1 tmp2])
xlabel('Frequency (rad/min)')
legend('Full-order (n = 28) controller', ...
       'Reduced-order (n = 12) controller',3)
%
% model reduction error (in nu-gap metric)   
[gap,nugap] = gapmetric(K,Kred)
K = Kred;