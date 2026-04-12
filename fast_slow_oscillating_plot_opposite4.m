y0 = [0.9; 0.9];
tspan = [0 600];
[t, y] = ode45(@fast_slow_oscillating_opposite4, tspan, y0);

figure;
plot(t, y(:, 1),'Color', '#1e90ff', 'LineWidth', 3)
hold on;
plot(t, y(:, 2), 'Color', '#B22222', 'LineWidth',3)
hold off;

xlabel('Time');
ylabel('System state');
legend({'Cooperator proportion','Environment'}, 'Location', 'northeast');
title('Oscillations Converge', 'FontWeight','normal');
set(gca, 'FontSize', 25);
grid on;