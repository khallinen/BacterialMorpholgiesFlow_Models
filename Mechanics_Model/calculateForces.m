function [totalForce, tension] = calculateForces(cell_pos, flowRate)

totalcells = size(cell_pos);
num_cells = totalcells(1);

[spring, tension] = calculateSpringForce(cell_pos);

drag_force = zeros(num_cells, 2);
bending = zeros(num_cells, 2);

for i = 1:num_cells
    cell = cell_pos(i, :); %get position of each cell 
    drag_force(i, :) = calculateFlowForce(cell, flowRate);
    if i >1 && i < num_cells %we're not at the first or last cell, there is a bending force 
        cell_left = cell_pos(i-1,:);
        cell_right = cell_pos(i+1, :);
        bf = bending_Force(cell_left, cell, cell_right);
        bending(i-1:i+1,:) = (bending(i-1:i+1,:) + bf);
    end
end 


totalForce = spring + drag_force + bending;

end

