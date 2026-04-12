function dydt = oscillating_initial4(t, y)

T=5;     
R=3;
P=1;
S=0;
theta = 2;
epsilon = 0.1;

deltaps = P-S;
deltatr = T-R;

x = y(1);
n = y(2);

dxdt = (1/epsilon)*x*(1-x)*(deltaps + (deltatr-deltaps)*x)*(1-2*n);
dndt = n*(1-n)*(-1+(1+theta)*x);

dydt = [dxdt; dndt];