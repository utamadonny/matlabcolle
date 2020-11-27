% Mu-synthesis of the Twin-Rotor Aerodynamical System
%
% discrete-time model
Ts = 0.01;
[M,Delta] = lftdata(sys_ic);
M_d = c2d(M,Ts);
dsys_ic = lft(Delta,M_d);
nmeas = 4;
ncont = 2;
%
fv = linspace(10^(-3),pi/Ts,100);
opt = dkitopt('FrequencyVector',fv, ...
              'DisplayWhileAutoIter','on', ...
              'NumberOfAutoIterations',5)
[Kd_mu,CL_mu,bnd_mu,dkinfo] = dksyn(dsys_ic,nmeas,ncont,opt);
Kd = Kd_mu;
Ad = Kd.A;
Bd = Kd.B;
Cd = Kd.C;
Dd = Kd.D;