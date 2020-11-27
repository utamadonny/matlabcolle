% Controller order reduction
%
[Kred,redinfo] = reduce(K,12);
%
sigma(K,'r',Kred,'b--'),grid
title('Singular value plots of full-order and reduced-order controllers')
legend(' Full-order controller',' Reduced-order controller',3)
%
% model reduction error
[gap,nugap] = gapmetric(K,Kred)
%
K = Kred;
[Ak,Bk,Ck,Dk] = ssdata(K);