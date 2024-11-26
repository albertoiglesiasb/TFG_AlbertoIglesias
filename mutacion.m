function coef_muta = mutacion(coef, AoA, Re, Mach, type)
%Realiza los cruces entre dos perfiles haciendo la mitad de los existentes
%en la poblacion.
    num_muta = length(coef);

    coef_muta = struct('name',[],'alpha',[],'Cl',[],'Cd',[],'E',[]);
    
    if type == 5
        numeros_validos = find(mod(1:99999, 100) > 6 & mod(1:99999, 100) <= 21 & (floor(mod(1:99999, 1000)/100) == 0 | floor(mod(1:99999, 1000)/100) == 1) & floor(mod(1:99999, 10000)/1000) >= 1 & floor(mod(1:99999, 10000)/1000) <= 5 & floor(mod(1:99999, 100000)/10000) <= 6 & floor(mod(1:99999, 100000)/10000) >= 1 & floor(mod(1:99999, 10000)/100) ~= 11 & floor(mod(1:99999, 10000)/100) ~= 51);
        fallidos = [11008,11011,11013,11014,11018,11019,11020,11021,12008,12015,12019,12020,12021,12110,12119,13015,13021,13115,13117,13119,14107,14110,14120,14121,21007,21008,21009,21010,21012,21020,21021,22010,22015,22018,22020,22108,22111,22114,22118,22121,23007,23008,23019,23020,23021,23121,24117,24120,24121,25016,31007,31008,31009,31011,31012,31013,31019,31020,31021,32007,32008,32020,32107,32108,32113,32114,32115,32117,32119,33007,33008,33009,33014,33016,33021,33107,33108,33118,34007,34008,34010,34107,34120,35007,35011,35013,35016,35017,35021,41007,41008,41009,41010,41011,41012,41013,41014,41015,41021,42007,42008,42009,42010,42011,42019,42020,42107,42108,42109,42110,42111,42114,42116,42118,42121,43007,43008,43009,43010,43011,43020,43107,43108,43109,43110,43111,43117,43119,43121,44007,44008,44009,44010,44011,44017,44019,44021,44107,44108,44109,44110,44118,44120,44121,45007,45008,45009,45016,45017,51007,51008,51009,51010,51011,51012,51013,51014,51015,51017,51018,51019,51021,52007,52008,52009,52010,52011,52012,52013,52014,52015,52016,52019,52107,52108,52109,52111,52112,52116,53007,53008,53009,53010,53011,53012,53013,53015,53017,53020,53107,53108,53109,53110,53111,53112,53115,53116,53118,53119,53121,54007,54008,54009,54010,54011,54013,54014,54015,54016,54020,54107,54108,54108,54109,54111,54119,55007,55008,55009,55010,55011,55012,55013,55015,55016,55017,55018,55019,55020,55021,61007,61008,61009,61010,61011,61012,61013,61012,61014,61015,61016,61017,61018,61019,61020,61021,62007,62008,62010,62011,62012,62014,62015,62016,62017,62018,62019,62107,62108,62109,62110,62111,62112,62113,62114,62116,63007,63008,63009,63010,63011,63012,63014,63015,63107,63108,63109,63110,63111,63113,63114,63115,63116,63117,63118,63119,64007,64008,64009,64010,64011,64012,64013,64014,64015,64016,64017,64020,64021,64107,64108,64109,64111,64112,65007,65008,65009,65010,65013,65012,65015,65016,65017,65018,65018,65019,65020,65021];
  
        numeros_validos = eliminarFallidos(numeros_validos, fallidos);
        
        for i = 1:num_muta
            %Posicion Perfil para mutar
            pos_mut = i;
            %Perfil para mutar
            naca_muta = obt_NACA(coef(pos_mut).name);

            j = 1;

            espesor = mod(naca_muta,100);
            maxc = mod(naca_muta,10000) - espesor;
            design = mod(naca_muta,100000) - maxc - espesor;

            if rand < 0.8
                level = randi(3);
                switch level
                    case 1
                        %Nivel 1: Se cambia el espesor del perfil
                        espesor = randi([7, 21]);
                        naca_mutado = design + maxc + espesor;
                        while ~ismember(naca_mutado, numeros_validos)
                            espesor = randi([7, 21]);
                            naca_mutado = design + maxc + espesor;
                            j = j + 1;
                            if j >= 3
                                design = randi([1, 6])*10000;
                            end
                        end   
                    case 2
                        %Nivel 2: Se va a cambiar la posicion de maxima curvatura
                        numeros_deseados = [10 20 21 30 31 40 41 50];
                        indices_aleatorios = randperm(length(numeros_deseados));
                        maxc = numeros_deseados(indices_aleatorios(1))*100;
                        naca_mutado = design + maxc + espesor;
                        while ~ismember(naca_mutado, numeros_validos)
                            indices_aleatorios = randperm(length(numeros_deseados));
                            maxc = numeros_deseados(indices_aleatorios(1))*100;
                            naca_mutado = design + maxc + espesor;
                            j = j + 1;
                            if j >= 4
                                espesor = randi([7, 21]);
                            end
                        end   
                    case 3
                        %Nivel 3: Se va a cambiar el diseño
                        design = randi([1, 6])*10000;
                        naca_mutado = design + maxc + espesor;
                        while ~ismember(naca_mutado, numeros_validos)
                            design = randi([1, 6])*10000;
                            naca_mutado = design + maxc + espesor;
                            j = j + 1;
                            if j >= 3
                                espesor = randi([7, 21]);
                            end
                        end   
                end
            else
                naca_mutado = design + maxc + espesor;
                while ~ismember(naca_mutado, numeros_validos)
                    espesor = randi([7, 21]);
                    if design == 60000 && maxc == 1000
                        numeros_deseados = [20 21 30 31 40 41 50];
                        indices_aleatorios = randperm(length(numeros_deseados));
                        maxc = numeros_deseados(indices_aleatorios(1))*100;
                    end
                    naca_mutado = design + maxc + espesor;
                end
            end

            try
                mutado = coordNaca5(sprintf("%05d", naca_mutado));
                a1 = xfoil(mutado.coor, AoA, Re, Mach, 'oper iter 300');
                a1.E = a1.Cl ./ a1.Cd;
                a1.name = mutado.name;
            catch
                a1 = struct('name',[],'alpha',[],'Cl',[],'Cd',[],'E',[]);
                a1.E = -100000;
                a1.name = mutado.name;
                disp(['Error analizando ', string(mutado.name)]);
            end
            coef_muta(i) = a1;
        end
    else
        numeros_validos = find((mod(1:9999, 100) > 5 & mod(1:9999, 100) < 25 & floor(mod(1:9999, 10000)/1000) <= 7 & floor(mod(1:9999, 1000)/100) <= 7 & floor(mod(1:9999, 10000)/1000) >= 3 & floor(mod(1:9999, 1000)/100) >= 3 & mod(1:9999, 10000) ~= 7306) | (floor(mod(1:9999, 10000)/100) == 0 & mod(1:9999, 100) < 25 & mod(1:9999, 100) > 5));
        fallidos = [0006,0007,4306,4606,4706,4707,5306,5307,5406,5506,6306,6307,6406,6407,6407,6506,6606,6607,6706,7307,7308,7309,7406,7407,7506];

        numeros_validos = eliminarFallidos(numeros_validos, fallidos);
        for i = 1:num_muta
            %Perfil para mutar
            naca_muta = obt_NACA(coef(i).name);
            
            %Se obtiene el espesor, posicion de maxima curvatura y curvatura
            %del perfil para mutar
            espesor = mod(naca_muta,100);
    
            maxc = mod(naca_muta,1000) - espesor;
    
            curv = mod(naca_muta,10000) - maxc - espesor;
    
            if maxc == 0
    
                %Significa que es simetrico
                %Por lo que se cambia los primeros numeros
                %Se cambia la curvatura y posición de maxima curvatura
                permutacionAleatoria = randperm(length(numeros_validos));
                indiceAleatorio = permutacionAleatoria(1);
                naca = numeros_validos(indiceAleatorio);
                %Se obtiene el perfil mutado que tendrá el espesor del original
                naca_mutado = mod(naca,10000) - mod(naca,100) + espesor;  
                while (~ismember(naca_mutado, numeros_validos) || naca_mutado == naca_muta)
                    permutacionAleatoria = randperm(length(numeros_validos));
                    indiceAleatorio = permutacionAleatoria(1);
                    naca = numeros_validos(indiceAleatorio);
                    naca_mutado = mod(naca,10000) - mod(naca,100) + espesor; 
                end
                
            else
                if rand < 0.8
                    %Nivel de cruce  
                    level = randi(3);
                    if level == 1
                    %Nivel 1: Se cambia el espesor del perfil 1
                        alea = randi([5, 24]);
                        naca_mutado = curv + maxc + alea;
                        while (~ismember(naca_mutado, numeros_validos) || naca_mutado == naca_muta)
                            alea = randi([5, 24]);
                            naca_mutado = curv + maxc + alea;
                        end                       
                    elseif level == 2
                    %Nivel 2: Se va a cambiar la posicion de maxima curvatura
                        alea = randi([3, 7]) * 100;
                        naca_mutado = curv + alea + espesor;
                        while (~ismember(naca_mutado, numeros_validos) || naca_mutado == naca_muta)
                            alea = randi([3, 7]) * 100;
                            naca_mutado = curv + alea + espesor;
                            if espesor == 6 && ~ismember(naca_mutado, numeros_validos)
                                espesor = randi([7, 24]);
                                naca_mutado = curv + alea + espesor;
                            end
                        end  
                    elseif level == 3
                    %Nivel 3: Se va a cambiar la curvatura
                        alea = randi([3, 7]) * 1000;
                        naca_mutado = alea + maxc + espesor;
                        while (~ismember(naca_mutado, numeros_validos) || naca_mutado == naca_muta)
                            alea = randi([3, 7]) * 1000;
                            naca_mutado =  alea + maxc + espesor;
                            if espesor == 6 && ~ismember(naca_mutado, numeros_validos)
                                espesor = randi([6, 24]);
                                naca_mutado =  alea + maxc + espesor;
                            end
                        end 
                    end
                else
                    naca_mutado = curv + maxc + espesor;
                    while ~ismember(naca_mutado, numeros_validos)
                        espesor = randi([6, 24]);
                        naca_mutado = curv + maxc + espesor;
                    end
                end
            end
                
            a1 = xfoil(char(sprintf("NACA%04d", naca_mutado)), AoA, Re, Mach, 'oper iter 200');
            a1.E = a1.Cl ./ a1.Cd;
            a1.name = char(sprintf("NACA%04d", naca_mutado));
            coef_muta(i) = a1;
        end
    end

end