%% Two Wheeled Inverse Pendulum - Self Balancing Robot
%% *Robot NXT*
% <<1.png>>
%% *Model*
% <<2.png>>
%
% <<3.png>>
%% *Parameter in Matlab*
% <<4.png>>
g = 9.81;						% gravitasi [m/sec^2]
m = 0.03;						% wheel weight [kg]
R = 0.04;						% wheel radius [m]
Jw = m * R^2 / 2;				% wheel inertia moment [kgm^2]
M = 0.6;						% body weight [kg]
W = 0.14;						% body width [m]
D = 0.04;						% body depth [m]
H = 0.144;						% body height [m]
L = H / 2;						% jarak center of mass from the wheel axle [m]
Jpsi = M * L^2 / 3;				% body pitch inertia moment [kgm^2]
Jphi = M * (W^2 + D^2) / 12;	% body yaw inertia moment [kgm^2]
%% Uncertainty of friction
fm = ureal('fm',0.0022,'Percentage',20);
fw = ureal('fw',0.0001,'Percentage',100);
% fm = 0.0022;					% friction coefficient between body & DC motor
% fw = 0;							% friction coefficient between wheel & floor

%% DC Motor Parameters			
Jm = 1e-5;						% DC motor inertia moment [kgm^2]
Rm = 6.69;						% DC motor resistance [ƒ¶]
Kb = 0.468;						% DC motor back EMF constant [Vsec/rad]
Kt = 0.317;						% DC motor torque constant [Nm/A]
n = 1;							% gear ratio

%% *State-Space Matrix Certain Model*
alpha = n * Kt / Rm;
beta = n * Kt * Kb / Rm + fm;
tmp = beta + fw;

E_11 = (2 * m + M) * R^2 + 2 * Jw + 2 * n^2 * Jm;
E_12 = M * L * R - 2 * n^2 * Jm;
E_22 = M * L^2 + Jpsi + 2 * n^2 * Jm;
detE = E_11 * E_22 - E_12^2;

A1_32 = -g * M * L * E_12 / detE;
A1_42 = g * M * L * E_11 / detE;
A1_33 = -2 * (tmp * E_22 + beta * E_12) / detE;
A1_43 = 2 * (tmp * E_12 + beta * E_11) / detE;
A1_34 = 2 * beta * (E_22 + E_12) / detE;
A1_44 = -2 * beta * (E_11 + E_12) / detE;
B1_3 = alpha * (E_22 + E_12) / detE;
B1_4 = -alpha * (E_11 + E_12) / detE;
A1 = [
	0 0 1 0
	0 0 0 1
	0 A1_32 A1_33 A1_34
	0 A1_42 A1_43 A1_44
	];
B1 = [
	0 0
	0 0
	B1_3 B1_3
	B1_4 B1_4
	];
C1 = eye(4);
D1 = zeros(4, 2);

I = m * W^2 / 2 + Jphi + (Jw + n^2 * Jm) * W^2 / (2 * R^2);
J = tmp * W^2 / (2 * R^2);
K = alpha * W / (2 * R);
A2 = [
	0 1
	0 -J / I
	];
B2 = [
	0      0
	-K / I K / I
	];
C2 = eye(2);
D2 = zeros(2);

% delete un-used variable
clear alpha beta tmp
clear E_11 E_12 E_22 detE
clear A1_32 A1_33 A1_34 A1_42 A1_43 A1_44 B1_3 B1_4 I J K

%% Uncertain SS
G_unc1 = ss(A1,B1,C1,D1);
G_unc2 = ss(A2,B2,C2,D2);
% get(G_unc1)
% get(G_unc2)
%% *Check Observability and Controllability*
Ob1=obsv(A1,C1);
Ct1=ctrb(A1,B1);
Ob2=obsv(A2,C2);
Ct2=ctrb(A2,B2);
% rank(Ct);
% rank(Ob)
%% *Singular Value Plot*
figure(1)
% step(G_unc1.Nominal,'r-',G_unc1,'b--'), grid
% bode(G_unc1.Nominal,'r-',G_unc1,'b--'), grid
sigma(G_unc1.Nominal,'r-',G_unc1,'b--'), grid
axis([10^(-1) 3*10^2 -5 25])
xlabel('Frequency')
ylabel('Singular values')
title('Singular value plot of the uncertain model')
legend('Nominal system','Random samples')

