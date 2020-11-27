% Frequency responses of the Distillation Column
% closed-loop system for random input gains and delays
%
mod_col
%
% Unscale the plant and controller transfer matrices
Du = diag([1 1]); Si = Du;
De = diag([0.01 0.01]); So = inv(De);
S = blkdiag(So,So);
G_u = inv(So)*G*inv(Si);
if size(K,2) == 2
%  1 dof controller
   K_u = K*So;
elseif size(K,2) == 4
%       2 dof controller        
        K_u = K*S; 
end        
Wn_u = inv(So)*Wn;
%
% Set the parameters values
[k1,k2,Theta1,Theta2] = ndgrid([0.8 1.2],[0.8 1.2],[0 1],[0 1]);
%
for j = 1:16
    [num1,den1] = pade(Theta1(j),2);
    del1 = tf(num1,den1);
    [num2,den2] = pade(Theta2(j),2);
    del2 = tf(num2,den2);
    Del1 = k1(j)*del1;
    Del2 = k2(j)*del2;
    Del = blkdiag(Del1,Del2);
    Gd_u = G_u*Del;
%   
    if size(K,2) == 2    
%      1 dof controller
       systemnames = ' Gd_u K_u Wn_u ';
       inputvar = '[ ref{2}; dist{2}; noise{2} ]';
       outputvar = '[ Gd_u+dist; K_u ]';
       input_to_Gd_u = '[ K_u ]';
       input_to_K_u = '[ ref-Gd_u-dist-Wn_u ]';
       input_to_Wn_u = '[ noise ]';
       clp_ic = sysic;
%    
    elseif size(K,2) == 4
%      2 dof controller   
       systemnames = ' Gd_u K_u Wn_u ';
       inputvar = '[ ref{2}; dist{2}; noise{2} ]';
       outputvar = '[ Gd_u+dist; K_u ]';
       input_to_Gd_u = '[ K_u ]';
       input_to_K_u = '[ -Gd_u-dist-Wn_u; ref ]';
       input_to_Wn_u = '[ noise ]';
       clp_ic = sysic;
    end
%
%   singular values of the closed-loop transfer function
    ref_loop = clp_ic(1:2,1:2);
    omega = logspace(-2,2,100);
    figure(1)
    sigma(ref_loop,'r-',omega)
    hold on
%
%   singular values of the sensitivity function
    sen_loop = clp_ic(1:2,3:4);
    omega = logspace(-3,1,100);
    figure(2)
    sigma(sen_loop,'b-',omega)
    hold on
%
%   singular values of the noise transfer function
    nos_loop = clp_ic(1:2,5:6);
    omega = logspace(-3,3,100);
    figure(3)
    sigma(nos_loop,'b-',omega)
    hold on
%
%   singular values of G.Ky
    Ky = K_u(1:2,1:2);
    L = Gd_u*Ky;
    omega = logspace(-3,3,100);
    figure(4)
    sigma(L,'b-',omega)
    hold on
%
%   singular values of Ky.S
    sen_loop = clp_ic(3:4,3:4);
    omega = logspace(-2,3,100);
    figure(5)
    sigma(sen_loop,'b-',omega)
    hold on
end 
figure(1)
grid
temp1 = 'Singular Value Plot of the';
temp2 = ' Closed-loop Transfer Function Matrix';
title([temp1,temp2])
xlabel('Frequency (rad/min)')
hold off
figure(2)
grid
title('Singular Value Plot of the Sensitivity Function')
xlabel('Frequency (rad/min)')
hold off
figure(3)
grid
title('Singular Value Plot of the Noise Transfer Function')
xlabel('Frequency (rad/min)')
figure(4)
grid
title('Singular Value Plot of G Ky')
xlabel('Frequency (rad/min)')  
hold off
figure(5)
grid
title('Singular Value Plot of Ky S')
xlabel('Frequency (rad/min)')
%
% singular values of the controller
omega = logspace(-3,1,100);
figure(6)
sigma(K,'r-',omega)
grid
title('Singular Value Plot of the Controller')
xlabel('Frequency (rad/min)')   