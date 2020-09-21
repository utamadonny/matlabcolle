%Inisialisasi data
Ka = 10;
Ta = 0.1;
Ke = 1;
Te = 0.4;
Kg = 1;
Tg = 1;
Kf = 1;
Tf = 0.01;
Kr = 1;
Tr = 0.05;

%Model Amplifier
num_A = [0 Ka];
den_A = [Ta 1];

%Model Exciter
num_E= [0 Ke];
den_E= [Te 1];

%Moodel Generator
num_G =[0 Kg];
den_G = [Tg 1];

%Model Stabilizer
num_F = [0 Kf];
den_F = [Tf 1];

%Model Sensor
num_R = [0 Kr];
den_R = [Tr 1];

%series Amplifier dan Exciter
[num1,den1]=series(num_A,den_A,num_E,den_E);
%closeloop dengan Stabilizer
[num2,den2]=feedback(num1,den1,num_F,den_F);
%series AES dengan Generator
[num3,den3]=series(num2,den2,num_G,den_G);
%%closeloop AEG dengan Sensor
[num4,den4]=feedback(num3,den3,num_R,den_R);
sys=tf(num4,den4)
step(sys)