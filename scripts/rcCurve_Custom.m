clear all, close all, clc;

Nx = 1000; 
Nc = 10;

x = linspace(-1, 1, Nx);	dx = x(2) - x(1);
g = logspace(log10(2), log10(10), Nc);		% <--- Varies the linear center width logrithmically.... 

XX(   1, 1:Nx) = x(:);	XX = repmat(XX, Nc, 1);
GG(1:Nc,    1) = g(:);	GG = repmat(GG, 1, Nx);

% Experimenting with gamma & rho dependence...
off = 2;			% <-- Currently Experimenting making a simple linear relationship between rho & gamma
p = g + off;			
P = GG + off;

m0 = 0.35;
Ap = p .* (exp(1./p) - 1);
q = m0.*Ap./(1 - m0 .* Ap);		% <--- Defines your center stick sensitivity (i.e. slope)

QQ(1:Nc, 1) = q(:);  QQ = repmat(QQ, 1, Nx); 

YY = sign(XX) .* (abs(XX) .^ GG + QQ .* (exp(abs(XX)./P) - 1)./(exp(1./P)-1) ) ./ (1 + QQ);

lgd = {};
for i = 1:Nc, lgd{i} = sprintf('\\gamma=%4.3f, \\rho=%4.3f \\phi=%4.3f', g(i), p(i), q(i));  end 

% YY = XX .^ GG;

figure(1);
plot(x, YY); hold;
plot(x, m0*x, 'r','LineWidth', 1.25);
legend(lgd, 'Location', 'NorthWest');
title(sprintf('Custom Normalized RC Curve''s w/ Center-Stick Sensitivity = %4.3f $\\left( \\frac{deg}{sec \\cdot \\Delta} \\right)$', m0),'interpreter','latex');
axis([-1 1 -1 1]);

% plot(x, exp(XX./(1-XX./GG).^P));
figure(2);
dYY = diff(YY')'/dx;
plot(x(1:end-1), dYY);
legend(lgd, 'Location', 'NorthWest');
title(sprintf('Custom Normalized RC Curve''s Slope w/ Center-Stick Sensitivity = %4.1f $\\left( \\frac{deg}{sec \\cdot \\Delta} \\right)$', m0),'interpreter','latex');
