% Frequency responses of the Twin-Rotor Aerodynamic System
%
Ts = 0.01;
%
% plant discretization
sim_tras
[M,Delta] = lftdata(sim_ic);
M_d = c2d(M,Ts);
dsim_ic = lft(Delta,M_d);
%
% closed-loop system
dclp_ic = lft(dsim_ic,Kd,2,4);
%
nsample = 30;
dclp_30 = usample(dclp_ic,nsample);
for i = 1:nsample
%     
%   Bode plot of the closed-loop system
    ref_loop = dclp_30([3,6],3:4,i);
    omega = logspace(-1,log10(pi/Ts),200);
    figure(1)
    sigma(ref_loop,'b-',wm1,'r--',wm2,'m-.',omega)
    hold on
%
%   singular values of the output sensitivity function
    sen_loop = dclp_30([3,6],1:2,i);
    omega = logspace(-8,log10(pi/Ts),200);
    figure(2)
    sigma(sen_loop,'b-',1/wp1,'r--',1/wp2,'m-.',omega)
    hold on
%
%   singular values of the noise transfer function
    nois_loop = dclp_30([3,6],5:6,i);
    omega = logspace(-2,log10(pi/Ts),200);
    figure(3)
    sigma(nois_loop,'b-',omega)
    hold on
%
%   singular values of the input sensitivity function
    cont_loop = dclp_30(7:8,1:2,i);
    omega = logspace(0,log10(pi/Ts),500);
    figure(4)
    sigma(cont_loop,'b-',1/wu1,'r--',1/wu2,'m-.',omega)
    hold on
%
%   singular values of the noise to input  transfer function
    cont_loop = dclp_30(7:8,5:6,i);
    omega = logspace(0,log10(pi/Ts),500);
    figure(5)
    sigma(cont_loop,'b-',1/wu1,'r--',1/wu2,'m-.',omega)
    hold on    
end    
figure(1)
grid
temp1 = 'Singular Value Plot of the';
temp2 = ' Closed-loop Transfer Function Matrix';
title([temp1,temp2])
xlabel('Frequency')
axis([10^(-1) 10 -50 20]);
hold off
%
figure(2)
grid
temp1 = 'Singular Value Plot of the';
temp2 = ' Sensitivity Transfer Function Matrix';
title([temp1,temp2])
xlabel('Frequency')
axis([10^(-8) pi/Ts -100 40]);
hold off
%
figure(3)
grid
temp1 = 'Singular Value Plot of the';
temp2 = ' Noise Transfer Function Matrix';
title([temp1,temp2])
xlabel('Frequency')
axis([10^(-2) pi/Ts -150 0]);
hold off
%
figure(4)
grid
temp1 = 'Singular Value Plot of the';
temp2 = ' Input Sensitivity Transfer Function Matrix'; 
title([temp1,temp2])
xlabel('Frequency')  
axis([10^0 pi/Ts -60 100]);
hold off
%
figure(5)
grid
temp1 = 'Singular Value Plot of the';
temp2 = ' Noise to Input Transfer Function Matrix'; 
title([temp1,temp2])
xlabel('Frequency')  
axis([10^0 pi/Ts -60 100]);
hold off
%
% singular values of the controller
%    Kr = Kd(1:2,1:2);
%    Ky = Kd(1:2,3:4);
omega = logspace(-8,log10(pi/Ts),200);
figure(6)
sigma(Kd,'r-',omega), grid
axis([10^(-8) pi/Ts 0 90]);
title('Singular Value Plot of the Controller')
xlabel('Frequency')   
%
% singular values of the open loop transfer function
[M,Delta] = lftdata(G);
M_d = c2d(M,Ts);
Gd = lft(Delta,M_d);
open_loop = Gd([3,6],3:4)*Kd(1:2,1:2);
omega = logspace(-8,log10(pi/Ts),200);
figure(7)
sigma(open_loop,'b-',omega), grid
axis([10^(-8) pi/Ts -100 150]);
title('Singular Value Plot of G*Ky')
xlabel('Frequency')   