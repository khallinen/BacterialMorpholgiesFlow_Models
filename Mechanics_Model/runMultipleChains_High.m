
%script to run 100 chains of high flow
%Don't show plots

totalCounts_High = struct();


for i = 1:100
    num_cells = randsample(1:5,1); 

    [a_detach, distal_attach, total_anchor_after_break, total_distal_after_break, total_break, length] = testModel(0.01, num_cells);
    totalCounts_High(i).anchorDetach = a_detach;
    totalCounts_High(i).distalAttached = distal_attach;
    totalCounts_High(i).total_anchor_after_break = total_anchor_after_break;
    totalCounts_High(i).total_distal_after_break = total_distal_after_break;
    totalCounts_High(i).total_break = total_break;
    totalCounts_High(i).length = length;
end 

