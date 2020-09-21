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
%% Import Data dari State Space
X=ImportT;
Y=ImportY;

figure(1);
hold off
actual = stairs(X,Y)
xlabel('X data');
ylabel('Y data');
L1= legend ('true');
%% Add in a noise vector 
K = max(Y) - min(Y); 
noisy = Y +  .2*K*randn(100,1);  

delete(actual);
delete (L1);

hold on
% Generate a scatterplot 
sample = scatter(X,noisy,'b'); 
L2 = legend('Noisy Data Sample'); 

%% Fitting

foo = fit(X, noisy,'gauss1');
% Plot the results  
Gauss= plot(foo, 'r') ;
actual =stairs (X,Y, 'm')
L3 = legend('Noisy Data Sample','Gauss1','true');

%% delete
delete(Gauss)
delete (actual)
delete (L3)

%% LOWESS
large=smooth(X,noisy,.9,'lowess');
Lplot= stairs(X,large,'k')

small=smooth(X,noisy,.02,'lowess');
Splot= stairs(X,small,'r')
L4 = legend('Noisy Data Sample','Span=0.9','Span=0.02');
% hold off snapnow
% foo =       General model Fourier2:      foo(x) =  a0 + a1*cos(x*w) + b1*sin(x*w) +                 a2*cos(2*x*w) + b2*sin(2*x*w)      Coefficients (with 95% confidence bounds):        a0 =       1.734  (1.446, 2.021)        a1 =     -0.1998  (-1.065, 0.6655)        b1 =      -1.413  (-1.68, -1.146)        a2 =     -0.7688  (-1.752, 0.2142)        b2 =      -1.317  (-1.867, -0.7668)        w =      0.6334  (0.5802, 0.6866)

%% Validate 
delete(Splot);
delete (Lplot);
delete(L4);

num = 490;
spans = linspace(.01,.99,num);
sse = zeros(size(spans));
cp = cvpartition(100,'k',10);

for j=1:length(spans)
    f = @(train,test) norm(test(:,2) - mylowess(train,test(:,1),spans(j)))^2;
    sse(j) = sum(crossval(f,[X,noisy],'partition',cp));
end

[minsse,minj] = min(sse);
span = spans(minj);

x = linspace(min(X),max(X));
loess = line(x,mylowess([X,noisy],x,span),'color','k','linestyle','-','linewidth',2)
L5= legend('Noisy Data Sample','Best Span');

%% compare models
delete(sample);

f = fit(X,noisy,'gauss1');
Gauss = plot(f, 'g');
delete(L5);
actual = stairs(X,Y);
L6= legend('Best Span','Gauss1','true')

%% Confidence Intervals
delete(loess)
delete(Gauss)
delete(actual)

f = @(xy) mylowess(xy,X,span);
yboot2 = bootstrp(1000,f,[X,noisy])';
% yboot2 = bootstrp(1000,f,[X,noisy])';

meanloess = mean(yboot2,2);
h1 = line(X, meanloess,'color','k','linestyle','-','linewidth',2);

stdloess = std(yboot2,0,2);

h2 = line(X, meanloess+2*stdloess,'color','r','linestyle','--','linewidth',2);
h3 = line(X, meanloess-2*stdloess,'color','r','linestyle','--','linewidth',2);