%% Note DESAIN KONTROL
% <<9.PNG>> 
% Membuat desain kontrol untuk plant 1 sangat mudah karena diagram blok
% sudah tersedia pada [1]. 
% 
%
%% Test Weight
w=logspace(-1,1,100);
figure(1)
bodemag(G_unc1,w) 
grid
figure(2)
step(G_unc1) 
grid
figure(3)
bodemag(G_unc2,w) 
grid
figure(4)
step(G_unc2) 
grid
% step(G_unc1)
% grid
%% *Performance Weighting Func*
% *Teori Performance Weighting*
%
% $Wp = diag(Wp11,Wp22,Wp33,Wp44,Wp55)$
%
% $Wp_{11}=0.95 \frac{0.4s+1}{5s+0.06}$
%
% $Wp_{22}=0.93$
%
% $Wp_{33}=0.15$
%
% $Wp_{44}=0.22  \frac{1.1s+1}{1.0s+1}$
%
% $Wp_{55}=1.8  \frac{0.4s+1}{5s+0.06}$
%%%%
tol = 0.6*10.0^(-1); % 
nuWp = [0.4  1];     % 
dnWp = [5.0  tol];
gainWp = 0.95*10^(0); % 
%%%%
Wp11 = gainWp*tf(nuWp,dnWp);
Wp22 = 0.93; %           
Wp33 = 0.15; % 
%%%%
nuWp = [1.1 1]; 
dnWp = [1.0 1];
gainWp = 0.22*10^(0); % 
%%%%%
Wp44 = gainWp*tf(nuWp,dnWp);
%---------------------
%    5
tol = 0.6*10.0^(-1); %
nuWp = [0.4  1];     % 
dnWp = [5.0  tol];   %
gainWp = 1.8*10^(0); % 
Wp55 = gainWp*tf(nuWp,dnWp);
%----------------------------
Wp = [Wp11 0    0   0   0;
      0   Wp22  0   0   0;
      0    0  Wp33  0   0;
      0    0    0  Wp44 0;
      0    0    0   0  Wp55]; % Wp untun plant 1
  
Wp2 = [Wp11 0    0;
      0   Wp44  0;
      0    0  Wp55]; % Wp untun plant 2
figure(2)
bodemag(1/Wp11,'r-',1/Wp44,'b--',1/Wp55,'c-.',{10^(-3) 10^2})
grid
title('Inverse performance weighting functions')
legend('W_{p11}^{-1}','W_{p44}^{-1}','W_{p55}^{-1}')
%
%% *Noise shaping filters*
%
% $Wn = diag(Wn11,Wn22)$
%
% $Wu_{11}=0.1 \frac{1.0s+2}{0.01s+1}$
% 
% $Wu_{22}=1.0 \frac{1.0s+2}{0.01s+1}$
Wn11 = 0.1*tf([1 2], [0.001 1]);  % 
Wn22 = 1.0*tf([1 2], [0.001 1]);  % 
%-------------------------------------
Wn = [Wn11  0
       0   Wn22];
% Sensor Noise
figure(3)
bodemag(Wn11,'r-',Wn22,'b--',{10^(-1) 10^4})
grid
title('Sensor noise weight')
legend('Wn11','Wn22')
%
%% *Control action weights*
% 
% $Wu = diag(Wu11,Wu22)$
% 
% $Wu_{11}=0.02 \frac{1.2s+1}{0.0024s+1}$
% 
% $Wu_{22}=0.02 \frac{1.2s+1}{0.0024s+1}$

nuWu = [1.2    1];    % 
dnWu = [0.0024  1];   % 
gainWu = 2.0*10^(-2); %
Wu11 = gainWu*tf(nuWu,dnWu);
%-------------------------------------
Wu = [Wu11 0
       0 Wu11];
figure(4)
bodemag(1/Wu11,'r-',{10^(-1) 10^4})
grid
title('Inverse control weighting functions')
%
%
%% open-loop connection with the weighting functions 
% 2 dof controller
% Plant 1
%
% <<6.PNG>>
% 
%
% <<7.PNG>>
% 
s = tf('s');
Intg = 1/(s+10^(-6)); 

