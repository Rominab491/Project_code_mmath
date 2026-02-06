y0 = [1; 0; 0.1; 0.2; 0.01];
tspan = [0 50];
[t, y] = ode45(@strong_cooperation, tspan, y0);

figure;
plot(t, y(:, 1), 'Color', '#1e90ff', 'LineWidth', 3)
hold on;
plot(t, y(:, 2),'Color', 'r', 'LineWidth', 3)
hold on;
plot(t, y(:, 3),'Color', 'k', 'LineWidth', 3)
hold on;
plot(t, y(:, 4),'Color', '#FF63E9', 'LineWidth', 3)
hold on;
plot(t, y(:, 5),'Color', '#7366BD', 'LineWidth', 3)
hold off;

xlabel('Time');
ylabel('Concentration');
legend({'S', 'P', 'E', 'X_1', 'X_2'}, 'Location', 'east');
title('Strong cooperation in the chemostat', 'FontWeight','normal');
set(gca, 'FontSize', 25);
grid on;