function dxdt = sdrv_flm(t,x,n,L,R,Mlin,De,Ce,pG,Ne,Ttc,Ac,Bc,Cc,Dc,phil)
%
% Calculates manipulator and controller state derivatives
% in case of using 2DOF controller
%
% --------------------------------------------------------------
%   x(1) = Theta
%   x(2) = Eta_1
%   x(3) = Eta_2
%   x(4) = dTheta/dt
%   x(5) = dEta_1/dt
%   x(6) = dEta_2/dt
%   x(7), ..., x(6+nc) - controller states
%   x(nm+nc+1) = tau   - driving torque     
% --------------------------------------------------------------
%
n1 = n + 1;
%
SM = 0;
for i = 2:n1
    SM = SM + x(i)*x(i);
end
M = Mlin; M(1,1) = Mlin(1,1) + SM;
%
G = zeros(n1,1);
sx1 = sin(x(1));
SG = 0;
for i = 2:n1
   G(i) = pG(i)*sx1;
   SG = SG + pG(i)*x(i);
end
G(1) = pG(1)*sx1 + SG*cos(x(1));
%
H = zeros(n1,1);
for i = 2:n1
   H(1) = H(1) + 2*x(n1+1)*x(i)*x(n1+i);
   H(i) = -x(n1+1)*x(n1+1)*x(i);
end
%
Minv = inv(M);
Am = [zeros(n1) eye(n1); -Minv*Ce -Minv*De];
% --------------------------------------------------------------
% vertical movement
%Fm = [zeros(m,1); -Minv*(G + H)];
% horizontal movement
Fm = [zeros(n1,1); -Minv*H];
% --------------------------------------------------------------
Um = [zeros(n1,1); Minv*Ne];
%
n2 = 2*n1;                   % manipulator order
nc = size(Ac,1);             % controller order
xm = x(1:n2);                % manipulator state
xc = x(n2+1:n2+nc);          % controller state
tau = x(n2+nc+1);            % driving torque
dxmdt = Am*xm + Fm + Um*tau; % manipulator state derivative
%
% Calculate d^2alpha/dt^2
wl = 0;
dwldt = 0;
d2wldt2 = 0;
for j = 1:n
    wl = wl + phil(j)*xm(j+1);
    dwldt = dwldt + phil(j)*xm(n1+j+1);
    d2wldt2 = d2wldt2 + phil(j)*dxmdt(n1+j+1);
end
d2alphadt2 = dxmdt(4) - ...
             2*(dwldt/(L + R))*(wl/(L + R))/(1 + (wl/(L + R))^2)^2 + ...
             (d2wldt2/(L + R))/(1 + (wl/(L + R))^2);
%
% Reference signal
tm = 1;
if t < tm
  ref = (pi/12)*t - sin(2*pi*t)/24;
else
  ref = (pi/12)*tm - sin(2*pi*tm)/24;
end         
%
% Controller inputs: 1) ref
%                    2) Theta
%                    3) d^2alpha/dt^2  
dxcdt = Ac*xc + Bc*[ref; xm(1); d2alphadt2];  % controller state derivative
u = Cc*xc + Dc*[ref; xm(1); d2alphadt2];      % controller output
dtaudt = (u - tau)/Ttc;                       % actuator state derivative
dxdt= [dxmdt; dxcdt; dtaudt];                 % extended system state derivative