clear; clc; close all;
L = 100;
N = L^2;
dt = 0.05;
epsilon = 0.5;
theta = 5;
Dn = 0.2;
K_fermi = 0.5;   
p_fermi = 0.3;  
T = 2000;
A1 = [1, 5; 0, 3]; %payoff matrix written defectors first way round
A0 = [0, 1; 2, 6]; 

strategy = double(rand(L, L)<0.4);  % 1 = Cooperator, 0 = Defector
environment_n = 0.5*ones(L, L);                 
neighbours = [0 1; 0 -1; 1 0; -1 0];          

coop_fraction = zeros(1, T);
time = 1:T;                     

fig = figure('Color', 'w', 'Position', [50 100 1200 500]);
colormap(parula);
video = VideoWriter('fermiweitz.mp4', 'MPEG-4');
video.FrameRate = 20;
open(video);

for t = 1:T
    TotalPayoffs = zeros(L, L);
    for i = 1:L
        for j = 1:L
            A = A0*(1-environment_n(i,j))+A1*environment_n(i,j); 
            payoff = 0;
            for m = 1:4
                ni = mod(i+neighbours(m,1)-1, L)+1;
                nj = mod(j+neighbours(m,2)-1, L)+1;
                payoff = payoff+A(strategy(i,j)+1, strategy(ni,nj)+1); %reindexing 0,1 to 1,2
            end
            TotalPayoffs(i,j) = payoff;
        end
    end
    for event = 1:N
        i = randi(L);
        j = randi(L);
        m = neighbours(randi(4), :);
        ni = mod(i+m(1)-1, L)+1;
        nj = mod(j+m(2)-1, L)+1;
        if rand < p_fermi
            prob = 1/(1+exp((TotalPayoffs(i,j)-TotalPayoffs(ni,nj))/K_fermi));  %fermi
            if rand < prob
                strategy(i,j) = strategy(ni,nj);
            end
        else
            local_n = (environment_n(i,j)+environment_n(ni,nj))/2; %weitz
            A = A0*(1-local_n)+A1*local_n;
            rate = max(0.01, A(strategy(i,j)+1, strategy(ni,nj)+1));
            if rand < (rate*dt/epsilon)
                rm = neighbours(randi(4), :);
                ri = mod(i+rm(1)-1, L)+1;
                rj = mod(j+rm(2)-1, L)+1;
                strategy(ri, rj) = strategy(i,j);
            end
        end
    end

    dn = environment_n.*(1-environment_n).*(theta*strategy-(1-strategy));
    n_envt = environment_n+dn*dt;
    laplacian = circshift(n_envt, [-1 0])+circshift(n_envt, [1 0])+circshift(n_envt, [0 -1])+circshift(n_envt, [0 1])-4*n_envt;
    environment_n = max(0, min(1, n_envt+Dn*dt*laplacian));

    coop_fraction(t) = mean(strategy(:));

    subplot(1, 2, 1);
    imagesc(environment_n, [0 1]);
    hold on;
    [row_coop, col_coop] = find(strategy == 1);
    plot(col_coop, row_coop, 'rs', 'MarkerFaceColor', 'r', 'MarkerSize', 4, 'LineStyle', 'none'); 
    hold off;
    title(['Spatial Clusters, Time: ', num2str(t)], 'FontWeight', 'normal');
    colorbar;
    axis square;
    set(gca, 'XTick', [], 'YTick', [], 'FontSize', 25);

    subplot(1, 2, 2);
    plot(time(1:t), coop_fraction(1:t), 'r', 'LineWidth', 3);
    xlim([0 T]);
    ylim([0 1]);
    xlabel('Time');
    ylabel('Fraction of Cooperators');
    set(gca, 'FontSize', 15);
    grid on;
    axis square;
    
    drawnow;
    writeVideo(video, getframe(fig));
end
close(video);
