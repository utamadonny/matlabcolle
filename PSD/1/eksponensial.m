% Menampilkan Sinyal Eksponensial
n=0:50;
eks1=(1.2).^n;
subplot(221)
stem(n,eks1,'k'), grid;
xlabel('a>1');
axis([-5 55 -0.5 15]);

n=0:50;
eks1=(0.96).^n;
subplot(222)
stem(n,eks1,'k'), grid;
xlabel('0<a<1');
axis([-5 55 -0.5 1.5]);

n=0:50;
eks1=(-0.96).^n;
subplot(223)
stem(n,eks1,'k'), grid;
xlabel('-1<a<0');
axis([-5 55 -1.3 1.3]);

n=0:50;
eks1=(-1.2).^n;
subplot(224)
stem(n,eks1,'k'), grid;
xlabel('a<-1');
axis([-5 55 -15 15]);