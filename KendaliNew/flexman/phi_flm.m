function y = phi_flm(x,betaj,Aj,Bj)
%
% Calculates the value of a shape function 
% for a given value of the argument
%
betax = betaj*x;
y = Aj*(cosh(betax) - cos(betax)) + Bj*(sinh(betax) - sin(betax));