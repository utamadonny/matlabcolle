t=-3:6/1000:3;
N=input('Jumlah sinyal : ');
c0=0.5;
w0=pi;
xN=c0*ones(1,length(t));
for n=1:2:N
    theta=((-1)^((n-1)/2)-1)*pi/2;
    xN = xN + 2/n/pi*cos(n*w0*t+theta);
end
plot(t,xN)
xlabel('waktu')
ylabel('x(t)')