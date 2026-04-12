y0 = [0.9; 0.01];
tspan = [0 50];
[t, y] = ode45(@oscillating_initial4, tspan, y0);
c=parula(10);

figure;
plot(y(:, 1),y(:, 2),'Color', c(1,:), 'LineWidth', 3)
hold on;
y0 = [0.7;0.3];
tspan = [0 50];
[t, y] = ode45(@oscillating_initial4, tspan, y0);
plot(y(:, 1),y(:, 2),'Color', c(3,:), 'LineWidth', 3)
hold on;
y0 = [0.5;0.4];
tspan = [0 50];
[t, y] = ode45(@oscillating_initial4, tspan, y0);
plot(y(:, 1),y(:, 2),'Color', c(6,:), 'LineWidth', 3)
hold on;
plot(1/3,1/2, 'x','Color', 'k', 'LineWidth', 3)
hold off;

xlabel('Fraction of cooperators');
ylabel('Environment');
title('Oscillations of strategies and the environment', 'FontWeight','normal');
set(gca, 'FontSize', 25);
grid on;
xlim([0,1])