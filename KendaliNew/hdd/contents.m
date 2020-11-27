%   FILES FOR ANALYSIS AND DESIGN OF THE HARD DISK DRIVE SERVO SYSTEM
%
%
% Construction of the open loop system
%
% olp_hdd.m	   Creates the open loop interconnection
%
% Controllers design
%
% hinf_hdd.m   Design of Hinf controller
% lsh_hdd.m	   Design of Hinf loop shaping controller
% ms_hdd.m	   Design of mu-controller
%
% Controller order reduction
%
% red_hdd.m	   Obtains controller of 12th order
%
% Analysis of the continuous time closed loop system
%
% mu_hdd.m	   Analysis of robust stability, nominal and robust performance
% frs_hdd.m	   Frequency responses of the closed loop system
% clp_hdd.m	   Transient responses of the closed loop system with nominal
%              parameters
% mcs_hdd.m	   Transient responses for random values of uncertain
%              parameters
% wcp_hdd.m    Worst case performance of the closed-loop system
%
% Comparison of the systems with three controllers
%
% kf_hdd.m	   Frequency responses of the three controllers
% cfr_hdd.m	   Frequency responses of the three closed loop systems
% ctr_hdd.m	   Transient responses of the three closed loop systems
% prf_hdd.m	   Nominal performance of the three closed loop systems
% rbs_hdd.m	   Robust stability of the three closed loop systems
% rbp_hdd.m	   Robust performance of the three closed loop systems
%
% Analysis and design of the discrete-time system
%
% dcl_hdd.m	   Transient responses of the sampled-data system with
%              discretized controller
% dlp_hdd.m	   Creates the discrete-time open loop interconnection
% dms_hdd.m	   Synthesis of discrete-time mu-controller
% dmu_hdd.m	   Analysis of robust stability, nominal and robust 
%              performance of the closed loop system
% dfr_hdd.m	   Frequency responses of the closed loop systems
% dsl_hdd.m    Transient responses of the closed loop system
%
% Simulation of the nonlinear closed loop systems
%
% init_c_hdd.m Sets the initial parameters for simulation of the
%              continuous time system
% c_hdd.mdl	   Simulink model of the continuous time system
% init_d_hdd.m Sets the initial parameters for simulation of the sampled
%              data system
% d_hdd.mdl	   Simulink model of the sampled data system
%
% Auxiliary files
%
% mod_hdd.m	   Creates the uncertainty system model
% wts_hdd.m	   Sets the performance weighting  functions
% dwt_hdd.m	   Sets the performance weighting  functions for the discrete
%              time design
% sim_hdd.m	   Creates the simulation model of the closed loop system