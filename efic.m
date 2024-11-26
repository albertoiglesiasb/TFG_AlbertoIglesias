function [coef] = efic(coef)
    
    for i = 1:length(coef)
        coef(i).E = coef(i).CL ./ coef(i).CD;
    end
    
end

