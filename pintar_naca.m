clc 
clear

NACA = 'NACA2412';
AoA = -5:1:15;
Re = 2e7;
Mach = 0.3;

[coef, foil] = xfoil(NACA,AoA,Re,Mach);

%% PLOT 

XB_U = foil.x (foil.y(:,1) >= 0 & foil.x(:,1) <= 1);
XB_L = foil.x (foil.y(:,1) <= 0 & foil.x(:,1) <= 1);
YB_U = foil.y (foil.y(:,1) >= 0 & foil.x(:,1) <= 1);
YB_L = foil.y (foil.y(:,1) <= 0 & foil.x(:,1) <= 1);

figure (1);
cla; hold on; grid on;
set(gcf, 'Color', 'White');
set(gca, 'FontSize',12);
plot (XB_U, YB_U, 'b.-');
plot (XB_L, YB_L, 'r.-');
xlabel ('X Coordinate');
ylabel ('Y Coordinate');
axis equal;