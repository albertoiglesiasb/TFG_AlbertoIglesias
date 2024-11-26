function coef = analisis(NACA,AoA,Re,Mach,type)
    %Pasando un vector de Nacas se analizan todos y devuelve el analisis
    %de todos
    %El vector NACAS tiene que ser un string
    coef = struct('name',[],'alpha',[],'Cl',[],'Cd',[],'E',[]);

    % Abrir archivo TXT
    fid = fopen('perfiles_fallidos.txt', 'w');

    %Definición del temporizador
    for i = 1:length(NACA)
        try
            %start(t); % Inicia el temporizador
            if type == 5
                disp(['Analizando ',NACA(i).name]);
                a1 = xfoil(NACA(i).coor, AoA, Re, Mach, 'oper iter 300');
                a1.name = NACA(i).name;
            else
                disp(['Analizando ',char(NACA(i))]);
                a1 = xfoil(char(NACA(i)), AoA, Re, Mach, 'oper iter 200');
                a1.name = string(NACA(i));
            end

            %obtención de la eficiencia
            a1.E = a1.Cl ./ a1.Cd;
            coef(i) = a1;
        catch
            % Si hay un error se ignora el NACA que da el error y se
            % pasa al siguiente
            if type == 5
                % Escribir nombre del perfil fallido en el archivo TXT
                fprintf(fid, '%s\n', NACA(i).name);
                warning('Error al analizar el NACA: %s', NACA(i).name);
                disp(['Error al analizar el NACA:',NACA(i).name]);
            else
                % Escribir nombre del perfil fallido en el archivo TXT
                fprintf(fid, '%s\n', string(NACA(i)));
                warning('Error al analizar el NACA: %s', string(NACA(i)));
                disp(['Error al analizar el NACA:',NACA(i)]);
            end
            
        end
    end

    % Eliminar perfiles no analizados de la estructura coef
    i = 1;
    while i <= length(coef)
        if isempty(coef(i).name) || ~isnumeric(coef(i).Cl)
            coef(i) = [];
            i = i - 1;
        end
        i = i + 1;
    end

    fclose(fid);
end

