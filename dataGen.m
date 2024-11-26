function [] = dataGen(direc,name)
    % Inicializar la estructura vacía
    resultados = struct();
    % Buscar archivos 'naca4gen'
    archivos = dir(fullfile(direc, [name, '*']));
    
    % Contar el número de archivos
    numeroArchivos = length(archivos);
    % Inicializar vector vacío para almacenar tiempos de ejecución
    tiemposEjecucion = zeros(1,numeroArchivos);
    perfilesmejor = zeros(1,numeroArchivos);
    
    % Cargar y combinar los archivos
    for i = 1:numeroArchivos
        % Cargar el archivo i
        archivoActual = load([direc, name, num2str(i), '.mat']);
    
        % Asignar datos a la estructura
        resultados(i).mejor = archivoActual.mejor.name;
        resultados(i).tiempo = archivoActual.tiempo;
        tiemposEjecucion(i) = archivoActual.tiempo;
        perfilesmejor(i) = obt_NACA(archivoActual.mejor.name);
    end

    % Calcular la media y la desviación estándar
    media = mean(tiemposEjecucion);
    desviacionEstandar = std(tiemposEjecucion);
    
    % Guardar la estructura
    save([direc, 'resultados.mat'], 'resultados',"media","tiemposEjecucion","desviacionEstandar","perfilesmejor");
end
