% Unceratin model of the Hard Disk Drive Servo System
%
R = 5.08*10^(-2);                              % m          Arm length
Kpa = 10;                                      % V/V        Amplifier gain
Kb = 9.183*10^(-2);                            % V.s/rad    Back EMF constant
tpm = 10^6;                                    % tracks/m   Tracks per meter
Rcoil = 8;                                     % Om         Coil resistance
Rs = 0.2;                                      % Om         Sense resistance
Lcoil = 0.001;                                 % H          Coil inductance
Rc = Rcoil + Rs;                               % Om
%
% Voice Coil Admittance
tau = Lcoil/Rc;
gain_vca = 1/Rc;
Gvca = gain_vca*tf(1,[tau 1]);
%
% Uncertain parameters
J  = ureal('J',6.3857*10^(-6),'Percentage',10);% kg.m^2     Arm moment of inertia
Kt = ureal('Kt',9.183*10^(-2),'Percentage',10);% N.m/A      VCM torque constant
Ky = ureal('Ky',1.2,'Percentage',5);           % V/track    Position measurement gain
w1 = ureal('w1',2*pi*50,'Percentage',5);       % rad/s      pivot bearing resonance, f1 =   50 Hz
w2 = ureal('w2',2*pi*2200,'Percentage',12);    % rad/s      first torsional resonance, f2 = 2200 Hz
w3 = ureal('w3',2*pi*6400,'Percentage',8);     % rad/s      second torsional resonance, f3 = 6400 Hz
w4 = ureal('w4',2*pi*8800,'Percentage',15);    % rad/s      first sway resonance, f4 = 8800 Hz
z1 = ureal('z1',0.3,'Percentage',5);           %            first resonance damping
z2 = ureal('z2',0.024,'Percentage',8);         %            second resonance damping
z3 = ureal('z3',0.129,'Percentage',10);        %            third resonance damping
z4 = ureal('z4',0.173,'Percentage',10);        %            fourth resonance damping
%
b1 =  0.006;    b2 =  0;                       %            first resonance coupling
b3 =  0.013;    b4 = -0.0018;                  %            second resonance coupling
b5 =  0.723;    b6 = -0.0015;                  %            third resonance coupling
b7 =  0.235;    b8 = -0.0263;                  %            fourth resonance coupling
%
% Resonances
% Mode 1
t = icsignal(1);
x1 = icsignal(1);
x2 = icsignal(1);
e = icsignal(1);
y = icsignal(1);
G = iconnect;
G.input = t;
G.output = y;
G.equation{1} = equate(e,t-x1-2*z1*x2);
G.equation{2} = equate(x1,w1*tf(1,[1 0])*x2);
G.equation{3} = equate(x2,w1*tf(1,[1 0])*e);
G.equation{4} = equate(y,b1*x1+b2*x2);
G1 = G.System;
%
% Mode 2
t = icsignal(1);
x1 = icsignal(1);
x2 = icsignal(1);
e = icsignal(1);
y = icsignal(1);
G = iconnect;
G.input = t;
G.output = y;
G.equation{1} = equate(e,t-x1-2*z2*x2);
G.equation{2} = equate(x1,w2*tf(1,[1 0])*x2);
G.equation{3} = equate(x2,w2*tf(1,[1 0])*e);
G.equation{4} = equate(y,b3*x1+b4*x2);
G2 = G.System;
%
% Mode 3
t = icsignal(1);
x1 = icsignal(1);
x2 = icsignal(1);
e = icsignal(1);
y = icsignal(1);
G = iconnect;
G.input = t;
G.output = y;
G.equation{1} = equate(e,t-x1-2*z3*x2);
G.equation{2} = equate(x1,w3*tf(1,[1 0])*x2);
G.equation{3} = equate(x2,w3*tf(1,[1 0])*e);
G.equation{4} = equate(y,b5*x1+b6*x2);
G3 = G.System;
%
% Mode 4
t = icsignal(1);
x1 = icsignal(1);
x2 = icsignal(1);
e = icsignal(1);
y = icsignal(1);
G = iconnect;
G.input = t;
G.output = y;
G.equation{1} = equate(e,t-x1-2*z4*x2);
G.equation{2} = equate(x1,w4*tf(1,[1 0])*x2);
G.equation{3} = equate(x2,w4*tf(1,[1 0])*e);
G.equation{4} = equate(y,b7*x1+b8*x2);
G4 = G.System;
%
int1 = tf(1,[1 0]);
int2 = tf(1,[1 0]);
Jinv = 1/J;
%
% model connection
t_d = icsignal(1);
u = icsignal(1);
y = icsignal(1);
e = icsignal(1);
i_c = icsignal(1);
t_a = icsignal(1);
t_h = icsignal(1);
omega = icsignal(1);
G = iconnect;
G.input = [t_d;u];
G.output = y;
G.equation{1} = equate(e,u-Rs*i_c);
G.equation{2} = equate(i_c,Gvca*(Kpa*e-Kb*omega));
G.equation{3} = equate(t_a,Kt*i_c+t_d);
G.equation{4} = equate(t_h,(G1+G2+G3+G4)*t_a);
G.equation{5} = equate(omega,Jinv*int1*t_h);
G.equation{6} = equate(y,Ky*R*tpm*int2*omega);
G = G.system;
clear b1, clear b2,   clear b3,   clear b4,    clear b5,  clear b6, clear b7, clear b8
clear e,  clear i_c,  clear int1, clear int2,  clear u,   clear x1, clear x2, clear y
clear G1, clear G2,   clear G3,   clear G4,    clear Gvca
clear J,  clear Jinv, clear Kb,   clear Kpa,   clear Kt,  clear Ky
clear Lcoil, clear R, clear Rc,   clear Rcoil, clear Rs
clear t,  clear t_a,  clear t_d,  clear t_h,   clear tau, clear tpm
clear w1, clear w2,   clear w3,   clear w4
clear z1, clear z2,   clear z3,   clear z4
clear gain_vca, clear omega