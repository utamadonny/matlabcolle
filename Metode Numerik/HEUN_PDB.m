clear
clc
%definisi dy/dx=f(x,y)
f=inline('-2*x*y^2','x','y');
fx=inline('1./(x.^2+1)');
a=0; b=5; w=1; n=25;
h=(b-a)/n; %step

y=fx(a);
fprintf('pada t=%4.2f, w=%10.8f, y=%10.8f, err=%10.8f\n',a,w,y,abs(w-y));
yplot=zeros(n+1,1);

yplot(1)=w;
tplot=a:h:b;
for i=1:n
    w=w+h*(f(a,w)+3*f(a+2*h/3,w+2*h*f(a,w)/3))/4;
    yplot(i+1)=w;
    a=a+h;
    y=fx(a)
    fprintf('pada t=%4.2f, w=%10.8f, y=%10.8f, err=%10.8f\n',a,w,y,abs(w-y));
end

fplot=fx(tplot);
plot(tplot,yplot,'r',tplot,fplot,'g');
