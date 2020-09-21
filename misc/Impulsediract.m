x = -1:0.1:1;
y = dirac(x);
idx = y == Inf; % find Inf
y(idx)=1
stem(x,y)