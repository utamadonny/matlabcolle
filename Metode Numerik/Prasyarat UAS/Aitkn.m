function sol=Aitkn(fn,x0,Maxl)
xold=x0;
x1=feval(fn,xold);
for i=1:Maxl
    xnew=feval(fn,x1);
    xnew=feval(fn,x1);
    aitken=xnew-(xnew-x1).^2/(xnew-2*x1+xold);
    xold=x1;
    x1=xnew;
end
sol= aitken;