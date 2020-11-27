%   FILES FOR ANALYSIS AND DESIGN OF TWIN-ROTOR AERODYNAMIC SYSTEM
%
%
% Construction of the open-loop system
%
% dlp_tras.m	      Creates the open-loop interconnection
%
% Controllers design
%
% dhin_tras.m	      Design of discrete-time Hinf controller
% dms_tras.m	      Design of discrete-time mu-controller
%
% Analysis of the closed-loop system
%
% dmu_tras.m	      Analysis of robust stability and robust performance
% dfrs_tras.m	      Frequency responses of the closed-loop system
% dcl_tras.m	      Transient responses of the closed-loop system 
%                     with nominal parameters
% dsl_tras.m          Transient responses of the closed-loop system 
%                     for random values of the uncertain parameters           
%
% Simulation of the nonlinear closed-loop system
%
% TRAS_2dof_model.mdl Simulink model of the nonlinear sampled-data system
%                     (requires to load in advance the file tras_char.mat)
%
% Auxiliary files
%
% mod_tras.m	      Creates the uncertain plant model
% approx_char.m       Approximation of the Twin-Rotor Aerodynamic System
%                     thrust characteristics
% wts_tras_hin.m	  Sets the performance weighting functions 
%                     for Hinf design
% wts_tras_mu.m	      Sets the performance weighting functions  
%                     for mu-synthesis
% sim_tras.m	      Creates the simulation model of the closed-loop 
%                     system
% plot_nonl_tras      Plots the results of nonlinear system simulation
% TRAS_2dof_exper.mat Results of the real-time control experiment
% plot_exper_tras     Plots the results of real-time experiments
% tras_char.mat	      Mat-file containing the data for nonlinear plant 
%                     thrust characteristics