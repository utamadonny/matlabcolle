%Menampilkan Sinyal step
n=0:50;
undak=ones(1,51);
plot(n,undak,'ko'), grid;
xlabel('waktu'), ylabel('amplitudo');
axis([-5 55 -0.5 1.5]);
