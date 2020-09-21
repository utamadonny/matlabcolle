syms y(t) u(t) t 
Dy = diff(y);
D2y = diff(y,2);
DEq = D2y + 0.15*Dy + 0.005*y == 0.1*u;
[SS,Sbs] = odeToVectorField(DEq)

    

