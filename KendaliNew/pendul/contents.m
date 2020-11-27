%   FILES FOR ANALYSIS AND DESIGN OF TRIPLE INVERTED PENDULUM SYSTEM
%
%
% Construction of the open-loop system
%
% olp_pend.m	Creates the open loop interconnection
%
% Controllers design
%
% hinf_pend.m	Design of Hinf controller
% ms_pend.m	    Design of mu-controller
%
% Controller order reduction
%
% red_pend.m	Obtains controller of 25th order
%
% Analysis of the continuous time closed-loop system
%
% mu_pend.m	    Analysis of robust stability, nominal and robust 
%               performance
% frs_pend.m	Frequency responses of the closed-loop system
% clp_pend.m	Transient responses of the closed-loop system with nominal
%               parameters
% mcs_pend.m    Transient responses of the closed-loop system for random
%               values of the uncertain parameters           
% wcp_pend.m	Worst case performance analysis of the closed-loop system
%
% Analysis of the sampled-data system
%
% dcl_pend.m	Transient responses of the closed loop system
%
% Simulation of the nonlinear closed-loop system
%
% init_c_pend.m	Sets the initial parameters for simulation of the 
%               continuous-time system
% c_pend.mdl	Simulink model of the continuous-time system
% init_d_pend.m	Sets the initial parameters for simulation of 
%               the sampled-data system
% d_pend.mdl	Simulink model of the sampled-data system
%
% Auxiliary files
%
% mod_pend.m	Creates the uncertain pendulum system model
% act_pend.m	Creates actuator models with input multiplicative 
%               uncertainty
% trans1_m.m	Approximates the unceratinty of the 1st actuator
% trans2_m.m	Approximates the uncertainty of the 2nd actuator
% wts_pend.m	Sets the performance weighting functions
% wsn_pend.m	Sets the noise shaping filter
% sim_pend.m	Creates the simulation model of the closed-loop system
% wfit.m		Fits a transfer function to a given frequency response
% s_pend.m	    S-function used in the nonlinear simulation of the pendulum 
%               system
% inc_pend.m	Sets the initial conditions in the nonlinear simulation 
%               of the pendulum system