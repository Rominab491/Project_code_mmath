A = [30,1,30;50,10,14;29.2,7.3,29.2];
t_span = [0,20];
x0 = [0.15,0.5,0.35];

[t, x] = ode45(@(t, x) replicator_dynamic(t, x, A), t_span, x0);

figure;
plot(t, x(:, 1), 'Color', '#1e90ff', 'LineWidth', 3)
hold on;
plot(t, x(:, 2), 'r', 'LineWidth',3)
hold on;
plot(t, x(:, 3), 'k', 'LineWidth',3)
hold off;

xlabel('Time');
ylabel('Population Frequency');
title('Replicator Dynamics','FontWeight','normal');
legend({'ALLC', 'ALLD', 'TFT'}, 'Location', 'best');
set(gca, 'FontSize',25);
grid on;