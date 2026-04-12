function dydt = fast_slow_oscillating4(t, y)

theta = 2;
epsilon = 0.1;

x = y(1);
n = y(2);

dxdt = x*(1-x)*(1.25*x + 0.25 - n*(1.5*x+0.5));
dndt = epsilon*n*(1-n)*(-1+(1+theta)*x);

dydt = [dxdt; dndt];