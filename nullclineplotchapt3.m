s0 = 1;
d  = 1;
q  = 0.8;
k  = 20;
m  = 5;
a  = 0.05;
beta = 18;                                            % lowers red nullcline set as 4 or 18

p_f = (d*beta*a)/(q*m-d);                             % f^{-1}(d/q) with beta, dx_1 set to 0 gives qf(p)-d=0, rearrange for p

[w, x1] = meshgrid(0:0.05:1, 0:0.05:2);
omega = (x1>=0) & (x1<=q*w) & (w<=1);                 %feasible region
dw  = ((1-q)/q)*x1.*(k*(s0-w)) - d*w;                 %k*(s0-w) is g here
dx1 = x1.*(q*(m*(w-x1/q)./(beta*a+(w-x1/q)))-d);
dw(~omega) = NaN;                                     %anything not in feasible set is omitted
dx1(~omega) = NaN;

mag = sqrt(dw.^2+dx1.^2);
u = dw./mag;
v = dx1./mag;

w_vals = linspace(0.001,0.999,2000);

x1hwnullcline = (d*q/(k*(1-q))).*(w_vals./(s0-w_vals));          %x_1=h(w) for w nullcline
mask_w  = (x1hwnullcline >= 0) & (x1hwnullcline <= q*w_vals);
x1nullcline = q*(w_vals-p_f);                                    % other x_1 nullcline
mask_x = (x1nullcline >= 0) & (x1nullcline <= q*w_vals);

figure;
hold on
quiver(w, x1, u, v, 0.45, 'k', 'LineWidth', 2, 'HandleVisibility', 'off')
plot(w_vals(mask_w), x1hwnullcline(mask_w), 'b', 'LineWidth', 3)
plot(w_vals(mask_x), x1nullcline(mask_x), 'r', 'LineWidth', 3)
plot([0 1], [0 0], 'k', 'LineWidth', 3)          % x1 = 0
plot([0 1], q*[0 1], 'k', 'LineWidth', 3)        % x1 = qw
plot([1 1], [0 q], 'k', 'LineWidth', 3)          % w = 1

xlabel('w')
ylabel('x_1')
title('Nullcline Plot', 'FontWeight', 'normal')
set(gca, 'FontSize', 25)
grid on
axis([0 1 0 q])
legend('w-nullcline','x_1-nullcline','Location','northwest')