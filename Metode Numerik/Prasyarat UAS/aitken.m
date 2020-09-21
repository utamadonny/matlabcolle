function [I q] =aitken(Ih,I2h,I4h)
q=(I2h-I4h)/(Ih-I2h);
I=Ih+((Ih-I2h)/(q-1));
end
