clear
clc



N=input('Berapa pasangan data:');
T=zeros(N,N+1);

for i=1:N
    fprintf('Data ke-%3d\n',i);
    x(i)=input('x: ');
    y(i)=input('y: ');
    T(i,1)=x(i);
    T(i,2)=y(i);
end

for kol = 3:N+1
    br = (N+2-kol);
    for brs=1:br
        T(brs,kol)=T(brs+1,kol-1)-T(brs,kol-1);
    end
end
disp('    x        y          delta1          delta2    ......');
for i=1:N
    for j=1:N+1
        fprintf('  %10.7f   ', T(i,j));
    end
    fprintf('\n');
end

lagi=1;
while(lagi==1)
    h=x(2)-x(1);
    xk=input('masukkan titik interpolasi:');
    t=(xk-x(1))/h;
    yk=T(N,2)+ t*T(N-1,3);
    for i=2:N-1
        fak=i;
        t1=1;
        for j=1:(i-1)
            t1=t1*(t-j);
            fak=fak*j;
        end
        t1=t*t1;
        yk = yk + t1*T(N-i,i+2)/fak;
    end
    fprintf(' Hasil = %14.8f pada titik x=%8.4f\n',yk,xk);
     lagi=input('0 atau 1 ??');
end
