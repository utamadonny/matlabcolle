%Program P2_2
%Ilustrasi efek aliasing dalam domain
clf;
T=0.1;
t=0:0.0005:1;
f=13;
n=(0:T:1)';
xs=cos(2*pi*f*n);
t= linspace(-0.5,1.5,500)';
ya=sinc((1/T)*t(:,ones(size(n)))-(1/T)*n(:,ones(size(t)))')*xs;
plot(n,xs,'o',t,ya);grid;
xlabel('time msec'); ylabel('Amplitudo');
title('Reconstructed time signal y_{a}{t}');
axis([0 1 -1.2 1.2])