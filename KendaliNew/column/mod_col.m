% Generates 8th order model of the distillation column
% with LV configuration
%
% After invoking the routine the variables are:
% 
% A         C         G4       Si      Uinit      
% B         D         G        So      Xinit
% 
% where:
%
% G4 - scaled linear model with 4 scaled inputs, 2 scaled outputs, 
%      82 states
% G  - scaled linear model with 2 scaled inputs, 2 scaled outputs, 
%      6 states     
% A,B,C,D - state space matrices for G
% Si and So - input and outputs scalings
%    Note: Unscaled model is G4u = inv(So)*G4*inv(Si);
% Uinit - nominal (steady state) values for the inputs
% Xinit - nominal (steady state) values for the states (G4 gives the
%         deviation from this nominal state)
%
%---------------------------------------------
% First find steady-state 
%---------------------------------------------
%
% Do this by simulating 5000 min with stabilized LV-model:
[t,x] = ode15s(@cola_lv,[0 5000],0.5*ones(1,82)'); 
Xinit = x(size(x,1),:)'; 
%  
%--------------------------------------
% Now linearize the model to obtain G4u
%--------------------------------------
%
% The open-loop unscaled model
Ls = 2.70629; Vs = 3.20629; Fs = 1.0; zFs = 0.5;
Uinit = [Ls Vs Fs zFs]';
[A,B,C,D] = cola_lin(@cola_lv_lin,Xinit',Uinit');
G4u =  ss(A,B,C,D);
%
%---------------------------------------
% Obtaining the scaled model G4
% --------------------------------------
%
% The following max. changes are used (for scaling the model):
Du = diag([1 1]);                % max inputs (scalings)
Dd = diag([0.2 0.1]);            % max disturbances (scalings)
De = diag([0.01 0.01]);          % max output errors (scalings)
% This implies the folling in terms of the scaled model G4:
   % Units for inputs (L,V):        1 = 1 kmol/min = F (the feed rate)
   % Units for disturbance 1 (F):   1 = 0.2 kmol/min (20% change)
   % Units for disturbance 2 (z_f): 1 = 0.1 mole fraction units
   %                                    (20% change)
   % Units for outputs 1 and 2 (y_D and x_B): 1 = 0.01 mole
   %  fraction units
% The scaled model is then G4:
Si = blkdiag(Du,Dd); So = inv(De); % introduce scaling matrices
G4 = So*G4u*Si;
[A82,B82,C82,D82] = ssdata(G4);
A = A82; B = B82(:,1:2); C = C82; D = D82(:,1:2);
G82 = ss(A,B,C,D);
%
% model reduction
G4_6 = reduce(G4,6);  % 6th order
[A6,B6,C6,D6] = ssdata(G4_6);
A = A6; B = B6(:,1:2); C = C6; D = D6(:,1:2);
G = ss(A,B,C,D);
%
clear t;clear x; clear G4u; clear G4_6;
clear Ls; clear Vs; clear Fs; clear zFs;
clear A6; clear B6; clear C6; clear D6;
clear Dd, clear De; clear Du;