systemnames    = ' G_unc1 Wn Wp Wu Intg ';
inputvar       = '[ ref{4}; noise{2}; control{2} ]';
outputvar      = '[ Wp; Wu; ref; -G_unc1(1:2); -G_unc1(3:4)-Wn; Intg ]';
input_to_G_unc1 = '[ control ]';
input_to_Wn    = '[ noise ]';
input_to_Wp    = '[ ref(1:4)-G_unc1(1:4); Intg ]';  
input_to_Wu    = '[ control ]';
input_to_Intg  = '[ ref(1)-G_unc1(1) ]';
sys_ic         = sysic;
%
C_hh = [1 0];

systemnames = 'G_unc2 Wn Wp2 Wu Intg';
inputvar = '[ ref{4}; noise{2}; control{2} ]';
outputvar = '[Wp2; Wu; ref; -G_unc2; -G_unc2(2)-Wn(1); Intg ]';
input_to_G_unc2 = '[ control ]';
input_to_Wp2 = '[ref(1:2)-G_unc2(1:2); Intg]';
input_to_Wn    = '[ noise ]';
input_to_Wu = '[ control ]';
input_to_Intg  = '[ ref(1)-G_unc2(1) ]';
sys_ic2 = sysic;
%
X_hh = [1 0];
%% Generates the open-loop connection for the Two-Wheeled Robot Control Plant 1
% System simulation 
%
%
s = tf('s');
Intg1 = 1/(s+10^(-5)); 
%
systemnames    = ' G_unc1 Intg1 Wn ';
inputvar       = '[ ref{4}; noise{2}; control{2} ]';
outputvar      = '[ G_unc1; control; ref; -G_unc1(1:2); -G_unc1(3:4)-Wn; Intg1 ]';
input_to_G_unc = '[ control ]';
input_to_Wn    = '[ noise ]';
input_to_Intg1 = '[ ref(1)-G_unc1(1) ]';
sim_ic         = sysic;
%% Frequency responses of the Two-Wheeled Robot Control System (Part 1)
%
% declare closed-loop interconnection
%
s = tf('s');
Intg2 = 1/(s+10^(-5));
%Intg2 = 1/s;
%
systemnames      = ' sim_ic Intg2 ';
inputvar         = '[ ref{4}; noise{2}; control{2} ]';
outputvar        = '[ sim_ic(1:6); ref(1:4)-sim_ic(1:4); Intg2; sim_ic(7:15) ]';
input_to_sim_ic  = '[ ref; noise; control ]';
input_to_Intg2    = '[ ref(1)- sim_ic(1) ]';
clp_ic           = sysic;
%% * $\mu$-Synthesis and $\mu$-Analysis*
% <<8.PNG>>
% 
% Untuk merancang $\mu$-synthesis. The matrix P is the transfer function matrix of the extended
% open-loop system shown in Fig 19.5
% *closed-loop connection for the discrete-time system*
Ts = 4.0*10^(-3);
omega = logspace(-3,log10(pi/Ts),200);

[Mat,Delta,blkstruct] = lftdata(sys_ic); %plant 1
M_d = c2d(Mat,Ts);
dsys_ic = lft(Delta,M_d);

[Mat2,Delta2,blkstruct2] = lftdata(sys_ic2); %plant 2
M_d2 = c2d(Mat2,Ts);
dsys_ic2 = lft(Delta2,M_d2);


% *Tune Mu-Synthesis*
nmeas = 9;
ncont = 2;
nmeas2 = 4;
ncont2 = 2;
fv = linspace(0,pi/Ts,200);

%% Opsi 1 $\mu$-Synthesis dengan musyn
%Plant 1

opts = musynOptions('MixedMU','on','FullDG',false,...
              'Display','short', ...
              'MaxIter',5)
[K,CLperf,info] = musyn(dsys_ic,nmeas,ncont,opts);
Ts = 4.0*10^(-3);
omega = logspace(-3,log10(pi/Ts),200);
CL = lft(dsys_ic,K);
wcg = wcgain(CL)
figure(1)
clf
sigma(CL,'r-',omega), grid
axis([10^(-3) 10^1 -10 10])
title('Full cost')
%
%Plant 2
% Gambar ?
opts2 = musynOptions('MixedMU','on','FullDG',false,...
              'Display','short', ...
              'MaxIter',8)
