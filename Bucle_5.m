%% VARIABLES

clear

type  = 5;

warning('off', 'all');
NACA = crearNaca(type);
AoA = -5:1:15;
Re = 1.944e6;
Mach = 0.455;

Cl_target = 0.867;

%% ANALISIS
tic
coef = analisis(NACA,AoA,Re,Mach,type);
tiempo = toc;
warning('on', 'all');

%% Eficiente

PosEfic = maseficiente(coef, Cl_target);

%% Ordenacion

ordenados = ordenacion(coef, Cl_target);