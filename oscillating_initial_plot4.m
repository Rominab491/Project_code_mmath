y0 = [0.8; 0.15];
tspan = [0 50];
[t, y] = ode45(@oscillating_initial4, tspan, y0);

figure;
plot(t, y(:, 1),'Color', '#1e90ff', 'LineWidth', 3)
hold on;
plot(t, y(:, 2), 'Color', '#B22222', 'LineWidth',3)
hold off;

xlabel('Time');
ylabel('System state');
legend({'Fraction of cooperators','Environment'}, 'Location', 'east');
title('Oscillations of strategies and the environment', 'FontWeight','normal');
set(gca, 'FontSize', 25);
grid on;