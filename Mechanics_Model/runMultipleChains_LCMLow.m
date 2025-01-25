
%script to run 100 chains of low flow with the long chain mutant

%totalCounts_High = struct();
totalCounts_Low = struct();


for i = 1:100
    num_cells = randsample(2:6,1); %use 2-6 for LCM

    [a_detachL, distal_attachL, total_anchor_after_breakL, total_distal_after_breakL, total_breakL, lengthL] = testModel_LCM(0.001, num_cells);
    totalCounts_Low(i).anchorDetach = a_detachL;
    totalCounts_Low(i).distalAttached = distal_attachL;
    totalCounts_Low(i).total_anchor_after_break = total_anchor_after_breakL;
    totalCounts_Low(i).total_distal_after_break = total_distal_after_breakL;
    totalCounts_Low(i).total_break = total_breakL;
    totalCounts_Low(i).length = lengthL;
end 

