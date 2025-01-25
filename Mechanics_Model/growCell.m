function [updated_cell_pos] = growCell(cell_pos)

%this is the function to add a new cell onto the chain. It will add a cell
%every 45/50 minutes (so ~ time steps if we take a step to be 5 minutes
%like the experiments are)

%find the position of the last cell in the chain, then find an x and y that
%are near that. I think I will start that it is initialized distance 1 away
%in x

totalcells = size(cell_pos);
num_cell = totalcells(1);

end_x = cell_pos(num_cell, 1);
end_y = cell_pos(num_cell, 2);

if num_cell >1
%put the next cell at distance 1 position away in x and y
%check what angle we're at and try to initalize the new cell close to that?

    distance_x =  cell_pos(num_cell,1) - cell_pos(num_cell-1,1); %find the distances between current end cell and cell end-1. Use that distance to initalize our new cell. 
    distance_y = cell_pos(num_cell,2) - cell_pos(num_cell-1,2);
else  %we only have 1 cell, place next cell at 45 degrees 
    distance_x = sqrt(0.5);
    distance_y = sqrt(0.5);
end


new_x = end_x +distance_x;


new_y = end_y + distance_y;


%Check that we don't put the new cell negative
% 
% if new_y <0 %we are negative/below surface. Reset this to the surface + a little gaussian wiggle 
%     new_y = abs(normrnd(0,0.025));
% end

% %Need to put in function here to check if it adheres? Or it can't adhere
% until the next time step?
% height = new_y;
% prob_adhere = lambda*exp(-lambda*height);
% randomAdhere = rand(1,1);
% if randomAdhere < prob_adhere
%     new_y = 0; %we adhere to the surface
% end 


updated_cell_pos = cell_pos;
updated_cell_pos(num_cell+1, :) = [new_x, new_y];

end
