% Transient responses of the closed_loop Distillation 
% Column system for random input gains and delays
%
mod_col
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
    Gd = G*Del;
%    
    if size(K,2) == 2    
%      1 dof controller
       systemnames = ' Gd K Wn ';
       inputvar = '[ ref{2}; noise{2} ]';
       outputvar = '[ Gd; K ]';
       input_to_Gd = '[ K ]';
       input_to_K = '[ ref-Gd-Wn ]';
       input_to_Wn = '[ noise ]';
       clp_ic = sysic;
%    
    elseif size(K,2) == 4
%      2 dof controller   
       systemnames = ' Gd K Wn ';
       inputvar = '[ ref{2}; noise{2} ]';
       outputvar = '[ Gd; K ]';
       input_to_Gd = '[ K ]';
       input_to_K = '[ -Gd-Wn; ref ]';
       input_to_Wn = '[ noise ]';
       clp_ic = sysic;
    end
%
%   response to the reference input
    ti = 0.1;
    tfin = 100;
    time = 0:ti:tfin;
    nstep = size(time,2);
    ref1(1:nstep) = 1.;
    ref2(1:nstep) = 0.;
    noise1(1:nstep) = 0.;
    noise2(1:nstep) = 0.;
    [y,t] = lsim(clp_ic(1:4,1:4),[ref1',ref2',noise1',noise2'],time);
%   y11    
    figure(1)
    plot(t,y(:,1),'r-')
    hold on
%   y21    
    figure(2)
    plot(t,y(:,2),'c-')
    hold on
%   u11
    figure(3)
    plot(t,y(:,3),'b-')
    hold on
%   u21   
    figure(4)
    plot(t,y(:,4),'m-')
    hold on
%
    ti = 0.1;
    tfin = 100;
    time = 0:ti:tfin;
    nstep = size(time,2);
    ref1(1:nstep) = 0.;
    ref2(1:nstep) = 1.;
    noise1(1:nstep) = 0.;
    noise2(1:nstep) = 0.;
    [y,t] = lsim(clp_ic(1:4,1:4),[ref1',ref2',noise1',noise2'],time);
%   y12
    figure(5)
    plot(t,y(:,1),'r-')
    hold on
%   y22   
    figure(6)
    plot(t,y(:,2),'c-')
    hold on
 %  u12   
    figure(7)
    plot(t,y(:,3),'b-')
    hold on
 %  u22   
    figure(8)
    plot(t,y(:,4),'m-')
    hold on
end
figure(1)
axis([0 100 -0.5 1.5])
grid
title('Closed-loop Transient Response')
xlabel('Time (min)')
ylabel('y_{11}')
hold off
figure(2)
axis([0 100 -0.5 1.5])
grid    
title('Closed-loop Transient Response')
xlabel('Time (min)')
ylabel('y_{21}')    
hold off
figure(3)
axis([0 100 -0.5 1.5])
grid
title('Control action')
xlabel('Time (min)') 
ylabel('u_{11}')
hold off
figure(4)
axis([0 100 -0.5 1.5])
grid
title('Control action')
xlabel('Time (min)')
ylabel('u_{21}')    
hold off
figure(5)
axis([0 100 -0.5 1.5])
grid
title('Closed-loop Transient Response')
xlabel('Time (min)')
ylabel('y_{12}')
hold off
figure(6)
axis([0 100 -0.5 1.5])
grid
title('Closed-loop Transient Response')
xlabel('Time (min)')
ylabel('y_{22}')
hold off
figure(7)
axis([0 100 -1.0 0.5])
grid
title('Control action')
xlabel('Time (min)')
ylabel('u_{12}')
hold off
figure(8)
axis([0 100 -1.0 0.5])
grid
title('Control action')
xlabel('Time (min)')
ylabel('u_{22}')    
hold off
clear ref1; clear ref2; clear noise1; clear noise2;