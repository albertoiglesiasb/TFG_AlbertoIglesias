function [coef_cruz] = cruce(coef, type)
%Realiza los cruces entre dos perfiles haciendo la mitad de los existentes
%en la poblacion.
    num_cruces = round(length(coef)*0.4);
    num_pobla = length(coef);

    if type == 5

        coef_cruz = struct('name',[],'coor',[]);

        for i = 1:2:num_cruces
            %Primer perfil para cruzar
            cruc1 = randi(num_pobla);
            %Segundo perfil para cruzar
            cruc2 = randi(num_pobla);
            %Segundo perfil debe ser distinto al perfil 1
            while cruc2 == cruc1
                cruc2 = randi(num_pobla);
            end

            naca_cruce1 = obt_NACA(coef(cruc1).name);
            naca_cruce2 = obt_NACA(coef(cruc2).name);

            espesor_1 = mod(naca_cruce1,100);
            espesor_2 = mod(naca_cruce2,100);

            maxc_1 = mod(naca_cruce1,10000) - espesor_1;
            maxc_2 = mod(naca_cruce2,10000) - espesor_2;

            design_1 = mod(naca_cruce1,100000) - maxc_1 - espesor_1;
            design_2 = mod(naca_cruce2,100000) - maxc_2 - espesor_2;

            %Nivel de cruce  
            level = randi(3);

            switch level
                case 1
                    %Nivel 1: Se cambian los espesores
                    naca_cruzado1 = design_1 + maxc_1 + espesor_2;
                    naca_cruzado2 = design_2 + maxc_2 + espesor_1;

                case 2
                    %Nivel 2: Se va a cambiar la posicion de maxima curvatura
                    naca_cruzado1 = design_1 + maxc_2 + espesor_1;
                    naca_cruzado2 = design_2 + maxc_1 + espesor_2;

                case 3
                    %Nivel 3: Se va a cambiar el diseño
                    naca_cruzado1 = design_2 + maxc_1 + espesor_1;
                    naca_cruzado2 = design_1 + maxc_2 + espesor_2;
            end

            naca = coordNaca5([sprintf("%05d", naca_cruzado1), sprintf("%05d", naca_cruzado2)]);
            coef_cruz(i) = naca(1);
            coef_cruz(i+1) = naca(2);
        end
    else

        coef_cruz = struct('name',[]);
        
        for i = 1:2:num_cruces
            %Primer perfil para cruzar
            cruc1 = randi(num_pobla);
            %Segundo perfil para cruzar
            cruc2 = randi(num_pobla);
            %Segundo perfil debe ser distinto al perfil 1
            while cruc2 == cruc1
                cruc2 = randi(num_pobla);
            end
            
            naca_cruce1 = obt_NACA(coef(cruc1).name);
            naca_cruce2 = obt_NACA(coef(cruc2).name);
    
            espesor_1 = mod(naca_cruce1,100);
            espesor_2 = mod(naca_cruce2,100);
    
            maxc_1 = mod(naca_cruce1,1000) - espesor_1;
            maxc_2 = mod(naca_cruce2,1000) - espesor_2;
    
            curv_1 = mod(naca_cruce1,10000) - maxc_1 - espesor_1;
            curv_2 = mod(naca_cruce2,10000) - maxc_2 - espesor_2;
    
            %Se selecciona otro perfil que no sea simetrico
            while mod(naca_cruce1,1000) - mod(naca_cruce1,100) == 0
                cruc1 = randi(num_pobla);
                while cruc1 == cruc2
                    cruc1 = randi(num_pobla);
                end
                naca_cruce1 = obt_NACA(coef(cruc1).name);
                espesor_1 = mod(naca_cruce1,100);
                maxc_1 = mod(naca_cruce1,1000) - espesor_1;
                curv_1 = mod(naca_cruce1,10000) - maxc_1 - espesor_1;
            end
    
            while mod(naca_cruce2,1000) - mod(naca_cruce2,100) == 0
                cruc2 = randi(num_pobla);
                while cruc2 == cruc1
                    cruc2 = randi(num_pobla);
                end
                naca_cruce2 = obt_NACA(coef(cruc2).name);
                espesor_2 = mod(naca_cruce2,100);
                maxc_2 = mod(naca_cruce2,1000) - espesor_2;
                curv_2 = mod(naca_cruce2,10000) - maxc_2 - espesor_2;
            end
    
            %Nivel de cruce  
            level = randi(3);
            if level == 1
            %Nivel 1: Se cambian los espesores
                naca_cruzado1 = curv_1 + maxc_1 + espesor_2;
                naca_cruzado2 = curv_2 + maxc_2 + espesor_1;

            elseif level == 2
            %Nivel 2: Se va a cambiar la posicion de maxima curvatura
               naca_cruzado1 = curv_1 + maxc_2 + espesor_1;
               naca_cruzado2 = curv_2 + maxc_1 + espesor_2;

            elseif level == 3
            %Nivel 3: Se va a cambiar la curvatura
                naca_cruzado1 = curv_2 + maxc_1 + espesor_1;
                naca_cruzado2 = curv_1 + maxc_2 + espesor_2;
                
            end

            coef_cruz(i).name = char(sprintf("NACA%04d", naca_cruzado1));
            coef_cruz(i + 1).name = char(sprintf("NACA%04d", naca_cruzado2));
    
        end
    end
end


