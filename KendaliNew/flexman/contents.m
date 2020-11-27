% FILES FOR ANALYSIS AND DESIGN OF FLEXIBLE-LINK MANIPULATOR CONTROL SYSTEM
%
%
% Building the open-loop interconnection
%
% olp_flm.m  	 Creates the open loop uncertain system model
%                for the flexible manipulator system with 
%                noncollocated controller
%
% Controllers design
%
% hin_flm.m      Design of noncollocated Hinf controller
% ms_flm.m	     Design of noncollocated mu-controller
%
% Controller order reduction
%
% red_flm.m      Obtains controller of 12th order
%
% Closed-loop system analysis
%
% rbs_flm.m      Robust stability analysis of the closed-loop system
% rbp_flm.m      Analysis of nominal performance and robust performance
%                of the closed-loop system
% frs_flm.m      Frequency responses of the closed-loop system
% clp_flm.m      Transient responses of the closed-loop system
%                with nominal parameters
% mcs_flm.m	     Transient responses for different values of uncertain
%                parameters
% pd_flm.m  	 Transient responses of the closed-loop system
%                with PD controller
% pdfrs_flm.m    Frequency responses of the closed-loop system
%                with PD controller
%
% Simulation of the nonlinear closed-loop system
%
% init_flm.m  	 Sets the initial data for the simulation
% nls_flm.mdl	 Simulink model of the closed loop system with 
%                noncollocated controller
% s3d_flm        3D simulation of the manipulator motion using 
%                noncollocated Hinf or mu-controller
% p3d_flm        3D simulation of the manipulator motion using 
%                PID controller 
%
% Auxiliary files in the system analysis and design
%
% mod_flm.m      Creates the uncertain model of the flexible-link
%                manipulator
% par_flm.m  	 Computes the coefficients of the manipulator model
% par_flm_plot.m Plots the exact and approximated model parameters
% sim_flm.m	     Creates the simulation model of the closed-loop system
% wts_flm.m 	 Sets the performance weighting functions
%
% Auxiliary files in the nonlinear system simulation
%
% s_flm.m   	 S-function used in the nonlinear system simulation 
% refer_flm.m    S-function for generating of the reference signal
% sdrv_flm.m     Calculates manipulator and controller state derivatives
%                (used with s3d_flm.m)
% pdrv_flm.m     Calculates manipulator and controller state derivatives
%                (used with p3d_flm.m)
% betal_flm.m    Determines a given number of ordered by size roots of
%                the flexible link frequency equation
% ffeq_flm.m     Auxiliary function used to determine frequency
%                equation roots
% nopfi_flm.m    Normalizes a given number of shape functions
% phid2v_flm.m   Auxiliary function used to normalize the shape functions
% xphiv_flm.m    Auxiliary function used to determine nonlinear
%                manipulator model coefficients
% phi_flm.m      Calculates the value of a shape function for a given value
%                of the argument
% phiv_flm.m     Computes the value of an eigenform for several values of
%                the argument