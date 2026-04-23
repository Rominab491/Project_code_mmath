n = 0:0.001:1;
x1 = (1-2*n)./(6*n-5);
x2 = zeros(size(n));
x3 = ones(size(n));

figure;
hold on;

plot(n(n<0.5), x2(n<0.5), '--r', 'LineWidth', 3); %x=0
plot(n(n>=0.5), x2(n>=0.5), '-b', 'LineWidth', 3);

plot(n(n<0.75), x3(n<0.75), '-b', 'LineWidth', 3); %x=1
plot(n(n>=0.75), x3(n>=0.75), '--r', 'LineWidth', 3);

x1(x1>1.1)=NaN;
x1(x1<-0.1)=NaN;

plot(n(n>=0.5 & n<=0.75), x1(n>=0.5 & n<=0.75), '--r', 'LineWidth', 3);

plot(0.5, 0,'x','Markersize', 20, 'Color', 'k', 'LineWidth', 3);
plot(0.75, 1,'x','Markersize', 20, 'Color', 'k', 'LineWidth', 3);

xlabel('n');
ylabel('x');
title('Bifurcation Stability', 'FontWeight', 'normal');
ylim([-0.05 1.05]);
set(gca, 'FontSize', 25);
legend('Unstable', 'Stable', 'Location', 'west');