function [cell_pos_withAdherence] = checkAdherence(cell_pos)

totalcells = size(cell_pos);
num_cells = totalcells(1);

cell_pos_withAdherence = cell_pos;

constant = 0.2; %some constant in front of the exponent, can change
lambda = 3; %some constant in the exponent, can change

tenPercentHeight = (-1/lambda)*log(0.1/constant);

if num_cells >1
    for i = 1:num_cells  %start at 2 since first position is anchor 
        %check some probability that the cell will adhere to the surface, this
        %depends on the height of the cell 
        if cell_pos(i,2) ~= 0 %We aren't already adhered 
            %calculate prob of adherence-
            cellHeight = cell_pos(i,2);
            if cellHeight < tenPercentHeight % we have more than a ten percent chance of adhering. Check if we do.
                probAdhere = constant*exp(-lambda*cellHeight);
                randomAdhere = rand(1,1);
                if randomAdhere < probAdhere
                    cell_pos_withAdherence(i,2) = 0; %we adhere to the surface
                end 
            end
        end
    end
end 


end