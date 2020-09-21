% Menampilkan sinyal Unit Impulse
n=0:50;
impuls=[1, zeros(1,50)];
plot(n,impuls,'k*'), grid;
xlabel('waktu'), ylabel('amplitudo');
axis([-5 55 -0.5 1.5]);