[K2,CLperf2,info2] = musyn(dsys_ic2,nmeas2,ncont2,opts2);
Ts = 4.0*10^(-3);
omega = logspace(-3,log10(pi/Ts),200);
CL2 = lft(dsys_ic2,K2);
wcg2 = wcgain(CL2)
figure(2)
clf
sigma(CL2,'r-',omega), grid
axis([10^(-3) 10^1 -10 10])
title('Full cost')
%% Opsi 2 $\mu$-Synthesis dengan dksyn
%plant 1
figure(1)
opt = dkitopt('FrequencyVector',fv, ...
              'DisplayWhileAutoIter','on', ...
              'NumberOfAutoIterations',5)
[Kd,dclp] = dksyn(dsys_ic,nmeas,ncont,opt);
Ts = 4.0*10^(-3);
omega = logspace(-3,log10(pi/Ts),200);
clf
sigma(dclp,'r-',omega), grid
axis([10^(-3) 10^1 -10 10])
title('Full cost')
[A_h,B_h,C_h,D_h] = ssdata(Kd);

% plant 2
figure(2)
opt2 = dkitopt('FrequencyVector',fv, ...
              'DisplayWhileAutoIter','on', ...
              'NumberOfAutoIterations',5)
[Kd2,dclp2] = dksyn(dsys_ic2,nmeas2,ncont2,opt2);
Ts = 4.0*10^(-3);
omega = logspace(-3,log10(pi/Ts),200);
clf
sigma(dclp2,'r-',omega), grid
axis([10^(-3) 10^1 -10 10])
title('Full cost')
[A_h2,B_h2,C_h2,D_h2] = ssdata(Kd2);

%% Frequency responses of the Two-Wheeled Robot Control System (Part 2)
Ts = 4.0*10^(-3);
% buat LFT
[M3,Delta3,blkstruct3] = lftdata(clp_ic);
M_d3 = c2d(M3,Ts);
% close loop
dclp_ic3 = lft(Delta3,M_d3);
clp = lft(dclp_ic3,Kd);
%
dWp = c2d(Wp,Ts);
dWn = c2d(Wn,Ts);
dWu = c2d(Wu,Ts);
%
% closed-loop frequency response
ref_loop = clp(1,1);
omega = logspace(-3,log10(pi/Ts),500);
figure(1)
sigma(ref_loop,'r-',omega), grid
xlabel('Frequency (rad/sec')
ylabel('Singular values (dB)')
axis([10^(-3) 10^1 -10 10])
title('Singular value plot of the closed-loop system \Theta(z)/r(z)')
%
% singular values of the output sensitivity function
sen_loop = clp(7,1);
omega = logspace(-4,log10(pi/Ts),500);
figure(2)
sigma(sen_loop,'b-',inv(dWp(1,1)),'r--',omega), grid
xlabel('Frequency (rad/sec')
ylabel('Singular values (dB)')
title('Singular value plot of the output sensitivity e_\Theta(z)/r(z)')
legend('Output sensitivity','Inverse performance weighting function')
%
% singular values of the integral component
sen_loop = clp(11,1);
omega = logspace(-4,log10(pi/Ts),500);
figure(3)
sigma(sen_loop,'b-',inv(dWp(5,5)),'r--',omega), grid
title('Singular value plot of the integral error Int(e_\Theta)(z)/r(z)')
legend('Integral error','Inverse performance weighting function')
%
% sensitivity of control action to reference
cont_loop = clp([5:6],[1:4]);
omega = logspace(-4,log10(pi/Ts),500);
figure(4)
sigma(cont_loop,'b-',inv(dWu),'r--',omega), grid
axis([10^(-4) pi/Ts -150 100])
title('Sensitivity of control to references')
legend('Control action','Inverse control weighting function')
%
% sensitivity of control action to noises
cont_loop = clp([5:6],[5:6]);
omega = logspace(-4,log10(pi/Ts),500);
figure(5)
sigma(cont_loop,'b-',inv(dWu),'r--',omega), grid
axis([10^(-4) pi/Ts -300 100])
title('Sensitivity of control to noises')
legend('Control action due to noises', ...
       'Inverse control weighting function')
%
% sensitivity of control action to reference and noise
cont_loop = clp([5:6],[1:6]);
omega = logspace(-4,log10(pi/Ts),500);
figure(6)
sigma(cont_loop,'b-',inv(dWu),'r--',omega), grid
axis([10^(-4) pi/Ts -150 100])
title('Sensitivity of control to references and noises')
legend('Control action due to references and noises', ...
       'Inverse control weighting function')
