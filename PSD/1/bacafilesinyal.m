% menulis file sinyal
n=0:199;
T=0.005;
x=sin(2*pi*10*n*T)+sin(2*pi*40*n*T);\
fid=fopen('sinyal1.txt','w');
fprintf(fid,'%8.4f\n',x);
fclose(fid);

% membaca file sinyal
%fid=fopen('sinyal1.txt');
%y=fscanf(fid,'%f\n');
%fclose(fid);
%N=length (y);
%n=0:N-1; T=0.005;
%stem(n*T,y,'k'),grid;