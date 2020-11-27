function dxdt = pdrv_flm(t,x,n,Mlin,De,Ce,pG,Ne,Ttc,kp,ki,kd)
%
% Calculates manipulator and controller state derivatives
% in case of using PID controller
%
% --------------------------------------------------------------
%   x(1) = Theta
%   x(2) = Eta_1
%   x(3) = Eta_2
%   x(4) = dTheta/dt
%   x(5) = dEta_1/dt
%   x(6) = dEta_2/dt
%   x(7) = tau  
%   x(8) = Ki*integral(ref - Theta) 
% --------------------------------------------------------------
%
n1 = n + 1;
%
SM = 0;
for i = 2:n1
    SM = SM + x(i)*x(i);
end
%
M = Mlin; M(1,1) = Mlin(1,1) + SM;
%
G = zeros(n1,1);
sx1 = sin(x(1));
SG = 0;
for i = 2:n1
   G(i) = pG(i)*sx1;
   SG = SG + pG(i)*x(i);
end
%
G(1) = pG(1)*sx1 + SG*cos(x(1));
%
H = zeros(n1,1);
for i = 2:n1
   H(1) = H(1) + 2*x(n+1)*x(i)*x(n+i);
   H(i) = -x(n+1)*x(n+1)*x(i);
end
%
Minv = inv(M);
Am = [zeros(n1) eye(n1); -Minv*Ce -Minv*De];
% --------------------------------------------------------------
% vertical movement
%Fm = [zeros(n,1); -Minv*(G+H)];
% horizontal movement
Fm = [zeros(n1,1); -Minv*(H)];
% --------------------------------------------------------------
Um = [zeros(n1,1); Minv*Ne];
%
% Reference signal
tm = 1;
if t < tm
  ref = (pi/12)*t - sin(2*pi*t)/24;
else
  ref = (pi/12)*tm - sin(2*pi*tm)/24;
end
%
% control = Kp*(ref - Theta) + Ki*integral(ref - Theta) - Kd*dTheta/dt
n2 = 2*n1;
u = kp*(ref - x(1)) + ki*x(n2+2) - kd*x(n1+1); % PID controller output
tau = x(n2+1);
%
dxmdt = Am*x(1:n2) + Fm + Um*tau;   % manipulator state derivative
dtaudt = (u - tau)/Ttc;             % actuator state derivative
dintdt = ki*(ref - x(1));           % integral component derivative
dxdt = [dxmdt; dtaudt; dintdt];     % extended system state derivative