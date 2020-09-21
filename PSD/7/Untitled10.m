n = 0:200;
T = 0.2; % periode sampling
x1 = cos(n*T);
x2 = cos(5*n*T);
x = x1 + x2;
subplot(221), plot(n*T,x1), grid;
title('sinyal x1');
xlabel('waktu'), ylabel('simpangan');
subplot(222), plot(n*T,x2), grid;
title('sinyal x2');
xlabel('waktu'), ylabel('simpangan');
subplot(223), plot(n*T,x), grid;
title('sinyal x1 + x2');
xlabel('waktu'), ylabel('simpangan');
N = 30; % orde filter
% *** Low Pass Filter FIR ****
f1 = [0 0.2 0.2 1];
m1 = [1 1 0 0];
b1 = fir2(N,f1,m1);
y1 = filter(b1,1,x); % sinyal keluaran
subplot(224), plot(n*T,y1), grid;
title('sinyal hasil LPF FIR');
xlabel('waktu'), ylabel('simpangan');
