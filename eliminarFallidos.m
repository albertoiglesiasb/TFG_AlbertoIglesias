function [validosFinales] = eliminarFallidos(numeros_validos, fallidos)
    % Create a logical mask
    maskValidos = true(size(numeros_validos));
    maskValidos(ismember(numeros_validos, fallidos)) = false;
    % Filter valid profiles
    validosFinales = numeros_validos(maskValidos);
end