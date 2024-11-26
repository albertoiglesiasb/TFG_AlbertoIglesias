function [coord] = coordNaca5(vecNACA)
    
    coord = struct('name',[],'coor',[]);

    iaf.n=81;
    iaf.HalfCosineSpacing=1;
    iaf.wantFile=0;
    iaf.is_finiteTE=0;

    for i = 1:length(vecNACA)

        iaf.designation = char(vecNACA(i));

        aux = naca5gen(iaf);
        aux2(:,1) = aux.x;
        aux2(:,2) = aux.z;
        coord(i).coor = aux2;
        coord(i).name = aux.name;

    end
    
end