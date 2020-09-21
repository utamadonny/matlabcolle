clc
clear

disp('Masukan Fungsi :')
s=input(' ', 's');
f=inline(s, 'x');
a=input('batas kiri :');
b=input('batas kanan :');
OK = true;
while (OK==true);
    N=input('masukan derajat N(1<N<7) :');
if(N>1 && N<7)
    OK=false;
else
    disp('masukan nilai N lagi:')
end
end

Tabel2=zeros(2,2);
Tabel3=zeros(3,2);
Tabel4=zeros(4,2);
Tabel5=zeros(5,2);
Tabel6=zeros(6,2);

Tabel2=[0.5773502692 1.00000; -0.5773502692 1.00000];
Tabel3=[0.7745966692 0.5555555556; 0.000 0.8888888889; -0.7745966692 0.5555555556];
Tabel4=[0.8611363116 0.3478548451; 0.3399810436 0.6521451549; -0.8611363116 0.3478548451; -0.3399810436 0.6521451549];
Tabel5=[0.9061798459 0.2369268851; 0.5384693101 0.4786286705; 0.000 0.5688888889; -0.9061798459 0.2369268851; -0.5384693101 0.4786286705];
Tabel6=[0.9324695142 0.1713244924; 0.6612093864 0.3607615730; 0.2386191861 0.4679139345; -0.9324695142 0.1713244924; -0.6612093864 0.3607615730; -0.2386191861 0.4679139345];

T=zeros(N,2);
if (N==2)
    T=Tabel2;
else if(N==3)
        T=Tabel3;
    else if(N==4)
            T=Tabel4;
        else if(N==5)
                T=Tabel5;
            else if(N==6)
                    T=Tabel6;
                end
            end
        end
    end
end

t=zeros(N,1);
x=zeros(N,1);
c=zeros(N,1);
for i=1:N
    t(i)=T(i,1);
    c(i)=T(i,2);
end
I=0;
for i=1:N
    x(i)=(b-a)*t(i)/2+(a+b)/2;
    I=I+c(i)*f(x(i));
end
I=(b-a)*I/2;
fprintf('Hasil Integral= %12.8f\n',I);
