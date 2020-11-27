T = 0.5; %Time Constant
N = 3.; 
wz = 5.; %Zero Frequency
wm = 20.; %Natural Frequency
damp = 0.7; %Damping
beta = sqrt(1.-damp^2);
B = (T^2-wz^(-2))/(2.*damp/wm -T- 1./(T*wm^2));
C = -1./wm^2 -B/T/wm^2;
D = -2.*damp/wm + C*T*wm^2 ;
wt = 3.5;
Tt = 0.15;
wzt = 15.;
dampt = 0.8;
for q = 1:150
    w(q,1) = q/10;
    ac1(q,1) = 0;
    ac2(q,1) = 0;
    ac3(q,1) = 0;
    ac4(q,1) = 0;
    G(q,1) = 0;
    GT(q,1)= 0;
    y (q,1) = 0;
end
for i = 1:150
    ac1(i,1) = w(i,1).^(N-2);
    ac2(i,1) = (w(i,1).^2.+ (1./T)^2).^(N*B/(T*2));
    ac3(i,1) = ((wm.^2- w(i,1).^2).^2 + 4.*(damp^2)...
        .*(w(i,1).^2)*wm.^2).^(C*N/4*wm^2);
    G(i,1) = atan((w(i,1)- wm*sqrt(1-damp^2))./wm/damp)-atan((w(i,1)+...
          wm*sqrt(1-damp^2))./wm/damp);
    ac4(i,1) = exp(N*wm*(D-C*damp*wm)./(2.*sqrt(1.-damp^2)).*G(i,1));
%     GT(i,1) = (1.-(w(i,1)./wzt).^2)./sqrt((1.+Tt^2)*((1.- ...
%         (w(i,1)./wt).^2.)^2+4*((w(i,1)./wt).^2).*dampt^2));
    GT(i,1) = 1.;
    y(i,1) = 9.81*ac1(i,1).*ac2(i,1).*ac3(i,1).*ac4(i,1).*GT(i,1);
end

plot(w,y);grid; xlabel('Frequency (rad/s)'); ylabel('Steady-state miss amplitude (m)');