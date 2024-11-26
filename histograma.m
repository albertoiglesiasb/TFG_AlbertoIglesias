% Dirección y nombre
direc = 'D:\Escritorio\Universidad\7º Año\TFG\Genetico naca 4 5\NACA4\20 poblacion\Poblacion random\10 bucles\';
name = 'naca4gen';

% Crear resultados
dataGen(direc, name);
load([direc,'resultados.mat'])

%% Inicializar un contador para almacenar los conteos de NACA
conteosNACA = containers.Map('KeyType', 'char', 'ValueType', 'int32');

% Iterar por los nombres de NACA y actualizar conteos
for i = 1:length(resultados)
    nombreNACA = resultados(i).mejor;
    if isKey(conteosNACA, nombreNACA)
        conteosNACA(nombreNACA) = conteosNACA(nombreNACA) + 1;
    else
        conteosNACA(nombreNACA) = 1;
    end
end

% Visualizar conteos usando un gráfico de barras
nombresNACA = keys(conteosNACA);
nombresNACA = categorical(nombresNACA);
conteosNACA = values(conteosNACA);
conteosNACA = cellfun(@double, conteosNACA);

% Calcular el conteo total de NACA
conteoTotal = sum(conteosNACA);

% Calcular los porcentajes
porcentajesNACA = (conteosNACA / conteoTotal) * 100;

%% Gráfica
f1 = figure();
bar(nombresNACA, porcentajesNACA);

grid on

% Etiquetaje adicional
xlabel('Nombre del Perfil NACA');
ylabel('Porcentaje');
title('20 población 10 iteraciones');
ylim([0, 100]);

% Guardar grafica en svg
saveas(f1,fullfile(direc, 'naca4_20p_10i.svg'));

%% Visualizar la distribución del tiempo
f2 = figure();
histogram(tiemposEjecucion, 'Normalization','count');
xlabel('Tiempo de ejecución');
ylabel('Frecuencia');
title('Distribución de tiempos de ejecución');

%% Diagrama de dispersión perfiles vs tiempo
% Se extraen los perfiles unicos
unicoPerfiles = unique(perfilesmejor);

% Crear el diagrama de dispersión
scatter(perfilesmejor, tiemposEjecucion);

% Personalizar el diagrama (opcional)
xlabel('Perfil optimizado');
ylabel('Tiempo de ejecución');
title('Diagrama de dispersión: Perfiles vs. Tiempos');
grid on;




