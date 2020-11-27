function [sys,x0,str,ts] = refer_flm(t,x,v,flag)
%
% S-function for generating of the reference signal
%
% parameters of the reference signal
%
ar = pi/10;
omr = 2.5*pi;
tm = 0.8;
r0 = 0;
%
pr1 = ar/omr;
rtm = ar*tm - pr1*sin(omr*tm) + r0;
%
% Inputs:  t    - time in secs
%          x    - state
%          v    - control variable
%          flag - an integer value that indicates the task
%                 to be performed by the S-function:
%                 flag = 0 - initialize the state vector
%                 flag = 1 - calculate the state derivatives
%                 flag = 3 - calculate outputs 
%
% Outputs: sys  - a generic return argument whose values depend
%                 on the flag value.
%          x0   - the initial state values. x0 is ignored, except
%                 when flag = 0.
%          str  - argument reserved for future use.
%          ts   - a two column matrix containing the sample times
%                 and offsets of the blocks. For continuous time
%                 systems ts = [0 0].
%
% Dispatch the flag
%
switch flag,
    
case 0
%
%   Initialization
%
%   Call function simsizes to create the sizes structure.    
    sizes = simsizes;
%   Load the sizes structure with the initialization information.    
    sizes.NumContStates  = 0;
    sizes.NumDiscStates  = 0;
    sizes.NumOutputs     = 1;
    sizes.NumInputs      = 1;
    sizes.DirFeedthrough = 1;
    sizes.NumSampleTimes = 1;
%   Load the sys vector with the sizes information.    
    sys = simsizes(sizes);
% 
%   Initialize the state vector
%
    x0 =[];
%
%   str is an empty matrix.
%
    str = [];
%
    ts = [0 0];
    
case 3

   if t < tm
     ref = ar*t - pr1*sin(omr*t) + r0;
   else
     ref = rtm;
   end
   
   sys = ref;
    
case { 1, 2, 4, 9 } 
%
% Unused flags
%
  sys = [];
otherwise
  error(['Unhandled flag = ',num2str(flag)]); % Error handling
end
% End of refer_flm