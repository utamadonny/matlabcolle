N = 11; % orde filter
[z,p,k] = buttap(N); % *** filter IIR ***
[num,den] = zp2tf(z,p,k);
wc = 5; % frek cut-off dalam rad/det
[n1,d1] = lp2lp(num,den,wc); % transformasi frekuensi
T = 0.1; % periode sampling (detik)
[nd,dd] = bilinear(n1,d1,1/T);
[H,omega] = freqz(nd,dd);
fase = 180/pi * unwrap(angle(H));
subplot(221), plot(omega,0.707,omega,abs(H)), grid;
title('respon frekuensi filter IIR');
xlabel('frekuensi (rad/sampel)'), ylabel('magnitude');
subplot(222), plot(omega,fase), grid;
xlabel('frekuensi '), ylabel('sudut fase (der)');

omegac = 0.5; % frekuensi cut-off digital = wc * T
m = (N-1)/2; % penggeseran
n = 0:2*m; % penetapan titik untuk plot
h = omegac/pi * sinc(omegac*(n-m)/pi);
w = [ones(1,N) zeros(1, length(n)-N)]; % window
hd = h .* w;
[Hd, omega1] = freqz(hd, 1);
phase = 180/pi * unwrap(angle(Hd));
subplot(223), plot(omega1,0.707,omega1,abs(Hd)), grid;
title('respon frekuensi filter FIR');
xlabel('frekuensi (rad/sampel)'), ylabel('magnitude');
subplot(224), plot(omega1,phase), grid;
xlabel('frekuensi '), ylabel('sudut fase (der)');
