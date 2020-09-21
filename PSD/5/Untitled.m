%a.	Menentukan respon frekuensi H (e^j?)
w = [0:1:500]*pi/500;
H = exp(1i*w) ./ (exp(1i*w) - 0.9*ones(1,501));
magH = abs(H) ; angH = angle(H);
subplot (2,1,1);
plot (w/pi,magH), grid;
xlabel ('frequncy in pi units'), ylabel('|H|');
title('Magnitude Response');
subplot (2,1,2);
plot (w/pi,angH/pi), grid;
xlabel ('frequncy in pi units'), ylabel('Phase In Radians');
title ('Phase Response');
