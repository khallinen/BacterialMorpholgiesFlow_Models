function [drag_force] = calculateFlowForce(cell, flowRate)

%for this, just treat the drag force as in x only, but the strength of it
%depends on y (ie the higher the cell is in y, the larger of an effect
%they feel from the force. Treat it as linear to start. 


cell_y = cell(2);
flow = flowRate; %this could change: some constant that is multipled by the height
const = 1;

drag_force = [0,0]; %even though the force only acts in y, just for consistency with adding with other forces

drag = const*flow*cell_y;

drag_force(1) = drag;


end