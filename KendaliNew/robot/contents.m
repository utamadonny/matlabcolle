%   FILES FOR ANALYSIS AND DESIGN OF TWO-WHEELED ROBOT CONTROL SYSTEM
%
%
% Construction of the open-loop system
%
% olp_robot_2dof.m	    Creates the open-loop interconnection
%
% Controller design
%
% dms_robot_2dof.m	    mu-synthesis of discrete-time 2dof controller
%
% Analysis of the discrete-time closed-loop system
%
% dmu_robot_2dof.m	    Analysis of robust stability, nominal and robust 
%                       performance
% dfrs_robot_2dof.m	    Frequency responses of the closed-loop system
% mcs_robot_2dof.m      Transient responses of the closed-loop system 
%                       for random values of the uncertain parameters           
% wcp_robot_2dof.m	    Worst case performance analysis of the closed-loop 
%                       system
%
% Implementation of the robust controller
%
% robust_controller.mdl	Modification of the original NXTway-GS controller,
%		                developed by Yorihisa Yamamoto and Takashi 
%                       Chikamasa(see the enclosed file license.txt),
%                       to implement robust control
% controller.mdl        Simulink subsystem block to include the
%                       controller in simulation block-diagram
%                       (references the file robust_controller.mdl) 
%
% Auxiliary files
%
% mod_robot_2dof.m	    Creates the uncertain robot plant model
% sim_robot_2dof.m	    Creates the simulation model of the closed-loop 
%                       system
% plot_robot_exper      Plots the control system variables whose values
%                       are stored in a a comma separated value file 
%                       with name 
%                       data_robot_2dof.csv 
%                       during the real-time experiments with the robot