% Polynomial approximation of the Twin-Rotor Aerodynamic System
% thrust characteristics
%
load tras_char.mat
%
% main rotor thrust characteristics
p1 = polyfit(control_p,rpm_p,7);
p2 = polyfit(rpm_p,force_p,5);
figure(1)
x = linspace(-1,1,100);
y = polyval(p1,x);
plot(control_p,rpm_p,'b-',x,y,'r--'), grid
xlabel('Control')
ylabel('Velocity (rpm)')
title('Main rotor velocity')
legend('Exact value','Approximation',2)
%
figure(2)
x = linspace(-4000,4000,100);
y = polyval(p2,x);
plot(rpm_p,force_p,'b-',x,y,'r--'), grid
xlabel('Velocity (rpm)')
ylabel('Thrust (N)')
title('Main rotor thrust')
legend('Exact value','Approximation',2)
%
u_v_nom = 0.3;
rpm_pitch = polyval(p1,u_v_nom)
der_p1 = polyder(p1);
der_p2 = polyder(p2);
k_H_v = polyval(der_p1,u_v_nom)
k_F_v = polyval(der_p2,rpm_pitch)
%
% tail rotor thrust characteristics
p3 = polyfit(control_a,rpm_a,5);
p4 = polyfit(rpm_a,force_a,5);
figure(3)
x = linspace(-1,1,100);
y = polyval(p3,x);
plot(control_a,rpm_a,'b-',x,y,'r--'), grid
xlabel('Control')
ylabel('Velocity (rpm)')
title('Tail rotor velocity')
legend('Exact value','Approximation',2)
%
figure(4)
x = linspace(-8000,8000,100);
y = polyval(p4,x);
plot(rpm_a,force_a,'b-',x,y,'r--'), grid
xlabel('Velocity (rpm)')
ylabel('Thrust (N)')
title('Tail rotor thrust')
legend('Exact value','Approximation',2)
%
u_h = 0;
der_p3 = polyder(p3);
der_p4 = polyder(p4);
k_H_h =  polyval(der_p3,u_h)
k_F_h =  polyval(der_p4,u_h)