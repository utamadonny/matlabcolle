% 3D simulation of the motion of elastic manipulator
% with PID controller
%
% Manipulator parameters
%ml = 0.15;    % kg        minimum load mass
ml = 0.25;     % kg        nominal load mass
%ml = 0.35;    % kg        maximum load mass
n = 2;         %           number of modes
L = 1.0;       % m         length of the link
s1 = 0.05;     % m         length of the link cross-section 
s2 = 0.004;    % m         width of the link cross-section
E = 6.9e+10;   % N/m^2     Young's modulus of elasticity of the link material
ro = 2700;     % kg/m^3    density of the link material
R = 0.04;      % m         distance between the hub center and the link root 
Ja = 0.1;      % kg.m^2    link moment of inertia
g = 9.81;      % m/s^2     acceleration of gravity
Ttc = 0.003;   % s         actuator time constant
d1 = 0.03;     % kg.m^2/s  damping factor
d2 = 0.1;      % kg.m^2/s  damping factor
dr = 0.15;     % kg.m^2/s  damping factor
%
d = [d1; d2]; 
%
% PID controller coefficients
kp = 358; ki = 0; kd = 28.5;
%
n1 = n + 1;
mo = s1*s2*ro; 
mb = mo*L;
xbeg = 0; stx= 0.1;
%
betal = betal_flm(n,mb,ml,xbeg,stx);
[A,B] = nophi_flm(n,L,betal,mo,ml);
%
beta = betal/L;
J = s1*(s2^3)/12;
omega = (beta.*beta)*sqrt(E*J/mo);
ce = omega.*omega;
%
for j = 1:n
   phil(j) = phi_flm(L,beta(j),A(j),B(j));
end
%
Mlin = zeros(n1,n1);
Mlin(1,1) = Ja + mo*((L + R)^3 - R^3)/3 + ml*(L + R)^2;
%
for j = 1:n
   Ixphi(j) = quadl(@xphiv_flm,0,L,[],[],R,beta,A,B,j);
   i = j + 1;
   Mlin(i,1) = mo*Ixphi(j) + ml*(L + R)*phil(j);
   Mlin(1,i) = Mlin(i,1);
end
%
for i = 2:n1
   Mlin(i,i) = 1;
end
%
De = diag([dr; d]);
Ce = diag([0; ce]);
Ne = zeros(n1,1); 
Ne(1) = 1;
%
pGp(1) = g*(mb*L/2 + ml*L);
for j = 1:n
   Iphi(j) = quadl(@phiv_flm,0,L,[],[],beta,A,B,j);
   pGp(j+1) = g*(mo*Iphi(j) + ml*phil(j));
end
pG = pGp';
%
tspan = [0 3];
x0 = [0 0 0 0 0 0 0 0]';
%
% Integration of the state equations
options = odeset('RelTol',10^(-3),'AbsTol',10^(-6));
[t,x] = ode45(@pdrv_flm,tspan,x0,options,n,Mlin,De,Ce,pG,Ne,Ttc,kp,ki,kd);
%
brxb = 31;
brt = length(t);
nskip = 10;
%
xb = 0:L/(brxb-1):L;
for ix = 1:brxb
   for j = 1:n
      phix(j) = phi_flm(xb(ix),beta(j),A(j),B(j));
   end
   ic = 0;
   for it = 1:nskip:brt
      ic = ic + 1;     
      w(ix,ic) = 0;
      tc(ic) = t(it);
      for j = 1:n
         w(ix,ic) = w(ix,ic) + phix(j)*x(it,(j+1));
      end
   end
end
%
figure(1)
brtc = length(tc);
for ic = 1:brtc
   z = zeros(brxb,brtc);
   z(1:brxb,1:ic) = w(1:brxb,1:ic);
   mesh(xb,tc,z')
   axis([0 1 0 3 -0.025 0.025])
   colormap([0.1 0 1])
   view(75,30)
   grid on, drawnow, shg, pause(0.04)
   xlabel('x (m)'), ylabel('Time (secs)'), zlabel('w (m)')
   title('Manipulator elastic deflation')
end
%
clear t, clear tc, clear w, clear z