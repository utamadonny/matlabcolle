function [d]=differentiation(x,y,k,s)
% Input parameters
% s location where approximations are to be accurate
% x(1:n) grid point locations, found in x(1:n)
% y(1:n) functional value locations, found in y(1:n)
% k highest derivatives are sought at ’s’
% Output parameters
% d(1:k+1,1:n) sequence of approximate derivatives of order 0:k
n=length(x);
% Check whether ’s’ coincide with any one of ’x’. (i.e) functional value
% of ’s’ is known or not.
xs=x-s*ones(1,n);
pos=find(˜(xs&xs));
chi=˜all(xs);
% If chi=1 (functional value at ’s’ is known), then swap respective
% position of s and its functional value with first element of x and y.
if chi==1;
x([1 pos])=x([pos 1]);
y([1 pos])=y([pos 1]);
nevy(1,1:n)=y(1);
nev(1,1:n)=1;
end
f=1+chi;
% Determine the value of N(r)(s) andN˜(r)0,1,2,...,n[s] by Neville scheme and store %it in’nev’ and ’nevy’ respectively
for ij=f:k+1
yy(f:n)=1./(x(f:n)-s).ˆ(ij-1);
yy1=y.*yy;
nev(ij,f)=yy(f);
nevy(ij,f)=yy1(f);
for i= f:n
yy(f:n+f-i-1)=(yy(f+1:n+f-i).*(s-x(f:n+f-i-1))-yy (f:n+f-i-1)
.*(s-x(i+1:n)))./(x(i+1:n)-x(f:n+f-i-1));
yy1(f:n+f-i-1)=(yy1(f+1:n+f-i).*(s-x(f:n+f-i-1))- yy1(f:n+f-i-1)
.*(s-x(i+1:n)))./(x(i+1:n)-x(f:n+f-i-1));
nev(ij,i)=yy(f);
nevy(ij,i)=yy1(f);
end
end
% Find the value of a’s and store them in a two dimensional array ’b’
for m=1:n
b(1,m)=1;
mn=min(m,k+1);
a(1,1)=1;
FACT(mn)=1;
for i=2:mn
b(i,m)=0;
for j=1:i-1
b(i,m)=b(i,m)-b(j,m)*nev(i-j+1,m);
end
a(i,i:-1:1)=b(1:i,m)’;
FACT(mn+1-i)=factorial(i-1);
end
% Evaluate sequence of approximate derivatives up to order ’k’
Diff=(a(mn:-1:1,:)*nevy(1:mn,m)).*FACT’;
d(1:mn,m)=Diff(mn:-1:1);
end