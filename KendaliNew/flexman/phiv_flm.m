function y = phiv_flm(x,beta,A,B,j)
%
% Determine the shape function phi_i(x) for several values of x
brxb = length(x);
for i = 1:brxb
   betax = beta(j)*x(i);
   y(i) = A(j)*(cosh(betax) - cos(betax)) + B(j)*(sinh(betax) - sin(betax));
end