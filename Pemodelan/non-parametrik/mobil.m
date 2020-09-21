clear;
% Define and plot time vs velocity for the model
t=[0:.5:30]';
v=2*t-50+50*exp(-0.04*t);
grid
figure(1);
plot(t,v);
xlabel("time in seconds");ylabel("speed in m/s");

%Define and plot training as well as checking data
data=[t v];
trndata=data(1:2:size(t),:);
chkdata=data(2:2:size(t),:);
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