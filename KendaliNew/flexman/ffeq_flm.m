function y = ffeq_flm(x,mldmb)
%
% Auxiliary function used to determine 
% frequency equation roots
%
cx = cos(x);
sx = sin(x);
chx = cosh(x);
shx = sinh(x);
y = 1 + chx*cx + mldmb*x*(shx*cx - chx*sx);