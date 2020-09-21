%%4 model redaman
clc
clear
t=0:0.05:4;
%redaman 0.2
a1=atan2(-sqrt(1-0.2^2),-0.2);
y1=(1./(sqrt(1-0.2^2))).*exp(-1.2.*t).*sin((6.*sqrt(1-0.2.^2).*t)+a1)+1;

%redaman 0.4
a2=atan2(-sqrt(1-0.4^2),-0.4);
y2=(1./(sqrt(1-0.4^2))).*exp(-2.4.*t).*sin((6.*sqrt(1-0.4.^2).*t)+a2)+1;

%redaman 0.8
a3=atan2(-sqrt(1-0.8^2),-0.8);
y3=(1./(sqrt(1-0.8^2))).*exp(-4.8.*t).*sin((6.*sqrt(1-0.8.^2).*t)+a3)+1;

%redaman 0.4
y4=1-(6.*t+1).*exp(-6.*t);
plot(t,y1,t,y2,t,y3,t,y4)

%% KNN Classify

A = [y1(11) y1(22) y1(33);y2(11) y2(22) y2(33);y3(11) y3(22) y3(33);y4(11) y4(22) y4(33)]; 
B = [1 1 1; 0.8 1 1; 1.1 1 1; 1.4 
Md1= fitcknn(B,G,'NumNeighbors',1);1 1];
G = {'Bagus';'Sedikit Teredam';'Sedikit osilasi'; 'Osilasi tinggi'};

Class = predict(Md1,A)