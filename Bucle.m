%% VARIABLES

clear

type = 4;

NACA = crearNaca(type);
AoA = -5:1:15;
Re = 1.944e6;
Mach = 0.455;

Cl_target = 0.867;
warning('off', 'all');

%% ANALISIS
tic
coef = analisis(NACA,AoA,Re,Mach,type);
tiempo = toc;

%% Eficiente
warning('on', 'all');
PosEfic = maseficiente(coef, Cl_target);

%% Ordenacion

ordenados = ordenacion(coef, Cl_target);

