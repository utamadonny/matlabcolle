clc
clear
u=heaviside(t);
function f=heaviside(t)
f=(t>=0);
end
ezplot(u,[-2:,01:5]