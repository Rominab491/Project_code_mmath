function dydt = gillespie_function(t, y)

D = 1;
S0 = 1;
k = 20;
m = 5;
a = 0.05;
q = 0.8;
gamma = 1;

S = y(1);
P = y(2);
E = y(3);
X_1 = y(4);
X_2 = y(5);

G = k*S*E;
F = m*P/(a+P);

dSdt = D*(S0-S)-G;
dPdt = G-(1/gamma)*(X_1+X_2)*F-D*P;
dEdt = (1-q)*X_1*F-D*E;
dX_1dt = X_1*(q*F-D);
dX_2dt = X_2*(F-D);

dydt = [dSdt; dPdt; dEdt; dX_1dt; dX_2dt];