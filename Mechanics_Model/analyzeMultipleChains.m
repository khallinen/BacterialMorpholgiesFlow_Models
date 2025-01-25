function [averageLength, fraction_anchor_attached, fraction_distal_attached, anchor_attached, distal_attached] = analyzeMultipleChains(chainStruct)

totalNumChains = length(chainStruct);
chains_toAverage = [];
anchor_attached = [];
distal_attached = [];

for i = 1:totalNumChains 
    if chainStruct(i).length(end) ~=0
        %this chain didn't totally detach. Count it in our average
        chains_toAverage(end+1) = chainStruct(i).length(end);
    end

    for j = 1:length(chainStruct(i).anchorDetach) 
        %step through all the times we lose our anchor. 
        if chainStruct(i).anchorDetach(j) == 1
            anchor_attached(end+1) = 0; %during the break, our anchor detaches
            distal_attached(end+1) = chainStruct(i).distalAttached(j); %keep track of if our distal chain is there even if we lose the anchor
        end
    end

    for k = 1:length(chainStruct(i).total_break) %this is the number of times the chain breaks in the middle 
        anchor_attached(end+1) = chainStruct(i).total_anchor_after_break(k);
        distal_attached(end+1) = chainStruct(i).total_distal_after_break(k);
    end 


end


averageLength = mean(chains_toAverage);

fraction_anchor_attached = mean(anchor_attached);
fraction_distal_attached = mean(distal_attached);

totalBreakages = length(anchor_attached);


SEM_anchor_attached = std(anchor_attached)/sqrt(totalBreakages);

SEM_distal_attached = std(distal_attached)/sqrt(totalBreakages);


end