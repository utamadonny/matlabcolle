% %% Data
% X = linspace(1,10,100); 
% X = X'; 
% 
% % Specify the parameters for a second order Fourier series  
% w = .6067; 
% a0 = 1.6345; 
% a1 = -.6235; 
% b1 = -1.3501; 
% a2 = -1.1622;
% b2 = -.9443;  
% % Fourier2 is the true (unknown) relationship between X and Y 
% Y = a0 + a1*cos(X*w) + b1*sin(X*w) + a2*cos(2*X*w) + b2*sin(2*X*w);

X=ImportT;
Y=ImportY;

figure(1);
hold off
actual = stairs(X,Y,'k')
xlabel('X data');
ylabel('Y data');
L1= legend ('true'); 
hold on
%% Fitting
delete(L1);
gauss1 = fit(X, noisy,'gauss1');
% Plot the results  
fourier= plot(gauss1, 'r') ;

gauss2 = fit(X, noisy,'gauss2');
% Plot the results  
fourier= plot(gauss2, 'g') ;

gauss3 = fit(X, noisy,'gauss3');
% Plot the results  
fourier= plot(gauss3, 'b') ;

gauss4 = fit(X, noisy,'gauss4');
% Plot the results  
fourier= plot(gauss4, 'y') ;

L3 = legend('true','gauss1','gauss2','gauss3','gauss4');

