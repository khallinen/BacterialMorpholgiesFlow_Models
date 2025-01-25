% Parameters


% Define ranges for q and n0
q_values = [0.2,2]; % 0.1:0.05:1.0; % Define the range of q values
n0_values = [0.015, 0.015]; %0.25 %0.1:0.1:1.0; % Define the range of n0 values


for i = 1:length(q_values)
    q = q_values(i);
    n0 = n0_values(i);


    % Initial conditions


        g = 1.4; % Growth rate, slower for EF
        tc = 1 / g;
        B = -2; % Strength of AIP/dispersal
        k = 50;% Environmental threshold concentration/half maximal concentration 50 works
        p = 1.05;  % Production rate
        h = 2;% Hill coefficient
        x0 = 0;% Initial environmental concentration
        
        % Ratio
        d = (B)/(g); % Dispersal ratio
        f = q / g; % Transport ratio

        
        % Define the ODE system
        odeSystem = @(t, y) [
            y(1) + d*y(1)*((y(2)^h)/((y(2)^h)+1))
            y(1) - y(2) * f
        ];

        initialConditions = [n0; x0];

        % Time span for integration
        tspan = [0, 8.4];
    
        % Solve the ODEs
        [t, y] = ode45(odeSystem, tspan, initialConditions);
        
        % Extract the solutions
        n = y(:, 1);
        x = y(:, 2);

        c = p*n/q;
        hold on 
        if i == 1
            plot(t, n, 'r' ,'LineWidth', 2);
        else
            plot(t, n, 'b', 'LineWidth', 2);
        end
        xlabel('Time (t)', 'FontSize', 16);
        ylabel('Total n', 'FontSize', 16);
        

        xlim([0,8.5])
        axis square
        box on
        ax = gca;
        ax.FontSize = 16; 
        xticks([0 1.4 2.8 4.2 5.6 7 8.4])
        xticklabels({'0' '1' '2' '3' '4' '5' '6'})
        yticks([0 0.75 1.5 2.25 3.0 3.75])
        yticklabels({'0' '50' '100' '150' '200' '250'})



end


legend({'Low Flow', 'High Flow'}, 'location', 'northwest');


