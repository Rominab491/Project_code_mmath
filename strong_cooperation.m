function dydt = strong_cooperation(t, y)

snought = 1;     
D = 1;
m_1 = 3;
m_2 = 6;
q = 0.8;
gamma_1 = 1;
gamma_2 = 1;
k = 20;
a_1 = 0.2;
a_2 = 0.05;
eta = 1;

S = y(1);
P = y(2);
E = y(3);
X_1 = y(4);
X_2 = y(5);

G = k*S;
F_1 = m_1*P/(a_1+P);
F_2 = m_2*P/(a_2+P);

dSdt = D*(snought-S)-E*G;
dPdt = E*G-(1/gamma_1)*(X_1)*F_1-(1/gamma_2)*X_2*F_2-D*P;
dEdt = eta*(1-q)*X_1*F_1-D*E;
dX_1dt = X_1*(q*F_1-D);
dX_2dt = X_2*(F_2-D);

dydt = [dSdt; dPdt; dEdt; dX_1dt; dX_2dt];