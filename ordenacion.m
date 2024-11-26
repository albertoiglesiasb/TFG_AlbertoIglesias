function [coef] = ordenacion(coef, Cl_target)

    % Recorre cada perfil para asegurarse de que no haya valores vacíos en E
    for i = 1:length(coef)
        if isempty(coef(i).E)
            coef(i).E = -1000; % Asigna un valor muy bajo a perfiles sin eficiencia
        end
    end
    
    % Inicializa un array para almacenar la eficiencia en Cl_target
    E_Cl_target = zeros(1, length(coef));
    
    % Recorre cada perfil para calcular la eficiencia en el punto más cercano a Cl_target
    for i = 1:length(coef)
        if ~isempty(coef(i).Cl)
            Cl_data = coef(i).Cl;   % Extrae los datos de Cl
            E_data = coef(i).E;  % Extrae los datos de eficiencia
            
            % Encuentra el índice más cercano a Cl_target
            [~, idx] = min(abs(Cl_data - Cl_target));
            
            % Guarda la eficiencia correspondiente a ese índice
            E_Cl_target(i) = E_data(idx);
        else
            E_Cl_target(i) = -1000;
        end
    end
    
    % Ordena los perfiles en función de la eficiencia en Cl_target
    [~, order] = sort(E_Cl_target, 'descend');
    
    % Ordena el vector de estructuras según la eficiencia en Cl_target
    coef = coef(order);

end
