y0 = [1; 0; 0.1; 0.2; 0.02];
tspan = [0 30];
[t, y] = ode45(@chemostat3, tspan, y0);

figure;
plot(t, y(:, 1), 'Color', '#1e90ff', 'LineWidth', 3)
hold on;
plot(t, y(:, 2), 'Color', 'r', 'LineWidth',3)
hold on;
plot(t, y(:, 3), 'Color', 'k', 'LineWidth', 3)
hold on;
plot(t, y(:, 4), 'Color', '#FF63E9', 'LineWidth',3)
hold on;
plot(t, y(:, 5), 'Color', '#7366BD', 'LineWidth',3)
hold off;

xlabel('Time');
ylabel('Concentration');
legend({'S','P','E','X_1','X_2'}, 'Location', 'east');
title('Chemostat Tragedy', 'FontWeight','normal');
set(gca, 'FontSize', 25);
grid on;