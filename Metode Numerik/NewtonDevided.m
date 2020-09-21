clear
clc

m=input('Derajat polinomial:');
x=zeros(m+1,1);
y=zeros(m+1,1);
F=zeros(m+1,m+1);

for i=1:m+1
    fprintf('Data ke-%2d\n',i-1);
    x(i)=input('x: ');
    y(i)=input('y: ');
    F(i,1)=y(i);
end

for k = 1:m
    l = m-k;
    for j=0:l
        F(j+1,k+1)=(F(j+2,k)-F(j+1,k))/(x(j+k+1)-x(j+1));
    end
end

disp('Tabel Difference');
disp('x        y          f(x,x)    ......');
for i=1:m+1
    fprintf('  %8.4f  ',x(i));
    for j=1:m+1
        fprintf('  %14.8f   ', F(i,j));
    end
    fprintf('\n');
end

lagi=1;
while(lagi==1)
    xk=input('masukan titik coba: ');
    yk=F(1,1);
    for k=2:m+1
        yp=1;
        for j=1:k-1
            yp=yp*(xk-x(j));
        end
        yk=yk+yp*F(1,k);
    end
    fprintf(' Hasil = %14.8f pada titik x=%8.4f\n',yk,xk);
    lagi=input('0 atau 1 ??');
end