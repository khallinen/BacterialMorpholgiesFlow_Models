function [spring_force, tension] = calculateSpringForce(cell_pos)

%standard 'spring' length for between the cells would be 1, the length
%when two cells are at the same y position (such as the chain on the
%surface and not stretched 

%calculate the force on each cell (and keep track of it, as it will effect
%the forces on the cells before it)

%Also use this to calculate a tension and keep track of that 

totalcells = size(cell_pos);
num_cells = totalcells(1);

ks = 1; 
l0 = 1;

spring_force = zeros(num_cells,2);
tension = zeros(num_cells, 2);
%force on the force bead is only from the bead to the right 

if num_cells>1 %otherwise we have a chain of 1 
    for i = 1:num_cells
        beadx = cell_pos(i,1);
        beady = cell_pos(i,2);
        if i ==1
            %there is no cell to the left
            beadrightx = cell_pos(i+1,1);
            beadrighty = cell_pos(i+1,2);
            rightDistanceX = beadx-beadrightx;
            rightDistanceY = beady-beadrighty;
            magnitude_right = sqrt((rightDistanceX)^2+(rightDistanceY)^2);
            force_rightX = -(ks*(rightDistanceX)*(magnitude_right-l0))/magnitude_right;
            force_rightY = -(ks*(rightDistanceY)*(magnitude_right-l0))/magnitude_right;
            spring_force(i,:) = [force_rightX, force_rightY];
    
            tension_right = ks*(magnitude_right-l0);
            tension(i,:) = [0, tension_right];
    
        elseif i == num_cells
            %We are at the last cell, there is no cell right 
            beadleftx = cell_pos(i-1,1);
            beadlefty = cell_pos(i-1,2);
            leftDistanceX = beadx-beadleftx;
            leftDistanceY = beady-beadlefty;
            magnitude_left = sqrt((leftDistanceX)^2+(leftDistanceY)^2);
            force_leftX = -(ks*(leftDistanceX)*(magnitude_left-l0))/magnitude_left;
            force_leftY = -(ks*(leftDistanceY)*(magnitude_left-l0))/magnitude_left;
            spring_force(i,:) = [force_leftX, force_leftY];
    
            tension_left = ks*(magnitude_left -l0);
            tension(i,:) = [tension_left, 0];
    
        else  %we are at a middle bead that has right and left cells 
            beadleftx = cell_pos(i-1,1);
            beadlefty = cell_pos(i-1,2);
            leftDistanceX = beadx-beadleftx;
            leftDistanceY = beady-beadlefty;
            magnitude_left = sqrt((leftDistanceX)^2+(leftDistanceY)^2);
            force_leftX = -(ks*(leftDistanceX)*(magnitude_left-l0))/magnitude_left;
            force_leftY = -(ks*(leftDistanceY)*(magnitude_left-l0))/magnitude_left;
    
    
            beadrightx = cell_pos(i+1,1);
            beadrighty = cell_pos(i+1,2);
            rightDistanceX = beadx-beadrightx;
            rightDistanceY = beady-beadrighty;
            magnitude_right = sqrt((rightDistanceX)^2+(rightDistanceY)^2);
            force_rightX = -(ks*(rightDistanceX)*(magnitude_right-l0))/magnitude_right;
            force_rightY = -(ks*(rightDistanceY)*(magnitude_right-l0))/magnitude_right;
    
            spring_force(i,:) = [force_leftX+force_rightX, force_leftY+force_rightY];
    
            tension_right = ks*(magnitude_right-l0);
            tension_left = ks*(magnitude_left -l0);
            tension(i,:) = [tension_left, tension_right];
         
        end
    end
end

end



