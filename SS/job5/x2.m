L=input('Banyak titik sampel (>=20):');
f1=input('Besarnya frekuensi gel 1 adalah Hz):');
f2=input('Besarnya frekuensi gel 2 adalah Hz):');
teta1=input('Besarnya fase gel 1 (dalam radiant)):');
teta2=input('Besarnya fase gel 2 (dalam radiant)):');
A1=input('Besarnya amplitudo gel 1 :');
A2=input('Besarnya amplitudo gel 1 :');

t=1:L;
t=2*t/L;
y1=A1*sin(2*pi*f1*t+teta1*pi);
subplot(311)
stem(y1)

t=1:L;
t=2*t/L;
y2=A2*sin(2*pi*f2*t+teta2*pi);
subplot(312)
stem(y2)

subplot(313)
stem(conv(y1,y2))