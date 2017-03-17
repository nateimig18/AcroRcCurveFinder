clear all, close all, clc;

Nx = 1000; 
Nc = 10;

x = linspace(-1, 1, Nx);	dx = x(2) - x(1);	% <---- Normalized stick inputs

m0 = 0.5;		% <----- Center Stick Slope (percentage w.r.t max stick slope)
wmn = 0.05;		% <----- Set the desired linear width percentage minimium
wmx = 0.75;		% <----- Set the desired linear width percentage maximum 
tol = 0.1;		% <----- Define the tolerance linear slope tolerance

w = linspace(wmn, wmx, Nc);												% <--- Calculate linearly spaced linear widths
% w = logspace(log10(wmn), log10(wmx), Nc);								% <--- Calculate logrithmically spaced linear widths
g = lambertw(-1, m0 * tol/(1 - m0) * w .* log(w)) ./ log(w);	% <--- Calculate appropriate gamma params

XX(   1, 1:Nx) = x(:);	XX = repmat(XX, Nc, 1);
GG(1:Nc,    1) = g(:);	GG = repmat(GG, 1, Nx);

% ------ Keep It Super Simple -------
YY = sign(XX) .* ((1 - m0).*abs(XX).^GG + m0.*abs(XX));

lgd = {};
for i = 1:Nc, lgd{i} = sprintf('\\gamma=%4.3f, w=%4.3f', g(i), w(i));  end 

% YY = XX .^ GG;

figure(1);
plot(x, YY); hold;
plot(x, m0*x, 'r','LineWidth', 1.25);
legend(lgd, 'Location', 'NorthWest');
title(sprintf('Custom Normalized RC Curve''s w/ Center-Stick Sensitivity = %4.3f $\\left( \\frac{deg}{sec \\cdot \\Delta} \\right)$', m0),'interpreter','latex');
axis([min(x) max(x) min(YY(1,:)) max(YY(1,:))]);

% plot(x, exp(XX./(1-XX./GG).^P));
figure(2);
dYY = diff(YY')'/dx;
plot(x(1:end-1), dYY);
legend(lgd, 'Location', 'NorthWest');
title(sprintf('Custom Normalized RC Curve''s Slope w/ Center-Stick Sensitivity = %4.3f $\\left( \\frac{deg}{sec \\cdot \\Delta} \\right)$', m0),'interpreter','latex');

W = ones(1, Nc);
for n = 1: Nc,	i = find(dYY(n, round(end/2):end) > (1+tol)*m0);	W(n) = x(i(1) + round(end/2));  end

err = W - w;
display(err)
