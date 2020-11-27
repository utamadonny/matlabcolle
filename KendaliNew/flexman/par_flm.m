% Computes the coefficients of the uncertain flexible-link manipulator 
% model
%
% Manipulator parameters
n = 2;         %          number of modes
L = 1;         % m        length of the link
R = 0.04;      % m        distance between the hub center and the link root 
s1 = 0.05;     % m        length of the rectangular cross-section
s2 = 0.004;    % m        width of the rectangular cross-section
E = 6.9e+10;   % N/m^2    Young's modulus of elasticity of the link material
ro = 2700;     % kg/m^3   density of the link material
Ja = 0.1;      % kg.m^2   link moment of inertia
%
xbeg = 0; stx = 0.1;
%
delta_m = (-1:0.04:1)';
i_nv = 26; i_max = 51;
mL_min = 0.15; st_mL = 0.004;
%
mL_nom = 0.25; % kg       nominal payload mass
delta_mL = 0.1;%          payload mass relative uncertainty
%
for im = 1:i_max
    mLp(im) = mL_min + st_mL*(im - 1);
    mL = mLp(im);
    %
    n1 = n + 1;
    mo = s1*s2*ro;
    mb = mo*L;
    %
    betal = betal_flm(n,mb,mL,xbeg,stx);
    [A,B] = nophi_flm(n,L,betal,mo,mL);
    %
    beta = betal/L;
    J = s1*(s2^3)/12;
    omega = (beta.*beta)*sqrt(E*J/mo);
    cc = omega.*omega;
    %
    for j = 1:n
       phil(j) = phi_flm(L,beta(j),A(j),B(j));
    end
    %
    Mlin = zeros(n1,n1);
    Mlin(1,1) = Ja + mo*((L + R)^3 - R^3)/3 + mL*(L + R)^2;
    for j = 1:n
       Ixphi(j) = quadl('xphiv_flm',0,L,[],[],R,beta,A,B,j);
       i = j + 1;
       Mlin(i,1) = mo*Ixphi(j) + mL*(L + R)*phil(j);
       Mlin(1,i) = Mlin(i,1);
    end
    %
    a1p(im) = Mlin(1,2);
    a2p(im) = Mlin(1,3);
    b1p(im) = phil(1)/(L + R);
    b2p(im) = phil(2)/(L + R);
    c1p(im) = cc(1);
    c2p(im) = cc(2);
    %
end
%
mL = mLp';
a1 = a1p';
a2 = a2p';
b1 = b1p';
b2 = b2p';
c1 = c1p';
c2 = c2p';
%
onesk = ones(i_max,1);
onesx = ones(i_max-1,1);
ip1 = i_nv - 1;
ip2 = i_nv + 1;
x = [delta_m(1:ip1); delta_m(ip2:i_max)];
a1x = [a1(1:ip1); a1(ip2:i_max)];
a2x = [a2(1:ip1); a2(ip2:i_max)];
b1x = [b1(1:ip1); b1(ip2:i_max)];
b2x = [b2(1:ip1); b2(ip2:i_max)];
c1x = [c1(1:ip1); c1(ip2:i_max)];
c2x = [c2(1:ip1); c2(ip2:i_max)];
%
% a0_1, a0_2
a0_1 = Ja + mo*((L + R)^3 - R^3)/3;
a0_2 = (L + R)^2;
%
% a1_1, a1_2
a1_nom = a1(i_nv);
y_a1 = (a1x/a1(i_nv) - onesx)./x;
p_a1 = polyfit(x,y_a1,0);
a1_2 = a1_nom*p_a1/delta_mL;
a1_1 = a1_nom - a1_2*mL_nom;
%
% a2_1, a2_2
a2_nom = a2(i_nv);
y_a2 = (a2x/a2(i_nv) - onesx)./x;
p_a2 = polyfit(x,y_a2,0);
a2_2 = a2_nom*p_a2/delta_mL;
a2_1 = a2_nom - a2_2*mL_nom;
%
% b1_1, b1_2
b1_nom = 1/b1(i_nv);
y_b1 = (b1(i_nv)*(onesx./b1x) - onesx)./x;
p_b1 = polyfit(x,y_b1,0);
b1_2 = b1_nom*p_b1/delta_mL;
b1_1 = b1_nom - b1_2*mL_nom;
%
% b2_1, b2_2
b2_nom = 1/b2(i_nv);
y_b2 = (b2(i_nv)*(onesx./b2x) - onesx)./x;
p_b2 = polyfit(x,y_b2,0);
b2_2 = b2_nom*p_b2/delta_mL;
b2_1 = b2_nom - b2_2*mL_nom;
%
% c1_1, c1_2
c1_nom = 1/c1(i_nv);
y_c1 = (c1(i_nv)*(onesx./c1x) - onesx)./x;
p_c1 = polyfit(x,y_c1,0);
c1_2 = c1_nom*p_c1/delta_mL;
c1_1 = c1_nom - c1_2*mL_nom;
%
% c2_1, c2_2
c2_nom = 1/c2(i_nv);
y_c2 = (c2(i_nv)*(onesx./c2x) - onesx)./x;
p_c2 = polyfit(x,y_c2,0);
c2_2 = c2_nom*p_c2/delta_mL;
c2_1 = c2_nom - c2_2*mL_nom;