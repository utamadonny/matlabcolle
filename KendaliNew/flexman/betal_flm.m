function betal = betal_flm(n,mb,mL,xbeg,stx)
%
% Calculates a given number of ordered by size roots
% of the flexible link frequency equation
%
mldmb = mL/mb;
x = xbeg;
sfx = sign(ffeq_flm(x,mldmb));
sfx0 = sfx;
for jr = 1:n
   while sfx == sfx0
      xc = x;
      x = x + stx;
      sfx = sign(ffeq_flm(x,mldmb));
   end
   vecx = [xc x];
   options = optimset;
   betalt(jr) = fzero('ffeq_flm',vecx,options,mldmb);
   sfx0 = sfx;
end
betal = betalt';