n=-7.9:.5:8.1;
y=sin(4*pi*n/8)./(4*pi*n/8);
subplot(221);
plot(y,'linewidth',2)

t=0.1:.1:8;
x=sin(2*pi*t/4);
subplot(222);
plot(x,'linewidth',2)

t=0.1:.1:8;
x_n=sin(2*pi*t/4)+0.5*randn*sin(2*pi*10*t/4)+0.2*randn*sin(2*pi*12*t/4);
subplot(223);
plot(x_n,'linewidth',2)

xy=conv(x_n,y);
subplot(224);
plot(xy,'linewidth',2)
