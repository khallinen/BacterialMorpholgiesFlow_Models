function [cell_pos] = createChain(initialCells)
%create a chain of some random length (say 5-6 cells) 
%initialize that chain on a 2D grid (x and z) 

%at each time point need to consider the forces on the cells-
%there is a drag force on each cell from being in flow, but then the total
%force has to also account for all of the cells in the chain that are
%pulling on it.


%In this chain, each cell will start centered at a x position with a distance x between each cells
%The cells are connected by strings, all will same spring constant, and the
%unstreteched spring length would be 1 unit betweeen each cell. As the
%simulation runs, the cells move around (pulled by the cells at the end of
%the chain, pushed down by the flow). I want to initialize the cells such
%that they are close to their ideal chain


%Forces in x- the spring force from the cells farther along the chain, as
%well as the drag force from the flow
%Forces in y- the flow pushing the chain down, as well as the y components
%of the spring force ie bending and extension


num_cells = initialCells; %random numnber, frrom run MultipleChains

%intialize cells on the grid
cell_x = zeros(1,num_cells);
cell_y = zeros (1,num_cells);
%start first cell at position 1,1
cell_x(1) = 0;
cell_y(1) = 0;


%if cells are all distance 1 apart, then we should have no spring force to
%start. Initialize this (and at 45 degree angle)
for i = 2:num_cells
    cell_x(i) = (cell_x(i-1)+sqrt(0.5));
    cell_y(i) = (cell_y(i-1)+sqrt(0.5));
end


cell_pos = [cell_x; cell_y]';
%plot(cell_x, cell_y, 'o-')


end 



 