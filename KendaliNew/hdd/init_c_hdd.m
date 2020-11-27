% Parameters for the nonlinear simulation of the Hard Disk Drive Servo System
% 
J = 6.3857*10^(-6);     % kg.m^2     Inertial moment
R = 5.08*10^(-2);       % m          Arm length
Kpa = 10;               % V/V        Amplifier gain
Kt = 9.183*10^(-2);     % N.m/A      VCM torque constant
Kb = 9.183*10^(-2);     % V.s/rad    Back EMF constant
tpm = 10^6;             % tracks/m   Tracks per meter
Ky = 1.2;               % V/track    Position measurement gain
Rcoil = 8;              % Om         Coil resistance
Rs = 0.2;               % Om         Sense resistance
Lcoil = 0.001;          % H          Coil inductance
Rc = Rcoil + Rs;        % Om
emax = 12;              % V          Saturation limit
%
tau = Lcoil/Rc;
%
w1 = 2*pi*50;    z1 = 0.3;    b1 =  0.006;    b2 =  0;         % f1 =   50 Hz
w2 = 2*pi*2200;  z2 = 0.024;  b3 =  0.013;    b4 = -0.0018;    % f2 = 2200 Hz  
w3 = 2*pi*6400;  z3 = 0.129;  b5 =  0.723;    b6 = -0.0015;    % f3 = 6400 Hz 
w4 = 2*pi*8800;  z4 = 0.173;  b7 =  0.235;    b8 = -0.0263;    % f4 = 8800 Hz  
%
% Noise shaping filters
kf = 0.0006; Tf1 = 0.1; Tf2 = 0.001;
%
% Controller
[ak,bk,ck,dk] = ssdata(K);