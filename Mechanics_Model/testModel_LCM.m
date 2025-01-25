function [anchor_detach_count_total, distal_attach_count_total, total_anchor_adhered , total_distal_adhered, total_breakage, total_length] = testModel_LCM(flowRate, initialCells)

[cell_pos] = createChain(initialCells); % make chain 


%Don't move the first cell
dt = 0.01;
gamma =1;

total_anchor_adhered = [];
total_distal_adhered = [];
total_breakage = [];

anchor_detach_count_total = [];
distal_attach_count_total = [];
total_length = [];


for i = 1:1000000 
    totalcells = size(cell_pos);
    if totalcells(1) ==0
        %our chain has detached. stop the simulation for this chain 
        %i 
        %title('Anchor Detached')
        break 
        
    end
    new_pos = cell_pos(1,:); %Don't move the first cell, reset new_pos every loop
    [totalForces, tension] = calculateForces(cell_pos, flowRate);
    if totalcells(1) > 1
        if cell_pos(1,2) ~=0 %we have detached our anchor, update its position 
            new_pos(1:length(cell_pos),:) = cell_pos(1:end,:)+dt*gamma*totalForces(1:end,:);
            for j =1:length(new_pos)
                gaussian_x = dt*normrnd(0,0.1);
                gaussian_y = dt*normrnd(0,0.1);
        
                new_pos(j,1) = new_pos(j,1) + gaussian_x;
                new_pos(j,2) = new_pos(j,2) + gaussian_y;
                %I also want to check that this stays within the bounds of either
                %cell around it. ie we don't have chains crossing each other 
        
                
                if new_pos(j,2) < 0 %we've gone negative. Reset to the surface+wiggle            
                    new_pos(j,2) = dt*abs(gaussian_x);
                end
                if new_pos(j,1) < 0 %we've gone negative. Reset to the wall+wiggle  
                    new_pos(j,1) = dt*abs(gaussian_y);
                end
            end
        else
            new_pos(2:length(cell_pos),:) = cell_pos(2:end,:)+dt*gamma*totalForces(2:end,:);
        
            %check that these postions don't go negative and add gaussian wiggle. 
            for j =2:length(new_pos)
                gaussian_x = dt*normrnd(0,0.1);
                gaussian_y = dt*normrnd(0,0.1);
        
                new_pos(j,1) = new_pos(j,1) + gaussian_x;
                new_pos(j,2) = new_pos(j,2) + gaussian_y;
                %I also want to check that this stays within the bounds of either
                %cell around it. ie we don't have chains crossing each other 
        
                
                if new_pos(j,2) < 0 %we've gone negative. Reset to the surface+wiggle            
                    new_pos(j,2) = dt*abs(gaussian_x);
                end
                if new_pos(j,1) < 0 %we've gone negative. Reset to the wall+wiggle  
                    new_pos(j,1) = dt*abs(gaussian_y);
                end
            end
        end
    end
    %cell_pos = new_pos;
       %now check to see if the cells adhere
    cell_pos_adhere = checkAdherence(new_pos);

    %and check to see if the cells detach 
    cell_pos_detach = checkSurfaceDetach(cell_pos_adhere, dt);
    
    %cell_pos = cell_pos_detach;

    if totalcells(1) >1  %if we are only 1 cell, we don't check if the cells break 
        %use tension to check if chains break 
        [cell_pos_break, anchor_num, distal_adhered, breakage] = checkBreakage_LCM(cell_pos_detach, tension);
        cell_pos = cell_pos_break;
        if breakage == 1
            sz = size(total_breakage);
            total_anchor_adhered(sz(2)+1) = anchor_num;
            total_distal_adhered(sz(2)+1) = distal_adhered;
        
            total_breakage(sz(2)+1) = breakage;
        end
    else
        cell_pos = cell_pos_detach;
    end

    [cell_pos, anchor_detach_count, distal_attach_count] = checkAnchorDetach(cell_pos);
    if anchor_detach_count == 1
        s_anchor = size(anchor_detach_count_total);
        anchor_detach_count_total(s_anchor(2)+1) = anchor_detach_count; %for a chain, keep track of how many time the anchor detaches 
        distal_attach_count_total(s_anchor(2)+1) = distal_attach_count; %for a chain, keep track of how many time the anchor detaches 
    end

    if mod(i,20000) == 0  
        cell_pos = growCell(cell_pos);
        %plot(cell_pos(:,1), cell_pos(:,2), 'o-')
  
    end
    
    if mod(i, 83333) == 0
        total_size = size(cell_pos);
        total_length(end+1) = total_size(1);
    end

end


total_size = size(cell_pos);
total_length(end+1) = total_size(1);
end    