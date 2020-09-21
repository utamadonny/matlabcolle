clear all
N=200;
nn=N-1;
for k = 1:200
   x_n=0.0;
   for n=1:nn
       x_n=(3*cos(0.02*pi*n)).*(exp(-j*k*2*pi*n/200))+x_n;
   end
   yR(k)=real(x_n);
   yI(k)=imag(x_n);
   magni_k(k)=sqrt(real(x_n).*real(x_n)+imag(x_n).*imag(x_n));
end
subplot(211);
stem(yR)
axis([0 200 0 800])
xlabel('indeks frekuensi')
title('Bagian Real')
grid;
subplot(212);
stem(yI)
axis([0 200 0 800])
xlabel('indeks frekuensi')
title('Bagian Imajiner')
grid;