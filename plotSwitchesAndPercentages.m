% Nick Lavrov
% 
% Runs the SPP Model and identifies each time the
% alignment switches, defining a 'switch point.'
% Then goes every (stepIncrement) back from that 
% switch point up to (totalStepsBack) and reruns
% the simulation 30 times and tracks how many times
% a switch occurs, creating a switch fraction.
% Then plots the positions and alignment of the
% original simulation, the switch fraction at each
% switch point, and the average switch fraction

numLocusts = 30; % number of locusts
N = 5000; % number of steps
dt = 1; % size of step
r = 4; % interaction radius
length = 90; % length of domain
totalStepsBack = 40; % furthest to look before switch point
stepIncrement = 1; % how much to step back from switch point until total

% The main function call
[x,u,a,sp,spa,studied,switchPercentAtBlock] = ...
    switchFrequency(numLocusts, N, dt, r, length,...
    totalStepsBack, stepIncrement);

% plot positions
figure(1);
plot(x, '.');
xlabel('Time');ylabel('Position');

% plot alignment and switch markers
figure(2);
plot(a);hold on;plot(sp,spa,'red');hold off;
xlabel('Time');ylabel('Alignment');

numSwitches = size(switchPercentAtBlock,2);

% check if a switch occurred before plotting
if (numSwitches) 

    % plot the switch percent for each switch point for
    % each step before the switch point
    figure(3);
    plot(0:stepIncrement:totalStepsBack,switchPercentAtBlock);
    xlabel('Steps before switch point');
    ylabel('Switch percentage');
    ylim([0 1]);
    
    switch numSwitches
        case 1
            legend(['t=' num2str(studied(1))]);
        case 2
            legend(['t=' num2str(studied(1))], ['t=' num2str(studied(2))]);
        case 3
            legend(['t=' num2str(studied(1))],...
                ['t=' num2str(studied(2))], ['t=' num2str(studied(3))]);
        otherwise
            legend(['t=' num2str(studied(1))],...
                ['t=' num2str(studied(2))], ['t=' num2str(studied(3))]);
    end
    
    if (numSwitches > 1)
    
        % then plot the average switch percent
        figure(4);
        plot(0:stepIncrement:totalStepsBack,mean(switchPercentAtBlock.'));
        xlabel('Steps before switch point');
        ylabel('Average switch percentage');
        ylim([0 1]);
    end
    
end