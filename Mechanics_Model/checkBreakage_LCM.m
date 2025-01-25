function [updated_withBreakage_pos, anchor_number, distal_adhered, breakage] = checkBreakage_LCM(cell_pos, tension)

%check the tension and use that to see if the chain breaks

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
    if left_tension >0.022 %%only check springs that are stretched.  
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
                if position_y < 0.000005 %35  %Is this too stringent (ie I'm not getting many distal cells attached since they are rarely exactly 0.)
                    distal_adhered = 1;
                end
            end
        end
    end
end

breakList(end+1) = num_cells; %if we don't break, pass the whole list back
%unncessary.

updated_withBreakage_pos = cell_pos(1:breakList(1), :);



end