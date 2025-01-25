function [new_cell_pos] = moveCells(cell_pos, forces, lambda, flowRate)

%take the forces and apply to move the cells 

num_cells = length(cell_pos);
new_cell_pos = zeros(num_cells, 2);

% lambda sets how strong of a probability that we adhere, can change


updated_pos = cell_pos + forces;


updated_pos = checkSurfaceDetach(cell_pos, updated_pos); %Goes through and looks at our currently attached cells, checks if they will detach

updated_withAdherence_pos = checkAdherence(updated_pos, flowRate, lambda); %looks at cells that are not adhered/haven't detached

updated_withBreakage_pos = checkBreakage(updated_withAdherence_pos, forces);

new_num_cells = length(updated_withBreakage_pos);

for j = 1:new_num_cells
    if cell_pos(j,2) ~= 0 %this is a cell that is not attached to the surface
        gaussian_x = normrnd(0,0.05);
        gaussian_y = normrnd(0,0.05);
        
        new_cell_pos(j,1) = updated_withBreakage_pos(j, 1) + gaussian_x;

        if updated_withBreakage_pos(j, 2) + gaussian_y < 0 %adding the gaussian wiggle makes us go negative, but in the adherence check we didn't adhere (ie we aren't at 0)
            new_cell_pos(j,2) = updated_withBreakage_pos(j, 2); % don't add gaussian wiggle
        else
            new_cell_pos(j,2) = updated_withBreakage_pos(j, 2)+ gaussian_y;
        end
    else
        new_cell_pos(j,1) = updated_withBreakage_pos(j, 1); % no gaussian movement because we're on the surface. But maybe we shouldn't move at all if we were previously adhered. 
        new_cell_pos(j,2) = updated_withBreakage_pos(j, 2); 
    end

end


%NEED TO DO:
%Also consider can't go beyond the cell positions to their left or right 
%Probability of detachment if in chain (based on the x force)

end