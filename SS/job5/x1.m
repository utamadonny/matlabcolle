L=input('Panjang gelombang (>10):');
P=input('Lebar pulsa(lebih kecil dari L):');
for n=1:L
    if n<=P
        x(n)=1;
    else
        x(n)=0;
    end
end

t=1:L;
subplot(311)
stem(t,x)

for n=1:L
    if n<=P
        v(n)=1;
    else
        v(n)=0;
    end
end

t=1:L;
subplot(312)
stem(t,v)

subplot(313)
stem(conv(x,v))
