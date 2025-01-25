function [cell_pos_detach] = checkSurfaceDetach(cell_pos, dt)

%Check if a cell position is already at 0/attached.
totalcells = size(cell_pos);
num_cells = totalcells(1);

cell_pos_detach = cell_pos;
if num_cells >1
    for i = 2:num_cells
        if cell_pos(i,2) == 0 %our cell is already attached. Check to see if it detaches 
            cell_left = cell_pos(i-1,2);
            if i ~= num_cells %check attachment of cell to the right 
                cell_right = cell_pos(i+1, 2);
            else
                cell_right = 0;
            end
            neighborCells= cell_left+cell_right;

            prob_detach = exp(-5+neighborCells); %this probability should increase if the cell next to you is not attached. 
            randomChance = rand(1,1); 
    
            if randomChance < prob_detach  %we detach and move in y 
                %anchor detaches from surface, move it as the forces acting on it would
                %gaussian_x = dt*normrnd(0,0.1);
                gaussian_y = normrnd(0,0.01);
        
                %cell_pos_detach(i,1) = cell_pos(i,1) + gaussian_x; Stay at the
                %same x position since 
                cell_pos_detach(i,2) = cell_pos(i,2) + abs(gaussian_y);
            end 
        end 
    end
end 

end
