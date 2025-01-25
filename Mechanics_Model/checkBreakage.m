function [updated_withBreakage_pos, anchor_number, distal_adhered, breakage] = checkBreakage(cell_pos, tension)

%check the force in x (or total force) and use that (with a probability to see if the chain
%breaks based on some term that depends on the force)

omega_break = 0.01;


num_cells = length(cell_pos);

breakList = [];

breakage = 0;
anchor_number = 0;
distal_adhered = 0;

%Check this- ie if we break once do we keep checking for breaking 

for i = 1:num_cells
    left_tension = tension(i,1); %check the tension to the left only. ie if the chain to the left is overstretched, then the chain breaks and all cells to the right of that spring break off. 
    %should this be an exponential? 
    if left_tension >0.02 %only check springs that are stretched. Otherwise, not worth it/would not break from tension 
        exponential = exp((-omega_break*left_tension));
        prob_break = 1- exponential;
        randomChance = rand(1,1);            

        if randomChance < prob_break
            %cells detach and disappear
            breakage = 1;
            anchor_number = 1;
            breakList(end+1) = i-1; %Keep track of where the chain breaks. This is the cell to the left of the break 
        end
        %breakList
        if ~isempty(breakList) %we break. See if cells to the left of the break are adhered and may stick? Don't actually keep track of 2nd chain (at least to start), but keep track the the chain could've been adhered
            for j = (breakList(1)+1):num_cells %we start to the cell to the right, since those are the cells that might disappear because chain broke to their left
                %j
                position_y = cell_pos(j, 2);
                if position_y < 0.0000035 %very close to surface, as we are unlikely to be at exacly 0
                    distal_adhered = 1;
                end
            end
        end
    end
end

breakList(end+1) = num_cells; %if we don't break, pass the whole list back
%unncessary. The last position has tension of 0 and will always be added
%(ie e = 1)
%but this will also mess with positions where we initalize a cell that is
%at length 0
%if the break happens and other cells are adhered, just have those between
%the break and the next adhered disappear? 
%would need to start keeping track of two chains then...

updated_withBreakage_pos = cell_pos(1:breakList(1), :);



end