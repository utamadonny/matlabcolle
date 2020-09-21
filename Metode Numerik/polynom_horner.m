function px = polynom_horner(x,a)

n=length(a);
px= a(n);

for i=1:(n-1)
    px=a(n-1)+x*px;
end

