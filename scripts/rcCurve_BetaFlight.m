% The math behind this formulation is scattered through out "rcCurve_Betaflight.pdf" which
% is derived from the "RateCurve_BF.js" found in the BetaFlight configurator source code.

% While each transmitter is different and even gimbals may be different its safe to 
% start at lower end points and work up from there.

% Please use caution when calculating parameters and entering into the configurator and verify
% end-points center-stick slope.
clear all, close all, clc

v = @(x, rc_expo)		x .* (rc_expo .* abs(x).^3 + (1 - rc_expo));		% note the abs() around the x^3
% v = @(x, rc_expo)		rc_expo .* x.^3  + (1 - rc_expo) .* x;			% More like KISS curve w/ out abs()

rc_Rate = @(x)	 x .* (x <= 2.0) + (x+29.16)/15.54 .* (x > 2.0);

Nx = 2000;		% 
Nc = 5;			% Number of curves  to produce

w_slope = 200;		% (deg/sec)/(full traversal) ???
w_max = 900;		% (deg/sec)

% x = linspace(-1, 1, Nx);		% <-- Look at full input range 
Nx = Nx/2;	x = linspace(0, 1, Nx);			% <-- Look at half input range

RMAX = min([0.99, 1-w_slope/w_max]);

R = (1+RMAX) - logspace(log10(1), log10(1+RMAX), Nc);
% R = linspace(0, 0.99*RMAX, Nc);
rcR = w_max/200*(1 - R);
rcE = 1 - w_slope./(w_max*(1-R));


XX = repmat(x, Nc, 1);
RR(1:Nc, 1) = R(:);		RR = repmat(RR, 1, Nx);
RCR(1:Nc, 1) = rcR(:);	RCR = repmat(RCR, 1, Nx);
RCE(1:Nc, 1) = rcE(:);	RCE = repmat(RCE, 1, Nx);

rcR = rc_Rate(rcR);

w = 200 * RCR .* (v(XX, RCE)./(1 - RR .* abs(v(XX, RCE))));
wDiff = diff(w');

Gs = max(wDiff) ./ min(wDiff);


% plot(x, v(XX, RCE));
for i = 1:Nc, lgd{i} = sprintf('RC Rate:%3.2f; Rate:%3.2f; RC Expo:%3.2f, G_S=%3.2f', rcR(i), R(i), rcE(i), Gs(i));  end 

figure(1);
subplot(1,2,1);
plot(x, w); hold;
plot(x, w_slope*x, 'r', 'LineWidth', 2);
title(sprintf('BetaFlight RC Curve''s w/ Center-Sensitivity = %4.1f $\\left( \\frac{deg}{sec \\cdot \\Delta} \\right)$, End Pts. = %d $\\left( \\frac{deg}{sec} \\right)$', w_slope, w_max),'interpreter','latex');
legend(lgd, 'Location', 'NorthWest');

subplot(1,2,2);
plot(x(1:end-1), wDiff');
title(sprintf('BetaFlight RC Sensitivity Curve''s w/ Center-Sensitivity = %4.1f $\\left( \\frac{deg}{sec \\cdot \\Delta} \\right)$, End Pts. = %d $\\left( \\frac{deg}{sec} \\right)$', w_slope, w_max),'interpreter','latex');
legend(lgd, 'Location', 'NorthEast');
