syms s
Gs=80/(s^2*(1000*s+40));
x=logspace(-2,2);
xv=x';
GsF=vpa(subs(Gs,s,x*1i),3);
GsFAbs=abs(GsF);
GsFMag=20*log10(GsFAbs);
figure(1);
subplot(2,1,1);
semilogx(x,GsFMag);xlabel('Frequency(rad/sec)');ylabel('Magnitude(dB)');title("Frequency response for "+string(Gs))
set(gca,'XLim',[0 max(x)]);
subplot(2,1,2);
GsFPh=angle(GsF)*180/pi;
semilogx(x,GsFPh);xlabel('Frequency(rad/sec)');ylabel('Phase(deg)');
set(gca,'XLim',[0 max(x)]);

%% ANN
%Define and plot training as well as checking data
data=[x GsFMag];
trndata=data(1:1:size(max(x)),:);
chkdata=data(2:1:size(max(x)),:);
grid

figure(2);
subplot(311);
plot(trndata(:,1),trndata(:,2),"o",chkdata(:,1),chkdata(:,2),"x");
xlabel("time in seconds");ylabel("speed in m/s");
legend("Train Data", "Check Data")
%initialize ANN
trainpoint=trndata(:,1)';
trainoutput=trndata(:,2)';
net=newff(minmax(trainpoint),[10 1],{'tansig' 'purelin'});
%Simulate and plot the network ouput without training
Y=sim(net,trainpoint);
grid

subplot(312);
plot(trainpoint,trainoutput,trainpoint,Y,"o");
%Initialize parameter
net.trainParam.epochs=100;
net.trainParam.goal=0.0001;
%Train the network and plot the output
net=train(net,trainpoint,trainoutput);
Y=sim(net,trainpoint);
xlabel("time in seconds");ylabel("speed in m/s");
legend("Original Response", "Neural Without Training")

subplot(313);
plot(trainpoint,trainoutput,trainpoint,Y,"o");
xlabel("time in seconds");ylabel("speed in m/s");
legend("Original Response", "Trained Neural")

%test the network and plot the error
checkpoint=chkdata(:,1)';
checkoutput=chkdata(:,2)';
W=sim(net,checkpoint);
e=W-checkoutput;
grid
figure(3);
bar(e);