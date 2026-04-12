A = [2,5;4,3];   % A = [R,S;T P] T>R>P>S (prisoners dilemma condition)
t_span = [0,20];
x0 = [0.3,0.7]; % 0.9 cooperators, 0.1 defectors initially

[t, x] = ode45(@(t, x) replicator_dynamic(t, x, A), t_span, x0);

figure;
plot(t, x(:, 1), 'b', 'LineWidth', 3); % cooperate (want column 1 for cooperation frequency)
hold on;
plot(t, x(:, 2), 'r', 'LineWidth', 3); % defect (want column 2 for defection frequency)
hold off;

xlabel('Time');
ylabel('x_i');
title('Replicator Dynamics','FontWeight','normal');
legend({'x_1', 'x_2'}, 'Location', 'northeast', 'FontSize',25);
set(gca, 'FontSize',25);
grid on;