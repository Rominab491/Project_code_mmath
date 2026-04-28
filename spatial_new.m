clear; clc; close all;
L = 60;
N = L^2;
repeats = 10;
T_max = 2000;
dt = 0.05;
epsilon = 0.5;
theta = 2;
Dn = 1;
A1 = [3,0;5,1];
delta = 0.01;

grid_coords = -2:0.1:2; 
grid_length = length(grid_coords);
final_image = NaN(grid_length, grid_length); 

v = VideoWriter('weitz_frac_averted.mp4', 'MPEG-4');
v.FrameRate = 15;
open(v);
figure('Color', 'w', 'Position', [100, 100, 700, 600]);

for row = 1:grid_length 
    for col = 1:grid_length 
        R0T0 = grid_coords(row);
        S0P0 = grid_coords(col);
        if R0T0>0 && S0P0>0
            T0=1; P0=1;
        elseif R0T0>0 && S0P0<=0
            T0=5; P0=6;
        elseif R0T0<=0 && S0P0<=0
            T0=6; P0=6;
        else
            T0=6; P0=1;
        end
        A0 = [T0+R0T0, P0+S0P0; T0, P0];
        
        averted_count = 0;
        for rep = 1:repeats
            x = rand(L,L)<0.3; 
            n = 0.7*ones(L,L);
            env_hist = zeros(T_max,1);
            
            for t = 1:T_max
                focal_index = randi(N,N,1);
                [row_focal, col_focal] = ind2sub([L,L], focal_index);

                ro = randi(4,N,1); %von neumann called ro for random opponent
                opponent_index = focal_index; 
                up=ro==1;
                opponent_index(up)=sub2ind([L,L], mod(row_focal(up)-2,L)+1, col_focal(up));
                down=ro==2;
                opponent_index(down)=sub2ind([L,L], mod(row_focal(down),L)+1, col_focal(down));
                left=ro==3;
                opponent_index(left)=sub2ind([L,L], row_focal(left), mod(col_focal(left)-2,L)+1);
                right=ro==4;
                opponent_index(right)=sub2ind([L,L], row_focal(right), mod(col_focal(right),L)+1);
                
                avg_env = (n(focal_index)+n(opponent_index))/2; 
                An_R = A0(1,1)*(1-avg_env)+A1(1,1)*avg_env;
                An_S = A0(1,2)*(1-avg_env)+A1(1,2)*avg_env;
                An_T = A0(2,1)*(1-avg_env)+A1(2,1)*avg_env;
                An_P = A0(2,2)*(1-avg_env)+A1(2,2)*avg_env;
                
                payoff = zeros(N,1);
                coop_coop = x(focal_index) & x(opponent_index);
                payoff(coop_coop) = An_R(coop_coop);
                coop_def = x(focal_index) & ~x(opponent_index);%focal coop, opponent not coop
                payoff(coop_def) = An_S(coop_def);
                def_coop = ~x(focal_index) & x(opponent_index);
                payoff(def_coop) = An_T(def_coop);
                def_def = ~x(focal_index) & ~x(opponent_index);
                payoff(def_def) = An_P(def_def);
                
                repro = rand(N,1)<(payoff*dt/epsilon); %replace neighbour
                if any(repro) 
                   focal_repro = focal_index(repro);
                   [row_focal_repro, col_focal_repro] = ind2sub([L, L], focal_repro);
                   rr = randi(4,sum(repro),1); %random replacement called rr for short
                   birth_death_replace_index = focal_repro; 
                   up=rr==1;
                   birth_death_replace_index(up)=sub2ind([L,L], mod(row_focal_repro(up)-2,L)+1, col_focal_repro(up));
                   down=rr==2;
                   birth_death_replace_index(down)=sub2ind([L,L], mod(row_focal_repro(down),L)+1, col_focal_repro(down));
                   left=rr==3;
                   birth_death_replace_index(left)=sub2ind([L,L], row_focal_repro(left), mod(col_focal_repro(left)-2,L)+1);
                   right=rr==4;
                   birth_death_replace_index(right)=sub2ind([L,L], row_focal_repro(right), mod(col_focal_repro(right),L)+1);
                   
                   x(birth_death_replace_index) = x(focal_repro); 
                end
                
                laplacian = (circshift(n,[1,0])+circshift(n,[-1,0])+circshift(n,[0,1])+circshift(n,[0,-1])-4*n);
                n = n + dt*n.*(1-n).*(theta*double(x)-double(~x)) + (Dn*dt)*laplacian;
                n = max(0,min(1, n));
                
                env_hist(t) = mean(n(:));
                if mean(x(:)) == 0
                    break;
                end
            end
            
            last20percent = round(0.8*T_max); %mean of last 20% of values
            if mean(env_hist(last20percent:end))>delta
                averted_count = averted_count+1;
            end
        end
        
        final_image(row,col) = averted_count/repeats;
        
        imagesc(grid_coords, grid_coords, final_image);
        set(gca, 'YDir', 'normal', 'FontSize', 25);
        colormap(parula);
        colorbar;
        clim([0 1]);
        xlabel('S_0 - P_0');
        ylabel('R_0 - T_0');
        title('Fraction Averted', 'FontWeight', 'normal'); 
        axis square;
        drawnow;
        writeVideo(v, getframe(gcf));
    end
end
close(v);