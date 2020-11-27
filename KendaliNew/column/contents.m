%   FILES FOR ANALYSIS AND DESIGN OF DISTILLATION COLUMN SYSTEM
%
%
% Construction of the open-loop interconnection
%
% olp_col.m	     Creates open loop interconnections intended 
%                for design of 1-DOF and 2-DOF controllers
%
% Controllers design
%
% hin_col.m      Design of 1-DOF and 2-DOF Hinf controllers
% lsh_col.m	     Design of 1-DOF Hinf loop shaping controller
% ms_col.m	     Design of 1-DOF and 2-DOF Hinf mu-controller
%
% Controller order reduction
%
% red_col.m	     Obtains controller of 11th order
%
% Analysis of the continuous time closed loop system
%
% mu_col.m	     Analysis of robust stability, nominal and robust 
%                performance
% frs_col.m	     Frequency responses of the closed loop system
%                for random input gains and delays
% clp_col.m	     Transient responses of the closed loop system
%                for maximum input delays
% mcs_col.m      Transient responses and control actions of the closed loop 
%                system for random input gains and delays
%
% Simulation of the nonlinear closed loop system
%
% init_col.m     Sets the initial parameters for simulation of the
%                continuous time system with 2-DOF controller
% nls_col.mdl    Simulink model of the continuous time system
%                with 2-DOF controller
%
% Auxiliary files
%
% cola_lin.m     Linearizes the nonlinear model
% cola_lv.m      Simulates the nonlinear system with LV configuration
% cola_lv_lin.m  Creates a linear model of the LV-distillation column
% colamod.m      Creates a nonlinear model of the distillation column
% colas.m        Simulink interface to colamod.m 
% mod_col.m	     Creates the uncertainty system model
% unc_col.m      Approximates uncertain time delay by unstructured
%                input multiplicative perturbation
% wfit.m         Fits a stable and minimum phase 3rd order transfer 
%                function to a frequency response
% wts_col.m	     Sets the performance weighting  functions
% sim_col.m	     Creates the simulation model of the closed loop system
%                for maximum input delays
%
% The files cola_lin.m, cola_lv.m, cola_lv_lin.m, colamod.m and colas.m 
% are provided by kind permission of the author, Sigurd Skogestad