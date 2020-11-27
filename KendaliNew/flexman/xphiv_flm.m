function y = xphiv_flm(x,R,beta,A,B,j)
%
% Auxiliary function used to determine nonlinear
% manipulator model coefficients
%
brt = length(x);
for i = 1:brt
   betax = beta(j)*x(i);
   y(i) = (x(i) + R)*(A(j)*(cosh(betax) - cos(betax)) + ...
          B(j)*(sinh(betax) - sin(betax)));
end