function [cell_pos_anchor, anchor_detach_count, distal_attach_count]= checkAnchorDetach(cell_pos)

%sometimes the anchor detaches too- Check this independently of the other
%detachments.
%If no other cells are attached, then the entire chain disappears and we
%stop the simulation for that chain 


totalcells = size(cell_pos);
num_cells = totalcells(1);
attachList = [];
anchor_detach_count = 0;
distal_attach_count = 0;

%currently set this as like 0.1% of the time?
cell_pos_anchor= cell_pos;

prob_detach = 1E-6;  
randomChance = rand(1,1);
if prob_detach >randomChance
    anchor_detach_count = 1;
    cell_pos_anchor(1, 2) = abs(normrnd(0,0.05));
    %now check to see if other cells are attached
    for i = 1:num_cells
        if cell_pos_anchor(i,2) < 0.0000035 %there is another attached cell.
            attachList(end+1) = i;
        end
    end
    if isempty(attachList)
        %no cells are attached, chain disappears
        cell_pos_anchor = [];
    else
        cell_pos_anchor = cell_pos_anchor(attachList(1):end, :); %set the new cell to be reset to the anchor
        distal_attach_count = 1; %keep track if we have a remaining distal chain without the anchor 
    end
end




end