% Controller order reduction
%
w = logspace(-1,5,400);
[Kred,redinfo] = reduce(K,12);
%
figure(1)
bode(K,'r-',Kred,'b--'), grid
title('Controller Bode plots')
legend('Full order (n = 34) controller', ...
       'Reduced-order (n = 12) controller',2)
%
% model reduction error (in nu-gap metric)   
[gap,nugap] = gapmetric(K,Kred) 
K = Kred;