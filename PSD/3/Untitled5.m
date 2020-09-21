%Tanggapan Frekuensi Dari Sistem Diskrit
zeta =0.7; %koef redaman
num =1 ;
den=[1, 2*zeta,1]; %system orde2
Ts = 0.5;
[nd,dd]=c2dm(num,den,Ts,'zoh');
point=512;
Fs=2*pi;
[H,q]=freqz(nd,dd,point,Fs);
g=ones(size(q))*0.707;
M=abs(H);
plot(q,M,'o',q,g,'--'),grid;