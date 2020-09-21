clc
clear
 
s = tf('s');
G = 16/(s-4)*(s+4);
figure
%subplot(311), impulse(G);   % Impulse reponse
%subplot(312), 
step(G);      % Step Response
%subplot(313), step(G / s);  % Ramp response

isstable(G)