% Transient responses of the closed_loop
% Distillation Column system in the case
% of maximum input delays
%
sim_col
if size(K,2) == 2
%  1 dof controller
   clp = lft(sim_ic_1dof,K,2,2); 
elseif size(K,2) == 4
%      2 dof controller
       clp = lft(sim_ic_2dof,K,2,4);
end
%
%response to the first reference input
ti = 0.1;
tfin = 100;
time = 0:ti:tfin;
nstep = size(time,2);
ref1(1:nstep) = 1.;
ref2(1:nstep) = 0.;
noise1(1:nstep) = 0.;
noise2(1:nstep) = 0.;
[y,t] = lsim(clp(1:4,1:4),[ref1',ref2',noise1',noise2'],time);
%y11    
figure(1)
plot(t,y(:,1),'r-')
axis([0 100 -0.5 1.5])
grid
title('Closed-loop Transient Response')
xlabel('Time (min)')
ylabel('y_{11}')   
%y21    
figure(2)
plot(t,y(:,2),'c-')
axis([0 100 -0.5 1.5])
grid    
title('Closed-loop Transient Response')
xlabel('Time (min)')
ylabel('y_{21}')        
%u11
figure(3)
plot(t,y(:,3),'b-')
axis([0 100 -0.5 1.5])
grid
title('Control action')
xlabel('Time (min)') 
ylabel('u_{11}')
%u21   
figure(4)
plot(t,y(:,4),'m-')
axis([0 100 -0.5 1.5])
grid
title('Control action')
xlabel('Time (min)')
ylabel('u_{21}')       
%
%response to the second reference input
ti = 0.1;
tfin = 100;
time = 0:ti:tfin;
nstep = size(time,2);
ref1(1:nstep) = 0.;
ref2(1:nstep) = 1.;
noise1(1:nstep) = 0.;
noise2(1:nstep) = 0.;
[y,t] = lsim(clp(1:4,1:4),[ref1',ref2',noise1',noise2'],time);
%y12
figure(5)
plot(t,y(:,1),'r-')
axis([0 100 -0.5 1.5])
grid
title('Closed-loop Transient Response')
xlabel('Time (min)')
ylabel('y_{12}')    
%y22   
figure(6)
plot(t,y(:,2),'c-')
axis([0 100 -0.5 1.5])
grid
title('Closed-loop Transient Response')
xlabel('Time (min)')
ylabel('y_{22}') 
%u12   
figure(7)
plot(t,y(:,3),'b-')
axis([0 100 -1.0 0.5])
grid
title('Control action')
xlabel('Time (min)')
ylabel('u_{12}')   
%u22   
figure(8)
plot(t,y(:,4),'m-')
axis([0 100 -1.0 0.5])
grid
title('Control action')
xlabel('Time (min)')
ylabel('u_{22}')        
clear ref1; clear ref2; clear noise1; clear noise2;