function [A,B] = nophi_flm(n,L,betal,mo,mL)
%
% Normalizes a given number of shape functions
%
for i = 1:n
   beta = betal(i)/L;
   bb = (cosh(betal(i)) + cos(betal(i)))/(sinh(betal(i)) + sin(betal(i)));
   I = quadl('phid2v_flm',0,L,[],[],beta,bb);
   phidl = cosh(betal(i)) - cos(betal(i)) - bb*(sinh(betal(i)) - sin(betal(i)));
   r = mo*I + mL*phidl*phidl;
   gama = sqrt(1/r);
   At(i) = gama;
   Bt(i) = -gama*bb;
end
A = At';
B = Bt';