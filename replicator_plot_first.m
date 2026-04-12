A = [3,0;5,1];   % A = [R,S;T P] T>R>P>S (prisoners dilemma condition)
t_span = [0,20];
x0 = [0.9,0.1]; % 0.9 cooperators, 0.1 defectors initially

[t, x] = ode45(@(t, x) replicator_dynamic(t, x, A), t_span, x0);

figure;
plot(t, x(:, 1), 'b', 'LineWidth', 3); % cooperate (want column 1 for cooperation frequency)
hold on;
plot(t, x(:, 2), 'r', 'LineWidth',3); % defect (want column 2 for defection frequency)
hold off;

xlabel('Time');
ylabel('Relative Frequency');
title('Replicator Dynamics','FontWeight','normal');
legend({'Cooperate', 'Defect'}, 'Location', 'best', 'FontSize', 25);
set(gca, 'FontSize',35);
grid on;