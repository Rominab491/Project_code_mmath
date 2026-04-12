n = 0:0.01:1;


x1 = (1-2*n) ./ (6*n-5);
x2 = zeros(length(n));
x3 = ones(length(n));
x1(abs(6*n - 5) < 1e-3) = NaN;
x1(x1>2)=NaN;
x1(x1<-2)=NaN;

figure;
plot(n, x1, 'r', 'LineWidth', 3); hold on
plot(n, x2, 'r', 'LineWidth', 3); hold on
plot(n, x3, 'r', 'LineWidth', 3); hold on
plot(0.5, 0,'x','Markersize', 20, 'Color', 'k', 'LineWidth', 3); hold on
plot(0.75, 1,'x','Markersize', 20, 'Color', 'k', 'LineWidth', 3); hold off
xlabel('n');
ylabel('x');
title('Bifurcation Plot','FontWeight','normal');
set(gca, 'FontSize', 25);
grid on
set(gca, 'YLim', [-0.05 1.05])