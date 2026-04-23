y0 = [1, 0.1, 0.1, 0.5, 0.2];
tspan = [0 30];
[t, y] = ode45(@gillespie_function, tspan, y0);

nu = 1000;   % volume scale factor for particle number
N = round(y0*nu);
T_max = 30;
tt = 0;
iter = 0;
hist_t = tt; 
hist_N = N;

D = 1;
S0 = 1;
k = 20;
m = 5;
a = 0.05;
q = 0.8;
gamma = 1;

while tt < T_max && (N(4)+N(5)) > 0 % code runs until end time or there are still either cooperators or defectors in the population.
    P = N(2)/nu;
    F = m*P/(a+P);
    G=k*N(1)*N(3);
    
    alpha = zeros(1, 10);
    alpha(1) = D*S0*nu;
    alpha(2) = G/nu;
    alpha(3) = q*F*N(4);
    alpha(4) = (1-q)*F*N(4);
    alpha(5) = F*N(5);
    alpha(6:10) = D*N(1:5);
    
    a0 = sum(alpha);
    if a0 <= 0
        break;
    end
    
    tt = tt+(-log(rand())/a0);
    outcome = find(cumsum(alpha)>=rand()*a0, 1);

    if outcome == 1
        N(1) = N(1)+1;
    elseif outcome == 2
        N(1) = max(0, N(1) - 1); 
        N(2) = N(2)+1;
    elseif outcome == 3
        if N(2)>0
            N(2) = N(2)-1; 
            N(4) = N(4)+1; 
        end
    elseif outcome == 4
        if N(2)>0
            N(2) = N(2)-1; 
            N(3) = N(3)+1; 
        end
    elseif outcome == 5
        if N(2)>0
            N(2) = N(2)-1; 
            N(5) = N(5)+1; 
        end
    else
        idx = outcome-5; %outcomes 6 through 10
        N(idx) = max(0, N(idx)-1);
    end
    
    iter = iter+1;
    if mod(iter, 100) == 0   % Save data point every 100 events for memory
        hist_t(end+1) = tt;
        hist_N(end+1, :) = N;
    end
end

figure;
hold on
plot(t, y(:, 4)*nu, 'k--', 'LineWidth', 3)
plot(t, y(:, 5)*nu, 'r--', 'LineWidth', 3)

s1 = stairs(hist_t, hist_N(:,4), 'Color', 'b', 'LineWidth', 3); %stairs for stochastic plot
s2 = stairs(hist_t, hist_N(:,5), 'Color', 'm', 'LineWidth', 3);

xlabel('Time');
ylabel('Population Size');
title('Tragedy of the Commons', 'FontWeight','normal');
legend('X_1 ODE', 'X_2 ODE', 'X_1 Stochastic', 'X_2 Stochastic', 'Location', 'northeast');
set(gca, 'FontSize', 25);
grid on;