function INTf = smpsns(f,a,b,N,varargin)
%integral of f(x) over [a,b] by Simpson’s rule with N segments
if nargin < 4, N = 100;
end
if abs(b - a)<1e-12 | N <= 0, INTf = 0; return; end
if mod(N,2) ~= 0, N = N + 1; end %make N even
h = (b - a)/N; x = a + [0:N]*h; %the boundary nodes for N segments
fx = feval(f,x,varargin{:}); %values of f for all nodes
fx(find(fx == inf)) = realmax;
fx(find(fx == -inf)) = -realmax;
kodd = 2:2:N; keven = 3:2:N - 1; %the set of odd/even indices
INTf = h/3*(fx(1) + fx(N + 1)+4*sum(fx(kodd)) + 2*sum(fx(keven)));%Eq.(5.6.2)
end
