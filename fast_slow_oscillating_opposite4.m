function dydt = fast_slow_oscillating_opposite4(t, y)

theta = 2;
epsilon = 0.1;

x = y(1);
n = y(2);

dxdt = x*(1-x)*(0.55*x-2.55*n*x+0.95-1.95*n);
dndt = epsilon*n*(1-n)*(-1+(1+theta)*x);

dydt = [dxdt; dndt];