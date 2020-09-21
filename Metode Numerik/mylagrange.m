x=input('masukan vektor sb-x:');
y=input('masukan vektor sb-y:');
xk=input('titik coba:');
n=length(x);
zmin=min(x);
zmax=max(x);
z=linspace(zmin, zmax, 20);
L=zeros(20,1);
P=zeros(n);
%masukan vektor sb-x:[0.1 0.3 0.5 0.7 0.9 1.1 1.3]
%masukan vektor sb-y:[0.003 0.067 0.148 0.248 0.370 0.518 0.697]
%titik coba:0.58

yk=0.0;
for i=1:n
    P(i)=1;
    for j=1:n
        if(i ~=j)
            P(i)=P(i)*(xk-x(j))/(x(i)-x(j));
        end
    end
    yk=yk+P(i)*y(i);
end

fprintf('Nilai yk = %10.8f pada xk = %10.8f\n',yk,xk);


for k=1:20
    for i=1:n
    P(i)=1;
    for j=1:n
        if(i ~=j)
            P(i)=P(i)*(z(k)-x(j))/(x(i)-x(j));
        end
    end
    L(k)=L(k)+P(i)*y(i);
    end
end
plot(x,y,'ro',z,L,'b',xk,yk,'ko');
title('Interpolasi Lagrange orde N');
xlabel('x');
ylabel('y');
grid on;
legend('titik tabel','kurva','titik coba','location','NorthEastOutside');