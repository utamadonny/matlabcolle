N = 30; % orde filter
% *** filter low pass ***
f1 = [0 0.3 0.3 1];
m1 = [1 1 0 0];
b1 = fir2(N,f1,m1);
[h1,w1] = freqz(b1,1,128);
subplot(211), plot(f1,m1,w1/pi,abs(h1)), grid;
title('karakteristik LPF');
xlabel('frekuensi ternormalisasi'),
ylabel('magnitude');
% *** filter high pass ***
f2 = [0 0.7 0.7 1];
m2 = [0 0 1 1];
b2 = fir2(N,f2,m2);
[h2,w2] = freqz(b2,1,128);
subplot(212), plot(f2,m2,w2/pi,abs(h2)), grid;
title('karakteristik HPF');
xlabel('frekuensi ternormalisasi'),
ylabel('magnitude');
