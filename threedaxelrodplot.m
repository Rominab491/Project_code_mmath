A = [3,0.1,3;5,1,2.2;3,0.73,3];
t_span = [0,30];
x0 = [0.4,0.1,0.5];

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
legend({'ALLC', 'ALLD', 'GTFT'}, 'Location', 'best');
set(gca, 'FontSize',25);
grid on;