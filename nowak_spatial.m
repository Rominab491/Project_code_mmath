L = 50; 
b = 1.35;
grid = rand(L, L) > 0.5; % 1 = Cooperator, 0 = Defector

for gen = 1:100
    prev_grid = grid; 
    payoffs = zeros(L, L); % payoffs in von neumann neighbourhood
    for i = 1:L
        for j = 1:L
            neighbors = [mod(i-2,L)+1, j; mod(i,L)+1, j; i, mod(j-2,L)+1; i, mod(j,L)+1]; % i-1 or i+1 periodic boundaries coordinates in relation to focal playrt
            for k = 1:4
                ni = neighbors(k,1);
                nj = neighbors(k,2);
                if grid(i,j) == 1 && grid(ni,nj) == 1 %if focal coop and neighbour coop, payoff 1
                    payoffs(i,j) = payoffs(i,j)+1;
                elseif grid(i,j) == 0 && grid(ni,nj) == 1 %if focal defector and neighbour cooperator, payoff b
                    payoffs(i,j) = payoffs(i,j)+b;
                end
            end
        end
    end
    
    new_grid = grid;
    for i = 1:L
        for j = 1:L
            local_indices = [i, j; mod(i-2,L)+1, j; mod(i,L)+1, j; i, mod(j-2,L)+1; i, mod(j,L)+1]; %between focal and 4 neighbours
            [~, best_idx] = max(payoffs(sub2ind([L,L], local_indices(:,1), local_indices(:,2)))); %who has best payoff
            new_grid(i,j) = grid(local_indices(best_idx,1), local_indices(best_idx,2));
        end
    end

    outcome = zeros(L, L);
    outcome(~prev_grid & ~new_grid) = 1; %D->D
    outcome(prev_grid & new_grid)    = 2; %C->C
    outcome(~prev_grid & new_grid)   = 3; %D->C
    outcome(prev_grid & ~new_grid)   = 4; %C->D

    imagesc(outcome); 
    colormap(colororder({'r', 'b', 'g', 'y'}));
    clim([1 4]);
    title('Spatial Strategies, 100 Iterations', 'FontWeight', 'normal');
    set(gca, 'FontSize', 25, 'Xtick', [], 'Ytick', []);
    axis square;
    drawnow;
    grid = new_grid;
    pause(0.1);
end
