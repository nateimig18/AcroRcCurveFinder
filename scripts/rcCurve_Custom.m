clear all, close all, clc;

Nx = 1000; 
Ng = 10;

x = linspace(0, 1, Nx);
g = logspace(log10(2), log10(8), Ng);		% <--- Varies the linear center width logrithmically.... 

XX(   1, 1:Nx) = x(:);	XX = repmat(XX, Ng, 1);
GG(1:Ng,    1) = g(:);	GG = repmat(GG, 1, Nx);

p = g+3;
P = GG + 3;

a = 0.9;												% <--- Defines your center stick sensitivity (i.e. slope)
YY = (XX .^ GG + a*(exp(XX./P) - 1)./(exp(1./P)-1) ) / (1 + a);

lgd = {};
for i = 1:Ng, lgd{i} = sprintf('s_c=%4.3f \\gamma=%4.3f, \\rho=%4.3f', a, g(i), p(i));  end 

% YY = XX .^ GG;

figure(1);
plot(x, YY); hold;
legend(lgd, 'Location', 'NorthWest');

axis([0 1 0 1])
% plot(x, exp(XX./(1-XX./GG).^P));
