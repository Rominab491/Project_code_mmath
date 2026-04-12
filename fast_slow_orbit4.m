y0 = [0.3; 0.7];
tspan = [0 500];
[t, y] = ode45(@fast_slow_oscillating4, tspan, y0);

figure;
plot(y(:, 1),y(:, 2),'.','Markersize',20, 'Color', 'k', 'LineWidth', 3)
hold on;
plot(0.3,0.7, 'x','Markersize',20,'Color', 'r', 'LineWidth', 5)
hold off;

xlabel('Cooperator Proportion, x');
ylabel('Environment, n');
title('Fast-Slow Cycles', 'FontWeight','normal');
set(gca, 'FontSize', 25);
grid on;
xlim([0,1])