function [t,y] = ode_Ham(f,tspan,y0,N,KC,varargin)
% Hamming method to solve vector d.e. y’(t) = f(t,y(t))
% for tspan = [t0,tf] and with the initial value y0 and N time steps
% using the modifier based on the error estimate depending on KC = 1/0
if nargin < 5, KC = 1; end %with modifier by default
if nargin < 4 | N <= 0, N = 100; end %default maximum number of iterations
if nargin < 3, y0 = 0; end %default initial value
y0 = y0(:)'; %make it a row vector
h = (tspan(2)-tspan(1))/N; %step size
tspan0 = tspan(1)+[0 3]*h;
[t,y] = ode_RK4(f,tspan0,y0,3,varargin{:}); %Initialize by Runge-Kutta
t = [t(1:3)' t(4):h:tspan(2)]';
for k = 2:4, F(k - 1,:) = feval(f,t(k),y(k,:),varargin{:}); end
p = y(4,:); c = y(4,:); h34 = h/3*4; KC11 = KC*112/121; KC91 = KC*9/121;
h312 = 3*h*[-1 2 1];
for k = 4:N
p1 = y(k - 3,:) + h34*(2*(F(1,:) + F(3,:)) - F(2,:)); %Eq.(6.4.9a)
m1 = p1 + KC11*(c - p); %Eq.(6.4.9b)
c1 = (-y(k - 2,:) + 9*y(k,:) +...
h312*[F(2:3,:); feval(f,t(k + 1),m1,varargin{:})])/8; %Eq.(6.4.9c)
y(k+1,:) = c1 - KC91*(c1 - p1); %Eq.(6.4.9d)
p = p1; c = c1; %update the predicted/corrected values
F = [F(2:3,:); feval(f,t(k + 1),y(k + 1,:),varargin{:})];
end
end

function [t,y] = ode_RK4(f,tspan,y0,N,varargin)
%Runge-Kutta method to solve vector differential eqn y’(t) = f(t,y(t))
% for tspan = [t0,tf] and with the initial value y0 and N time steps
if nargin < 4 | N <= 0, N = 100; end
if nargin < 3, y0 = 0; end
y(1,:) = y0(:)'; %make it a row vector
h = (tspan(2) - tspan(1))/N; t = tspan(1)+[0:N]'*h;
for k = 1:N
f1 = h*feval(f,t(k),y(k,:),varargin{:}); f1 = f1(:)'; %(6.3.2a)
f2 = h*feval(f,t(k) + h/2,y(k,:) + f1/2,varargin{:}); f2 = f2(:)';%(6.3.2b)
f3 = h*feval(f,t(k) + h/2,y(k,:) + f2/2,varargin{:}); f3 = f3(:)';%(6.3.2c)
f4 = h*feval(f,t(k) + h,y(k,:) + f3,varargin{:}); f4 = f4(:)'; %(6.3.2d)
y(k + 1,:) = y(k,:) + (f1 + 2*(f2 + f3) + f4)/6; %Eq.(6.3.1)
end
end
