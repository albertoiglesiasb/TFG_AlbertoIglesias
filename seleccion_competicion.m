function [coef] = seleccion_competicion(coef, coef_muta, Cl_target)
% Selección por competición basada en la eficiencia en Cl_target
% Las mutaciones van a competir por una posición aleatoria de 
% la población existente para ver cuál es mejor en Cl_target.

long_coef = length(coef);
    
    % Recorre las mutaciones
    for i = 1:length(coef_muta)
        % Selecciona una posición aleatoria en la población existente
        pos_comp = randi(long_coef);
        
        % Encuentra la eficiencia de la mutación en Cl_target
        Cl_muta = coef_muta(i).Cl;
        Eficiencia_muta = coef_muta(i).E;
        [~, idx_muta] = min(abs(Cl_muta - Cl_target));  % Índice más cercano a Cl_target
        eficiencia_atacante = Eficiencia_muta(idx_muta);  % Eficiencia de la mutación en Cl_target
        
        % Encuentra la eficiencia del defensor (perfil en la posición aleatoria) en Cl_target
        Cl_defensor = coef(pos_comp).Cl;
        Eficiencia_defensor = coef(pos_comp).E;
        [~, idx_defensor] = min(abs(Cl_defensor - Cl_target));  % Índice más cercano a Cl_target
        eficiencia_defensor = Eficiencia_defensor(idx_defensor);  % Eficiencia del defensor en Cl_target
        
        % Si la eficiencia del atacante (mutación) es mayor, reemplaza al defensor
        if eficiencia_atacante > eficiencia_defensor
            coef(pos_comp) = coef_muta(i);
        end
    end

end
