y0 = [0.9; 0.9];
tspan = [0 200];
[t, y] = ode45(@fast_slow_oscillating_opposite4, tspan, y0);

figure;
plot(y(:, 1),y(:, 2),'Color', 'k', 'LineWidth', 3)
hold on;
plot(0.9,0.9, 'x','Markersize', 20,'Color', 'r', 'LineWidth', 5)
hold off;

xlabel('Fraction of cooperators, x');
ylabel('Environment, n');
%legend({'Fraction of cooperators','Environment'}, 'Location', 'east');
title('Fast-Slow Cycles', 'FontWeight','normal');
set(gca, 'FontSize', 25);
grid on;
xlim([0,1])