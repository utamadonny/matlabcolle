A = [72 45; 7 2; 60 1; 80 400];
B = [1 10; 50 12; 70 50];
G = {'A';'B';'C'};

Md1= fitcknn(B,G,'NumNeighbors',1);
Class = predict(Md1,A)
