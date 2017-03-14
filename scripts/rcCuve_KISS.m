% The math behind the formulation is scattered through out "rcCurve_KISS.pdf"
% which is based on the "jquery.kiss.rates.chart_KISS.js" used in the KISS configurator
% While each transmitter is different and even gimbals may be different its safe to 
% start at lower end points and work up from there.
clear all, close all, clc

% KISS FC ripped from "http://ultraesc.de/KISSFC/rates.html" under inspect "head-script"
poly_rc = @(x, r, pr) (pr .* x.^3 + (1 - pr) .* x).*(r/10);
expo_rc = @(x, ar) 1./(1 - abs(x).*ar);
f = @(x, r, ar, pr) round(2000 * expo_rc(x, ar) .* poly_rc(x, r, pr)*100)/100;

Nc = 5;                    % Number of curves
w_max = 900;               % (deg/sec) Define end points "full-stick" maximum rotational vel.
w_slope = 200;					% (deg/sec/inc) Define "center-stick" sensitivity.


Nx = 2000;						% Number of steps RC remote and reciever put give to FC... Taranis = 2000???

rcRateMax = w_max / 200       % 1-200*rr/ENDPT > 0    ==>   rr <= ENDPT /200
rcRateLow = w_slope / 200		% 1-SLOPE/(200*rr) > 0  ==>   SLOPE/200 <= rr

% xx = linspace(-1, 1, Nx);				% <-- Look at full input range            
Nx = Nx/2; xx = linspace(0, 1, Nx);		% <-- Look at half input range

rr = logspace(log10(rcRateLow), log10(rcRateMax), Nc); % (1xNR) RC Rate   (logarithmically spaced)
ar = abs(1 - 200*rr / w_max);                % (1xNR) Condition maintains the same max rotation rate
pr = abs(1 - w_slope ./(200*rr));				% (1xNR) Expo Rate (Adds in a geometric expo, flattens mid region but increases the slop on the ends)

XX(1:Nx,    1) = xx;    XX = repmat(XX, 1, Nc);
PR(   1, 1:Nc) = pr;    PR = repmat(PR, Nx, 1);
RR(   1, 1:Nc) = rr;    RR = repmat(RR, Nx, 1);
AR(   1, 1:Nc) = ar;    AR = repmat(AR, Nx, 1);

y = f(XX, RR, AR, PR);
yDiff = diff(y, 1);
Gs = max(yDiff, [], 1) ./ min(yDiff, [], 1); % Sensitivity Gain
mnDy = min(yDiff(:, 1)); 

%[~, tbarH] = system('powershell; Add-Type -AssemblyName System.Windows.Forms;  $x = [System.Windows.Forms.Screen]::AllScreens; $x.Bounds.Size.Height - $x.WorkingArea.Size.Height;')
%tbarH = str2double(tbarH)

figure(1);
%set(gcf,'units','pixels','outerposition',[0 tbarH 1925 1080-tbarH]);
lgd = {};

subplot(1,2,1);
% title('KISS RC Curve''s w/ Sensitivity = !');
plot(XX(:,:), y(:,:)); hold;  
title(sprintf('KISS RC Curve''s w/ Center-Sensitivity = %4.1f $\\left( \\frac{deg}{sec \\cdot \\Delta} \\right)$, End Pts. = %d $\\left( \\frac{deg}{sec} \\right)$', w_slope, w_max),'interpreter','latex');

plot(xx, w_slope*xx, 'r', 'LineWidth', 2);
plot([min(xx); max(xx); 0], [min(y(:, 1)); max(y(:, 1)); 0], 'ro')

for i = 1:Nc,  lgd{i} = sprintf('RC Rate:%3.2f; Rate:%3.2f; Curve:%3.2f, G_S=%3.2f', rr(i), ar(i), pr(i), Gs(i));  end
legend(lgd, 'Location', 'NorthWest');

subplot(1,2,2);
plot(XX(1:end-1,:), yDiff(:,:)); hold;
title(sprintf('KISS RC Sensitivity Curve''s w/ Center-Sensitivity = %4.1f $\\left( \\frac{deg}{sec \\cdot \\Delta} \\right)$, End Pts. = %d $\\left( \\frac{deg}{sec} \\right)$', w_slope, w_max),'interpreter','latex');

for i = 1:Nc, lgd{i} = sprintf('RC Rate:%3.2f; Rate:%3.2f; Curve:%3.2f, G_S=%3.2f', rr(i), ar(i), pr(i), Gs(i));  end 
legend(lgd, 'Location', 'North');
