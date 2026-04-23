R = 3;
T = 5;
P = 1;
S = 0;
n = 10;                     
N_vals = [3, 10, 100, 1000];
w_vals = linspace(0, 1, 100);

a = n*R;
b = S+(n-1)*P;
c = T+(n-1)*P;
d = n*P;

results = zeros(length(N_vals), length(w_vals));
for j = 1:length(N_vals)
    N = N_vals(j);
    for k = 1:length(w_vals)
        w = w_vals(k);
        if w == 0                        %(not dividing log by 0)
            results(j,k) = 1; 
            continue;
        end
        cumulative_sum = 0;
        cumulative_logprod = 0;
        for i = 1:N-1
            F_i = (a*(i-1)+b*(N-i))/(N-1);
            G_i = (c*i+d*(N-i-1))/(N-1);
            f_i = 1-w+w*F_i;
            g_i = 1-w+w*G_i;
            cumulative_logprod = cumulative_logprod+log(g_i/f_i);
            cumulative_sum = cumulative_sum+exp(cumulative_logprod);
        end
        results(j,k) = N/(1+cumulative_sum);
    end
end

figure;
hold on
plot(w_vals, results(1,:), 'Color', 'r', 'LineWidth', 3);
plot(w_vals, results(2,:), 'Color', '#1e90ff', 'LineWidth', 3);
plot(w_vals, results(3,:), 'Color', '#7366BD', 'LineWidth', 3);
plot(w_vals, results(4,:), 'Color', '#FF63E9', 'LineWidth', 3);
yline(1, '--k', 'LineWidth', 3);

xlabel('Selection intensity, w');
ylabel('Rate of evolution, N\rho_{TFT}');
legend({'N=3', 'N=10', 'N=100','N=1000'}, 'Location', 'east');
set(gca, 'FontSize', 25);
grid on;
ylim([0,5]);