%
% controller frequency responses
omega = logspace(-4,log10(pi/Ts),500);
figure(7)
sigma(Kd,'r-',omega), grid
%bode(Kd,'r-',omega), grid
axis([10^(-4) pi/Ts -50 100])
title('Singular value plot of the controller')
%title('Bode value plot of the controller')
%
% open-loop frequency response
Ts = 4.0*10^(-3);
[M,Delta,blkstruct] = lftdata(G_unc1);
M_d = c2d(M,Ts);
Gunc_d = lft(Delta,M_d);
L = Gunc_d*Kd;
omega = logspace(-5,log10(pi/Ts),500);
figure(8)
sigma(L,'r-',omega), grid
axis([10^(-5) pi/Ts -50 150])
title('Singular value plot of the open-loop system')

%% *Mu analysis of the Two-Wheeled Robot Control System*
% *closed-loop system*
%
%<<5.PNG>>
%
% Plant 1
Ts = 4.0*10^(-3);
omega = logspace(-3,log10(pi/Ts),200);
dclp_ic = lft(dsys_ic,Kd,2,9);
dclp_g = ufrd(dclp_ic,omega);
% Plant 2
dclp_ic2 = lft(dsys_ic2,Kd2,2,4);
dclp_g2 = ufrd(dclp_ic2,omega);
%% robust stability analysis
%Plant 1
figure(1)
opt = robopt('Display','on');
[stabmarg,destabu,report,info] = robuststab(dclp_g,opt);
report
semilogx(info.MussvBnds(1,1),'r-',info.MussvBnds(1,2),'b--')
grid
title('Robust stability')
xlabel('Frequency (rad/sec)')
ylabel('mu')
legend('\mu-upper bound','\mu-lower bound')

%Plant 2
figure(2)
opt2 = robopt('Display','on');
[stabmarg2,destabu2,report2,info2] = robuststab(dclp_g2,opt2);
report2
semilogx(info2.MussvBnds(1,1),'r-',info2.MussvBnds(1,2),'b--')
grid
title('Robust stability')
xlabel('Frequency (rad/sec)')
ylabel('mu')
legend('\mu-upper bound','\mu-lower bound')

%% nominal performance
% Plant 1
Ts = 4.0*10^(-3);
omega = logspace(-3,log10(pi/Ts),200);
figure(1)
sv = sigma(dclp_ic.Nominal,omega);
sys = frd(sv(1,:),omega);
semilogx(sys,'r-')
grid
xlabel('Frequency (rad/sec)')
title('Nominal performance')

%Plant 2
Ts = 4.0*10^(-3);
omega = logspace(-3,log10(pi/Ts),200);
figure(2)
sv2 = sigma(dclp_ic2.Nominal,omega);
sys2 = frd(sv2(1,:),omega);
semilogx(sys2,'r-')
grid
xlabel('Frequency (rad/sec)')
title('Nominal performance')

%% robust performance Plant 1
% plant 1
figure(1)
opt = robopt('Display','on');
[perfmarg,perfmargunc,report,info] = robustperf(dclp_g,opt);
report
semilogx(info.MussvBnds(1,1),'r-',info.MussvBnds(1,2),'b--')
grid
xlabel('Frequency (rad/sec)')
ylabel('mu')
title('Robust performance')
legend('\mu-upper bound','\mu-lower bound')

% plant 2
figure(2)
opt2 = robopt('Display','on');
[perfmarg2,perfmargunc2,report2,info2] = robustperf(dclp_g2,opt2);
report2
semilogx(info2.MussvBnds(1,1),'r-',info2.MussvBnds(1,2),'b--')
grid
xlabel('Frequency (rad/sec)')
ylabel('mu')
title('Robust performance')
legend('\mu-upper bound','\mu-lower bound')

%% REFERENCE
%[1]D. W. Gu, P. H. Petkov, dan M. M. Konstantinov, “Robust control design with MATLAB®,” in Advanced Textbooks in Control and Signal Processing, 2013.
%[2]Yamamoto, Y.: NXTway-GS (Self-Balancing Two-Wheeled Robot) controller design).
% http://www.mathworks.com/matlabcentral/fileexchange/19147-nxtway-gs-self-balancingtwo-wheeled-robot-controller-design
