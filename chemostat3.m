function dydt = chemostat3(t, y)

snought = 1;     
D = 1;
m = 5;
q = 0.8;
gamma = 1;
k = 20;
a = 0.05;

S = y(1);
P = y(2);
E = y(3);
X_1 = y(4);
X_2 = y(5);

G = k*E*S;
F = m*P/(a+P);

dSdt = D*(snought-S)-G;
dPdt = G-(1/gamma)*(X_1+X_2)*F-D*P;
dEdt = (1-q)*X_1*F-D*E;
dX_1dt = X_1*(q*F-D);
dX_2dt = X_2*(F-D);

dydt = [dSdt; dPdt; dEdt; dX_1dt; dX_2dt];