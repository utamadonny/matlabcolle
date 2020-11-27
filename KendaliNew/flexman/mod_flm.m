% Uncertain model of a flexible-link manipulator
%
m_L = ureal('m_L',0.25,'percentage',40);  % kg        load mass
d_1 = ureal('d_1',0.4,'percentage',40);   % kg.m^2/s  damping factor
d_2 = ureal('d_2',10,'percentage',40);    % kg.m^2/s  damping factor
d_r = ureal('d_r',0.15,'percentage',20);  % kg.m^2/s  damping factor
%
L = 1;    % m         length of the link
R = 0.04; % m         distance between the hub center and the link root 
%
par_flm   %           model parameters
a0 = a0_1 + a0_2*m_L;
a1 = a1_1 + a1_2*m_L;
a2 = a2_1 + a2_2*m_L;
b1 = 1/(b1_1 + b1_2*m_L);
b2 = 1/(b2_1 + b2_2*m_L);
c1 = 1/(c1_1 + c1_2*m_L);
c2 = 1/(c2_1 + c2_2*m_L);
%
tol = 1e-8;
%
M = [a0 a1 a2 
     a1 1  0 
     a2 0  1 ];
Minv = inv(M);
N1 = diag([d_r d_1 d_2]);
N2 = diag([tol c1 c2]);
T = [1 0 0]';
intz = tf(1,[1 0]);
Int1 = blkdiag(intz, intz, intz);
Int2 = blkdiag(intz, intz, intz);
P1 = [1 b1 b2; 0 (L+R)*b1 (L+R)*b2];
P2 = [1 b1 b2];
%
systemnames = ' Minv N1 N2 T Int1 Int2 P1 P2 ';
inputvar = '[ tau ]';
outputvar = '[ P1(1); Int2(1); P2; P1(2) ]';
input_to_Minv = '[ T - N1 - N2 ]';
input_to_N1 = '[ Int1 ]';
input_to_N2 = '[ Int2 ]';
input_to_T = '[ tau ]';
input_to_Int1 = '[ Minv ]';
input_to_Int2 = '[ Int1 ]';
input_to_P1 = '[ Int2 ]';
input_to_P2 = '[ Minv ]';
G = sysic;
outputs = {'alpha' 'theta' 'ddalpha' 'wL'};
G.OutputName = outputs;