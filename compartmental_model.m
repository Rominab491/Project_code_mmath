clear; clc; close all;
N = 40;
T = 300;
dt = 0.01;
Number_timesteps = T/dt;
x_i = 1:N;

phop = 0.1;
ehop = 0.02;
x1hop = 0.001;   %hopping rate
x2hop = 0.05;
D = 0.08;        %modified from paper
q = 0.8;
k = 20;
m = 5;
a = 0.05;

s = ones(1, N);
p = zeros(1, N);
e = zeros(1, N);
x1 = zeros(1, N); 
x2 = ones(1, N)*0.05;

x1(8:12) = 1;    %giving cooperators much higher conc than defectors in certain compartments
x1(18:21) = 1;
x1(23:25) = 1;
x1(28:37) = 1;

results = zeros(Number_timesteps/100, N);  

for t = 1:Number_timesteps
    plap = [p(2)-p(1), p(1:N-2)+p(3:N)-2*p(2:N-1), p(N-1)-p(N)];
    elap = [e(2)-e(1), e(1:N-2)+e(3:N)-2*e(2:N-1), e(N-1)-e(N)];
    x1lap = [x1(2)-x1(1), x1(1:N-2)+x1(3:N)-2*x1(2:N-1), x1(N-1)-x1(N)]; %no flux laplacian
    x2lap = [x2(2)-x2(1), x2(1:N-2)+x2(3:N)-2*x2(2:N-1), x2(N-1)-x2(N)];
    
    G = k*e.*s;
    F = (m*p)./(a+p); 
    
    dp  = G-(x1+x2).*F-D*p+phop*plap;
    de  = ((1-q)*x1.*F-D*e)+ehop*elap; 
    dx1 = x1.*(q*F-D)+x1hop*x1lap;
    dx2 = x2.*(F-D)+x2hop*x2lap;
    
    p  = max(0, p+dt*dp); %euler
    e  = max(0, e+dt*de);
    x1 = max(0, x1+dt*dx1);
    x2 = max(0, x2+dt*dx2);
    
    if mod(t, 100) == 0    %save every 100 timesteps for efficiency
        idx = t/100;
        results(idx, :) = x1./(x1+x2+1e-6); %no division by 0
        
        time = (1:idx)*(100*dt);
        imagesc(time, x_i, results(1:idx, :)'); %'to plot on it's side
        
        set(gca, 'YDir', 'normal', 'FontSize', 25);
        colormap(parula);
        clim([0 1]);
        xlabel('Time');
        ylabel('Compartment Index, i');
        colorbar;
        drawnow;
    end
end