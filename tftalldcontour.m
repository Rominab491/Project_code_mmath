R = 3;
T = 5;
P = 1;
S = 0;
n = 10;
N_vals = 3:1000;
w_vals = linspace(0, 1, 100);

a = n*R;
b = S+(n-1)*P;
c = T+(n-1)*P;
d = n*P;

results = zeros(length(N_vals), length(w_vals));
for j = 1:length(N_vals)
    N = round(N_vals(j));
    for k = 1:length(w_vals)
        w = w_vals(k);
        if w == 0
            results(j,k) = 1;
            continue;
        end
        i = 1:(N-1);
        F_i = (a*(i-1)+b*(N-i))/(N-1);
        G_i = (c*i+d*(N-i-1))/(N-1);
        f_i = 1-w+w*F_i;
        g_i = 1-w+w*G_i;
        cumulative_logprod = cumsum(log(g_i./f_i));
        results(j,k) = N*(1/(1+sum(exp(cumulative_logprod))));
    end
end

figure;
[wfig, Nfig] = meshgrid(w_vals, N_vals);
contourf(wfig, Nfig, results, 50, 'LineColor', 'none');
colorbar;
xlabel('Selection intensity, w');
ylabel('Population size, N');
title('Rate of Evolution, N\rho_{TFT}','FontWeight','normal');
set(gca, 'FontSize', 25);
grid on;