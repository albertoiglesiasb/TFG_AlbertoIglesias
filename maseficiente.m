function [posMejorPerfil] = maseficiente(coef, Cl_target)
    % Inicializa las variables
    posMejorPerfil = 1; % Inicialización de la posición del mejor perfil
    maxEficiencia = -100; % Inicialización de la máxima eficiencia
     
    % Recorre el vector de estructuras
    for i = 1:length(coef)
        if ~isempty(coef(i).Cl)
            % Extrae los datos de Cl y eficiencia del perfil actual
            Cl_data = coef(i).Cl;
            Eficiencia_data = coef(i).E;
            
            % Encuentra el índice más cercano al Cl_target
            [~, idx] = min(abs(Cl_data - Cl_target));
            
            % Calcula la eficiencia correspondiente a ese Cl más cercano
            eficienciaActual = Eficiencia_data(idx);
            
            % Si la eficiencia actual es mayor que la máxima eficiencia encontrada hasta ahora
            if eficienciaActual > maxEficiencia
                % Actualiza la máxima eficiencia encontrada
                maxEficiencia = eficienciaActual;
                
                % Actualiza la posición del perfil con la máxima eficiencia
                posMejorPerfil = i;
            end
        end
    end
end
