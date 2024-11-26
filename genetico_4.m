%% Inicializacion de la población
clear
num_poblacion = 20;
type = 4;
poblacion = random_poblacion(num_poblacion,type);
%load('D:\Escritorio\Universidad\7º Año\TFG\xfoil m files\NACA4\30 poblacion\Misma poblacion\población_inicial.mat')
AoA = -5:1:15;
Re = 1.944e6;
Mach = 0.455;

Cl_target = 0.867;
maxSinMejora = 30;
genSinMejora = 0;
iter = 10;

% Deshabilitar todas las advertencias
warning('off', 'all');

%% Analisis inicial
tic
coef = analisis(poblacion,AoA,Re,Mach,type);
posMejor = maseficiente(coef, Cl_target);
mejor = coef(posMejor);
disp(' ')

%% Iteracion algoritmo
for i = 1:iter
    disp(['Inicio generación ', num2str(i)]);
    % Cruce de los individuos
    disp('Realizando los cruces')
    coef_cruce = s(coef,type);
    % Mutacion de los individuos
    disp('Realizando las mutaciones')
    coef_muta = mutacion(coef_cruce,AoA,Re,Mach,type);
    % Seleccionar los individuos
    disp('Realizando la competición')
    disp(' ')
    coef = seleccion_competicion(coef, coef_muta, Cl_target);
    % Comprobar si hay mejora en el mejor valor de eficiencia
    posMejor = maseficiente(coef, Cl_target);
    if max(coef(posMejor).E) > max(mejor.E)
        mejor = coef(posMejor);
        genSinMejora = 0;
    else
        genSinMejora = genSinMejora + 1;
    end
    % Detener el algoritmo si se alcanza el número máximo de generaciones sin mejora
    if genSinMejora >= maxSinMejora
        break;
    end
end
tiempo = toc;
% Reactivar las advertencias
warning('on', 'all');

%% Mejor individuo
disp(['Tiempo de ejecucion: ', num2str(tiempo), ' segundos']);
posMejor = maseficiente(coef, Cl_target);

disp(['Perfil más eficiente es ', coef(posMejor).name]);
disp(' ')

ordenados = ordenacion(coef, Cl_target);

%% Guardar el espacio de trabajo
% Especificar el nombre de archivo base y la ubicación
nombreArchivoBase = 'naca4gen';
ubicacionGuardado = 'D:\Escritorio\Universidad\7º Año\TFG\Genetico naca 4 5\NACA4\20 poblacion\Poblacion random\10 bucles';

% Obtener el número de archivo guardado más reciente
numeroArchivoReciente = 0;
archivosExistentes = dir(fullfile(ubicacionGuardado, [nombreArchivoBase, '*']));
if ~isempty(archivosExistentes)
    for i = 1:length(archivosExistentes)
        archivoActual = archivosExistentes(i);
        if ~isempty(strfind(archivoActual.name, nombreArchivoBase))
            % Extraer el número de archivo del nombre de archivo
            numeroArchivo = str2double(archivoActual.name(length(nombreArchivoBase) + 1:length(archivoActual.name)-4));
            if numeroArchivo > numeroArchivoReciente
                numeroArchivoReciente = numeroArchivo;
            end
        end
    end
end

% Generar el siguiente nombre de archivo
siguienteNumeroArchivo = numeroArchivoReciente + 1;
nuevoNombreArchivo = [nombreArchivoBase, num2str(siguienteNumeroArchivo), '.mat'];

clear siguienteNumeroArchivo numeroArchivoReciente numeroArchivo archivoActual archivosExistentes nombreArchivoBase

% Extract variable names from 'whos' structure
variableNames = {whos().name};

% Guardar el espacio de trabajo en el archivo generado
save(fullfile(ubicacionGuardado, nuevoNombreArchivo), variableNames{:});
