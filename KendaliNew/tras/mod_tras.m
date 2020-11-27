% Uncertain model of the Two Rotor Aerodynamical System
%
% TRAS parameters
%
alpha_v = -0.1;
J_h_nom = 0.0237903793335*(cos(alpha_v))^2 + 0.0030096206665;
R_v_nom = 0.05005756*sin(alpha_v) - 0.09360078*cos(alpha_v);
%
% Azimuth
I_h = 1/37000; % kg.^m2 Moment of inertia with respect to vertical axis
k_H_h = ureal('k_H_h',9.838910923224026*10^3,'Percentage',10);
k_F_h = ureal('k_F_h',2.129316621491640*10^(-5),'Percentage',10);
l_t = 0.216;
J_h = ureal('J_h',J_h_nom,'Percentage',10);
k_f_h = ureal('k_f_h',0.00588996198,'Percentage',5);
k_v_h = ureal('k_v_h',-0.0178200378418,'Percentage',5);
%
% Pitch
I_v = 1/6100;
k_H_v = ureal('k_H_v',4.874573566076675*10^3,'Percentage',10);
k_F_v = ureal('k_F_v',3.077225697928733*10^(-4),'Percentage',10);
l_m = 0.202;
J_v = 0.0300580807997;
k_f_v = ureal('k_f_v',0.0127095,'Percentage',5);
k_h_v = ureal('k_h_v',0.00417495398545,'Percentage',5);
R_v = ureal('R_v',R_v_nom,'Percentage',5);
%
% Tail rotor
I_h_inv = 1/I_h;
k_H_h_inv = 1/k_H_h;
Int1 = tf([1],[1 0]);
systemnames = ' I_h_inv k_H_h_inv Int1 ';
inputvar = '[ control_h ]';
outputvar = '[ Int1 ]';
input_to_I_h_inv = '[ control_h - k_H_h_inv ]';
input_to_k_H_h_inv = '[ Int1 ]';
input_to_Int1 = '[ I_h_inv ]';
Act_h = sysic;
%
% Azimuth position
k_M_h_alpha = l_t*k_F_h*sin(alpha_v);
k_M_h_omega = l_t*k_F_h*cos(alpha_v);
u_v_nom = 0.3;
k_v_h_alpha = k_v_h*sin(alpha_v)*u_v_nom;
k_v_h_u = k_v_h*cos(alpha_v);
J_h_inv = 1/J_h;
Int2 = tf([1],[1 0]);
Int3 = tf([1],[1 0]);
systemnames = ' k_M_h_alpha k_M_h_omega J_h_inv k_f_h k_v_h_alpha k_v_h_u Int2 Int3 ';
inputvar = '[ M_h_d; omega_h; Int6; control_v ]'; 
outputvar = '[ Int2; Int3 ]';
input_to_k_M_h_alpha = '[ Int6 ]';
input_to_k_M_h_omega = '[ omega_h ]';
input_to_J_h_inv = '[ -k_M_h_alpha + k_M_h_omega + M_h_d - k_f_h - k_v_h_alpha + k_v_h_u ]';
input_to_k_f_h = '[ Int2 ]';
input_to_k_v_h_alpha = '[ Int6 ]';  
input_to_k_v_h_u = '[ control_v ]';
input_to_Int2 = '[ J_h_inv ]';
input_to_Int3 = '[ Int2 ]';
Azimuth = sysic;
%                                             
% Main rotor
I_v_inv = 1/I_v;
k_H_v_inv = 1/k_H_v;
Int4 = tf([1],[1 0]);
systemnames = ' I_v_inv k_H_v_inv Int4 ';
inputvar = '[ control_v ]';
outputvar = '[ Int4 ]';
input_to_I_v_inv = '[ control_v - k_H_v_inv ]';
input_to_k_H_v_inv = '[ Int4 ]';
input_to_Int4 = '[ I_v_inv ]';
Act_v = sysic;
%
% Pitch position
k_M_v = l_m*k_F_v;
J_v_inv = 1/J_v;
Int5 = tf([1],[1 0]);
Int6 = tf([1],[1 0]);
systemnames = ' k_M_v J_v_inv k_f_v k_h_v R_v Int5 Int6 ';
inputvar = '[ M_v_d; omega_v; control_h ]';
outputvar = '[ Int5; Int6 ]';
input_to_k_M_v = '[ omega_v ]';
input_to_J_v_inv = '[ k_M_v + M_v_d - k_f_v + k_h_v + R_v ]';
input_to_k_f_v = '[ Int5 ]';
input_to_k_h_v = '[ control_h ]';
input_to_R_v = '[ Int6 ]';
input_to_Int5 = '[ J_v_inv ]';
input_to_Int6 = '[ Int5 ]';
Pitch = sysic;
%
% plant connection
systemnames = ' Act_h Azimuth Act_v Pitch ';
inputvar = '[ dist{2}; control{2} ]';
outputvar = '[ Act_h; Azimuth; Act_v; Pitch ]';
input_to_Act_h = '[ control(1) ]';
input_to_Azimuth = '[ dist(1); Act_h; Pitch(2); control(2) ]';
input_to_Act_v = '[ control(2) ]';
input_to_Pitch = '[ dist(2); Act_v; control(1) ]';
G = sysic;