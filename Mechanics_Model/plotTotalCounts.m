function [tot_high, tot_low] = plotTotalCounts(low, low2,low3, high, high2, high3)

%load in the low and high datasets that have the total number of cells
%every ~30 minutes if we take the entire run to be about 6 hours 

load(low)
load(high)


load(low2)
load(high2)


load(low3)
load(high3)


for i = 1:100 %we run the simulation 100 times
    a = totalCounts_High(i).length;
    b = totalCounts_Low(i).length; 
    numChains_high = length(a);
    numChains_low = length(b);

    c = totalCounts_High2(i).length;
    d = totalCounts_Low2(i).length; 
    numChains_high2 = length(c);
    numChains_low2 = length(d);

    e = totalCounts_High3(i).length;
    f = totalCounts_Low3(i).length; 
    numChains_high3 = length(e);
    numChains_low3 = length(f);

    if numChains_high < 13 %we have 13 total lengths if the run completed 
        a(numChains_high+1:13) = 0;
        chain_high(:,i) = a;
    else
        chain_high(:, i) = a;
    end

    if numChains_low < 13 %we have 13 total lengths if the run completed 
        b(numChains_low+1:13) = 0;
        chain_low(:,i) = b;
    else
        chain_low(:, i) = b;
    end

    if numChains_high2 < 13 %we have 13 total lengths if the run completed 
        c(numChains_high2+1:13) = 0;
        chain_high2(:,i) = c;
    else
        chain_high2(:, i) = c;
    end

    if numChains_low2 < 13 %we have 13 total lengths if the run completed 
        d(numChains_low2+1:13) = 0;
        chain_low2(:,i) = d;
    else
        chain_low2(:, i) = d;
    end


    if numChains_high3 < 13 %we have 13 total lengths if the run completed 
        e(numChains_high3+1:13) = 0;
        chain_high3(:,i) = e;
    else
        chain_high3(:, i) = e;
    end

    if numChains_low3 < 13 %we have 13 total lengths if the run completed 
        f(numChains_low3+1:13) = 0;
        chain_low3(:,i) = f;
    else
        chain_low3(:, i) = f;
    end


end

tot_high1 = sum(chain_high,2);
tot_high2 = sum(chain_high2, 2);
tot_high3 = sum(chain_high3, 2);


tot_low1 = sum(chain_low,2);
tot_low2 = sum(chain_low2, 2);
tot_low3 = sum(chain_low3, 2);

%normalize 
norm_high1 = tot_high1/tot_high1(1);
norm_high2 = tot_high2/tot_high2(1);
norm_high3 = tot_high3/tot_high3(1);

norm_low1 = tot_low1/tot_low1(1);
norm_low2 = tot_low2/tot_low2(1);
norm_low3 = tot_low3/tot_low3(1);

%average together 
all_high = [norm_high1, norm_high2, norm_high3];
all_low = [norm_low1, norm_low2, norm_low3];

tot_high = mean(all_high,2);
tot_low = mean(all_low,2);

SEM_high = std(all_high, 0,2)/sqrt(3);
SEM_low = std(all_low, 0, 2)/sqrt(3);



x = [0 6 12 18 24 30 36 42 48 54 60 66 72];

figure
errorbar(x, tot_low, SEM_low, 'r','LineWidth', 3)
hold on 
errorbar(x, tot_high, SEM_high, 'b','LineWidth', 3)
xticklabels({'0','1','2','3','4','5','6'})
xticks([0 12 24 36 48 60 72])
xlabel('Simulated Time (Hours)', 'FontSize',16)
ylabel('Total Cells-Fold Change','FontSize',16)
axis square
ax = gca;
ax.FontSize = 14; 

end