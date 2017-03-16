clear all, close all, clc;

Nx = 1000; 
Nc = 10;

m0 = 0.2;				% <----- Center Stick Slope (percentage w.r.t max stick slope)
x = linspace(0, 1, Nx);	dx = x(2) - x(1);
g = logspace(log10(2), log10(10), Nc);		% <--- Varies the linear center width logrithmically.... 

XX(   1, 1:Nx) = x(:);	XX = repmat(XX, Nc, 1);
GG(1:Nc,    1) = g(:);	GG = repmat(GG, 1, Nx);

% ------ Over-complicated things here ------
% Experimenting with gamma & rho dependence...
% off = 1;			% <-- Currently Experimenting making a simple linear relationship between rho & gamma
% p = g + off;			
% P = GG + off;
% Ap = p .* (exp(1./p) - 1);
% q = m0.*Ap./(1 - m0 .* Ap);		% <--- Defines your center stick sensitivity (i.e. slope)
% QQ(1:Nc, 1) = q(:);  QQ = repmat(QQ, 1, Nx); 
% YY = sign(XX) .* (abs(XX) .^ GG + QQ .* (exp(abs(XX)./P) - 1)./(exp(1./P)-1) ) ./ (1 + QQ);

% ------ Keep It Super Simple -------
YY = sign(XX) .* ((1 - m0).*abs(XX).^GG + m0.*abs(XX));

lgd = {};
for i = 1:Nc, lgd{i} = sprintf('\\gamma=%4.3f, \\rho=%4.3f \\phi=%4.3f', g(i), p(i), q(i));  end 

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
