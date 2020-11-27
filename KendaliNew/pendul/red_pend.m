% Controller order reduction
%
[Kred,info] = reduce(K_mu,25);
%
% frequency responses of the controllers
figure(1)
sigma(K,'r-',Kred,'c--',{10^(-4) 10^4})
grid
tmp1 = 'Maximum Singular Values of the';
tmp2 = ' Controller Transfer Matrices';
title([tmp1 tmp2])
legend('Full-order (n = 80) controller', ...
       'Reduced-order (n = 25) controller',2)