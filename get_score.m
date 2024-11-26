function score = get_score(value, lower_bound, upper_bound, normalization, penalization)
    % Esta función calcula la puntuación de adecuación de un perfil aerodinámico.
    %
    % Parámetros
    % ----------
    % value : float
    %     Valor de la propiedad del perfil aerodinámico.
    % lower_bound : float
    %     Límite inferior del rango deseado.
    % upper_bound : float
    %     Límite superior del rango deseado.
    % normalization : float
    %     Factor de normalización de la propiedad.
    % penalization : float
    %     Factor de penalización de la propiedad (normalmente negativo).
    %
    % Retorna
    % -------
    % score : float
    %     Puntuación de adecuación del perfil aerodinámico.

    if isempty(value)
        score = -1e9;  % Valor de penalización extrema si el valor está vacío.
    else
        if lower_bound <= value && value <= upper_bound
            % Normalizar el valor dentro de los límites
            score = ((value - lower_bound) / (upper_bound - lower_bound)) * normalization;
        elseif value < lower_bound
            % Penalizar si está por debajo del límite inferior
            score = (lower_bound - value) * penalization;
        elseif value > upper_bound
            % Penalizar si está por encima del límite superior
            score = (value - upper_bound) * penalization;
        end
    end
end