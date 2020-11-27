function [sys,x0,str,ts] = s_pend(t,x,w,flag) 
%
% S-function for nonlinear modeling of triple inverted pendulum.
%
% Inputs:  t    - time in secs.
%          x    - pendulum state.
%          w    - input signals:
%                 w(1:3) contains the disturbance vector d
%                 w(4:5) containts the control vector u
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
% Pendulum parameters
l1 = 0.5; l2 = 0.4; h1 = 0.35; h2 = 0.181; h3 = 0.245;
m1 = 3.25; m2 = 1.9; m3 = 2.23;
i1 = 0.654; i2 = 0.117; i3 = 0.535;
c1 = 0.0654; c2 = 0.0232; c3 = 0.0088;
alf1 = 1.146; alf2 = 1.146; alf3 = 0.9964;
cd1 = 0.00219; cd2 = 0.000717;
id1 = 0.000024; id2 = 0.0000049;
cp1p = 0.; cp2p = 0.;
ip1p = 0.00795; ip2p = 0.00397;
k1 = 30.72; k2 = 27.0;
g = 9.81;
mm1 = m1*h1 + m2*l1 + m3*l1;
mm2 = m2*h2 + m3*l2;
mm3 = m3*h3;
j1 = i1 + m1*h1^2 + m2*l1^2 + m3*l1^2;
j2 = i2 + m2*h2^2 + m3*l2^2;
j3 = i3 + m3*h3^2;
cp1 = cp1p + cd1*k1^2; cp2 = cp2p + cd2*k2^2;
ip1 = ip1p + id1*k1^2; ip2 = ip2p + id2*k2^2;
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
    sizes.NumOutputs     = 3;
    sizes.NumInputs      = 5;
    sizes.DirFeedthrough = 0;
    sizes.NumSampleTimes = 1;
%   Load the sys vector with the sizes information.    
    sys = simsizes(sizes);
% 
%   Initialize the state vector
%
    x0 = inc_pend;
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
    d = w(1:3);
    t_m = w(4:5);
%
    M = [j1+ip1                      l1*mm2*cos(x(1)-x(2))-ip1    l1*mm3*cos(x(1)-x(3))
         l1*mm2*cos(x(1)-x(2))-ip1   j2+ip1+ip2                   l2*mm3*cos(x(2)-x(3))-ip2
         l1*mm3*cos(x(1)-x(3))       l2*mm3*cos(x(2)-x(3))-ip2    j3+ip2                   ];
%  
    N = [c1+c2+cp1   -c2-cp1          0
         -c2-cp1     c2+c3+cp1+cp2   -c3-cp2 
            0        -c3-cp2          c3+cp2];
%  
    GG = [ k1  0
          -k1  k2
           0  -k2]; 
%
    T = [1 -1  0
         0  1 -1
         0  0  1];
%
    q = [l1*mm2*sin(x(1)-x(2))*x(5)^2 + l1*mm3*sin(x(1)-x(3))*x(6)^2 - mm1*g*sin(x(1))
         l1*mm2*sin(x(1)-x(2))*x(4)^2 + l2*mm3*sin(x(2)-x(3))*x(6)^2 - mm2*g*sin(x(2))
         l1*mm3*sin(x(1)-x(3))*(x(4)^2-2*x(4)*x(6)) + ...
                          l2*mm3*sin(x(2)-x(3))*(x(5)^2-2*x(5)*x(6)) - mm3*g*sin(x(3))];
% 
    ddtheta = M\(-N*x(4:6) - q - GG*t_m + T*d);
%
%   x(1) = Theta(1)
%   x(2) = Theta(2)
%   x(3) = Theta(3)
%   x(4) = dTheta(1)/dt
%   x(5) = dTheta(2)/dt
%   x(6) = dTheta(3)/dt
%
    dxdt(1) = x(4);
    dxdt(2) = x(5);
    dxdt(3) = x(6);
    dxdt(4) = ddtheta(1);
    dxdt(5) = ddtheta(2);
    dxdt(6) = ddtheta(3);
    sys = [dxdt(1) dxdt(2) dxdt(3) dxdt(4) dxdt(5) dxdt(6)]';
    
case 3
%
%   Calculate outputs
%
    sys = [x(1) x(2) x(3)]';    
    
case { 2, 4, 9 } 
%
% Unused flags
%
  sys = [];
otherwise
  error(['Unhandled flag = ',num2str(flag)]); % Error handling
end
% End of s_pend