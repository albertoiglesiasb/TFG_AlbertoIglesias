function num_NACA = obt_NACA(naca)
    %Funcion para obtener el numero de naca en un char
    patron = '\d+';
    coincidencias = regexp(naca, patron, 'match');
    %Convierte a numero
    num_NACA = str2double(coincidencias{1});
end

