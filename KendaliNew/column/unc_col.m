% Approximation of uncertain time delay by unstructured
% multiplicative perturbation
%
hold off
omega = logspace(-2,2,200);
% 3rd order approximation
W_Delta = tf([2.2138 15.9537 27.6702  4.9050], ...
             [1.      8.3412 21.2393 22.6705]);
W_Delta_frd = frd(W_Delta,omega);
%
for k = 0.8:0.05:1.2;
    for tau = 0:0.1:1.0;
        for i = 1:200
            om = omega(i);
            pert(i) = sqrt((k*cos(om*tau)-1)^2 + (k*sin(om*tau))^2);
        end
        pert_frd = frd(pert,omega);
        bodemag(W_Delta_frd,'r-',pert_frd,'c--'), grid on
        hold on
    end    
end
xlabel('Frequency (rad/min)')
ylabel('Magnitude')
temp1 = 'Approximation of uncertain time delay';
temp2 = ' by multiplicative perturbation';
title([temp1 temp2])