
%script to run 100 chains of low flow
%Don't show plots

totalCounts_Low = struct();


for i = 1:100
    num_cells = randsample(1:5,1); %use 2-6 for LCM, 1-5 for WT

    [a_detachL, distal_attachL, total_anchor_after_breakL, total_distal_after_breakL, total_breakL, lengthL] = testModel(0.001, num_cells);
    totalCounts_Low(i).anchorDetach = a_detachL;
    totalCounts_Low(i).distalAttached = distal_attachL;
    totalCounts_Low(i).total_anchor_after_break = total_anchor_after_breakL;
    totalCounts_Low(i).total_distal_after_break = total_distal_after_breakL;
    totalCounts_Low(i).total_break = total_breakL;
    totalCounts_Low(i).length = lengthL;
end 

