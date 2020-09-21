% Menampilkan sinyal Unit Step Tertunda
n=0:50;
tunda=20;
k=length(n) - tunda;
z=zeros(1,tunda);
x=[z, ones(1,k)];
plot(n,x,'ko'), grid;
xlabel('waktu'), ylabel('amplitudo');
axis([-5 55 -0.5 1.5]);