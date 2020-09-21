clear
clc
%definisi dy/dx=f(x,y)
f=inline('-2*x*y^2','x','y');
fx=inline('1./(x.^2+1)');

a=0; b=5; alpha=1; n=25;
h=(b-a)/n;
t=a; w=alpha;
y=fx(t);
fprintf('pada t=%4.2f, w=%10.8f, y=%10.8f, err=%10.8f\n',t,w,y,abs(w-y));
yplot=zeros(n+1,1);

yplot(1)=alpha;
tplot=a:h:b;
for i=1:n
    w=w+h*f(t,w);
    yplot(i+1)=w;
    t=t+h;
    y=fx(t)
    fprintf('pada t=%4.2f, w=%10.8f, y=%10.8f, err=%10.8f\n',t,w,y,abs(w-y));
end

fplot=fx(tplot);
plot(tplot,yplot,'r',tplot,fplot,'g');
