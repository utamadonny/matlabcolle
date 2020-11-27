% Uncertain model of the triple inverted pendulum
%
% Pendulum parameters
l1 = 0.5;       % m      length of the first arm
l2 = 0.4;       % m      length of the second arm
h1 = 0.35;      % m      the distance form the bottom to the center of gravity
                %        of the 1st arm
h2 = 0.181;     % m      the distance form the bottom to the center of gravity
                %        of the 2nd arm
h3 = 0.245;     % m      the distance form the bottom to the center of gravity
                %        of the 3rd arm
m1 = 3.25;      % kg     mass of the first arm
m2 = 1.9;       % kg     mass of the second arm
m3 = 2.23;      % kg     mass of the third arm
alf1 = 1.146;   % V/rad  gain of the 1st potentiometer
alf2 = 1.146;   % V/rad  gain of the 2nd potentiometer 
alf3 = 0.9964;  % V/rad  gain of the 3rd potentiometer
id1 = 0.000024; % kg m^2 moment of inertia of the 1st motor 
id2 = 0.0000049;% kg m^2 moment of inertia of the 2nd motor 
cp1p = 0.;      % N m s  viscous friction coefficient of the belt-pulley
                %        system of the 1st hinge 
cp2p = 0.;      % N m s  viscous friction coefficient of the belt-pulley
                %        system of the 1st hinge 
ip1p = 0.00795; % kg m^2 moment of inertia of the belt-pulley system
                %        of the 1st hinge
ip2p = 0.00397; % kg m^2 moment of inertia of the belt-pulley system
                %        of the 2nd hinge
k1 = 30.72;     %        ratio of theet of belt-pulley system of the 1st hinge
k2 = 27.0;      %        ratio of theet of belt-pulley system of the 2nd hinge
g = 9.81;       % m s^2  acceleration of gravity
%
mm1 = m1*h1 + m2*l1 + m3*l1; 
mm2 = m2*h2 + m3*l2;
mm3 = m3*h3;
ip1 = ip1p + id1*k1^2; 
ip2 = ip2p + id2*k2^2;
%
% Uncertain parameters
i1 = ureal('i1',0.654,'Percentage',10);      % moment of inertia of the first arm
i2 = ureal('i2',0.117,'Percentage',10);      % moment of inertia of the second arm
i3 = ureal('i3',0.535,'Percentage',10);      % moment of inertia of the third arm
c1 = ureal('c1',0.0654,'Percentage',15);     % viscous friction coefficient 
                                             % of the first hinge                                       
c2 = ureal('c2',0.0232,'Percentage',15);     % viscous friction coefficient 
                                             % of the second hinge
c3 = ureal('c3',0.0088,'Percentage',15);     % viscous friction coefficient  
                                             % of the third hinge
cm1 = ureal('cm1',0.00219,'Percentage',15);  % viscous friction coefficient 
                                             % of the 1st motor
cm2 = ureal('cm2',0.000717,'Percentage',15); % viscous friction coefficient
                                             % of the 2nd motor
%                                             
cp1 = cp1p + cm1*k1^2;
cp2 = cp2p + cm2*k2^2;
%
j1 = i1 + m1*h1^2 + m2*l1^2 + m3*l1^2;
j2 = i2 + m2*h2^2 + m3*l2^2;
j3 = i3 + m3*h3^2;
%
M = [ j1+ip1     l1*mm2-ip1    l1*mm3
      l1*mm2-ip1 j2+ip1+ip2    l2*mm3-ip2
      l1*mm3     l2*mm3-ip2    j3+ip2];
N = [c1+c2+cp1   -c2-cp1          0
     -c2-cp1     c2+c3+cp1+cp2   -c3-cp2 
        0        -c3-cp2          c3+cp2];
P = [-mm1*g     0             0
        0    -mm2*g           0   
        0       0          -mm3*g];
GG = [k1  0
     -k1  k2
      0  -k2];
T = [1 -1  0
     0  1 -1
     0  0  1]; 
Cp = [ alf1    0   0   
      -alf2  alf2  0    
        0   -alf3 alf3 ];
%
% plant connection
Q = inv(M);
int = tf([1],[1 0]);
Int1 = blkdiag(int,int,int);
Int2 = blkdiag(int,int,int);
systemnames = ' GG T Q N P Int1 Int2 Cp ';
inputvar = '[ dist{3}; control{2} ]';
outputvar = '[ Int2; Cp ]';
input_to_GG = '[ control ]';
input_to_T = '[ dist ]';
input_to_Q = '[ T - GG - N - P ]';
input_to_Int1 = '[ Q ]';
input_to_Int2 = '[ Int1 ]';
input_to_N = '[ Int1 ]';
input_to_P = '[ Int2 ]';
input_to_Cp = '[ Int2 ]';
G = sysic;