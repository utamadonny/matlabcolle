function [sys,x0,str,ts] = s_flm(t,x,v,flag) 
%
% S-function for nonlinear modeling of
% the flexible manipulator
% 
% Manipulator parameters
%
mL = 0.25;
L = 1;
R = 0.04;
s_1 = 0.05; s_2 = 0.004;
E = 6.9e+10;
ro = 2700;
Ja = 0.1;
dr = 0.15 - 0.2*0.15;
n = 2;
d = [0.4 - 0.4*0.4; 10 - 0.4*10];
xbeg = 0; stx = 0.1; brxb = 31;
%
% Inputs:  t    - time in secs
%          x    - manipulator state
%          v    - control variable
%          flag - an integer value that indicates the task
%                 to be performed by the S-function:
%                 flag = 0 - initialize the state vector
%                 flag = 1 - calculate the state derivatives
%                 flag = 3 - calculate outputs 
%
% Outputs: sys  - a generic return argument whose values depend
%                 on the flag value.
%          x0   - the initial state values. x0 is ignored, except
%                 when flag = 0.
%          str  - argument reserved for future use.
%          ts   - a two column matrix containing the sample times
%                 and offsets of the blocks. For continuous time
%                 systems ts = [0 0].
%
%   x(1) = theta
%   x(2) = eta_1
%   x(3) = eta_2
%   x(4) = dtheta/dt
%   x(5) = deta_1/dt
%   x(6) = deta_2/dt
%   v    = tau
%
% Determine the model parameters
%
n1 = n + 1;
mo = s_1*s_2*ro;
mb = mo*L;
%
betal = betal_flm(n,mb,mL,xbeg,stx);
[A,B] = nophi_flm(n,L,betal,mo,mL);
%
beta = betal/L;
J = s_1*(s_2^3)/12;
omega = (beta.*beta)*sqrt(E*J/mo);
ce = omega.*omega;
%
for j = 1:n
   phiL(j) = phi_flm(L,beta(j),A(j),B(j));
end
%
Mlin = zeros(n1,n1);
Mlin(1,1) = Ja + mo*((L + R)^3 - R^3)/3 + mL*(L + R)^2;
for j = 1:n
   Ixphi(j) = quadl('xphiv_flm',0,L,[],[],R,beta,A,B,j);
   i = j + 1;
   Mlin(i,1) = mo*Ixphi(j) + mL*(L + R)*phiL(j);
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
% Dispatch the flag
%
switch flag,
    
case 0
%
%   Initialization
%
%   Call function simsizes to create the sizes structure.    
    sizes = simsizes;
%   Load the sizes structure with the initialization information.    
    sizes.NumContStates  = 6;
    sizes.NumDiscStates  = 0;
    sizes.NumOutputs     = 6;
    sizes.NumInputs      = 1;
    sizes.DirFeedthrough = 1;
    sizes.NumSampleTimes = 1;
%   Load the sys vector with the sizes information.    
    sys = simsizes(sizes);
% 
%   Initialize the state vector
%
    x0 = [0 0 0 0 0 0]';
%
%   str is an empty matrix.
%
    str = [];
%
    ts = [0 0];
    
case 1
%
%   Calculate derivatives
%
    dxdt = der_flm(t,x,v,n,Mlin,De,Ce,Ne);
%
    sys = dxdt;
    
case 3
%
%   Calculate outputs
%
    dxdt = der_flm(t,x,v,n,Mlin,De,Ce,Ne);
%
    wL = 0;
    dwL = 0;
    ddwL = 0;
    for j = 1:n
        wL = wL + phiL(j)*x(j+1);
        dwL = dwL + phiL(j)*x(n1+j+1);
        ddwL = ddwL + phiL(j)*dxdt(n1+j+1);
    end
    alpha = x(1) + atan(wL/(L + R));
    ddalpha = dxdt(4) - 2*(dwL/(L + R))*(wL/(L + R))/(1 + (wL/(L + R))^2)^2 + ...
                 (ddwL/(L + R))/(1 + (wL/(L + R))^2); 
%
    sys = [ alpha x(1) wL x(2) x(3) ddalpha ]';
    
%  outputs:  1) alpha;  2) theta;  3) wL;  
%            4) eta_1;  5) eta_2;  6) ddalpha/ddt  
    
case { 2, 4, 9 } 
%
% Unused flags
%
  sys = [];
otherwise
  error(['Unhandled flag = ',num2str(flag)]); % Error handling
end
%
% End of s_flm
%
% --------------------------------------------------------------
%
function dxdt = der_flm(t,x,v,n,Mlin,De,Ce,Ne)
%
% Calculates state derivatives
%
n1 = n + 1;
%
SM = 0;
for i = 2:n1
   SM = SM + x(i)*x(i);
end
M = Mlin;
M(1,1) = Mlin(1,1) + SM;
%
H = zeros(n1,1);
for i = 2:n1
   H(1) = H(1) + 2*x(n1+1)*x(i)*x(n1+i);
   H(i) = -x(n1+1)*x(n1+1)*x(i);
end
Minv = inv(M);
Am = [zeros(n1) eye(n1); -Minv*Ce -Minv*De];
Fm = [zeros(n1,1); -Minv*H];
Um = [zeros(n1,1); Minv*Ne];
dxdt = Am*x + Fm + Um*v;
%
% End of der_flm