function y = phid2v_flm(x,beta,bb)
%
% Auxiliary function used to normalize the shape functions
%
brt = length(x);
for i = 1:brt
   betax = beta*x(i);
   y(i) = (cosh(betax) - cos(betax) - bb*(sinh(betax) - sin(betax)))^2;
end