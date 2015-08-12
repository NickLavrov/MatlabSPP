% switchFrequency.m
% Nick Lavrov '15
% Princeton University

function [x,u,a,sp,spa,studied,switchPercentAtBlock] = ...
    switchFrequency(numLocusts, N, dt, r, length,...
    totalStepsBack, stepIncrement)

% Runs SPPModel2 with the given inputs, then
% runs switchPoints on the output. Restarts
% simulation with given state at each switch
% point for (totalStepsBack) points before 
% the point a total of 30 times and finds the 
% percent that result in a switch in alignment.

[x,u,a]=SPPModel2(numLocusts, N, dt, r, length);
[sp,spa]=switchPoints(a);

trials = 30; % number of times at each initialization
% totalStepsBack = 40; % furthest to look before switch point
% stepIncrement = 1; % how much to step back from switch point until total

minBlockSize = 450; % number of steps aligment should be maintained

totalBlocksStudied = 0;
totalBlocks = numel(sp)/2 - 1;
switchPercentAtBlock = zeros(floor(totalStepsBack/stepIncrement + 1),...
    totalBlocks);
studied=zeros(1,totalBlocks);
% each row represents how far back we're going
% each column is an individual block

% at each startSwitchPoint in sp
for i = 1:totalBlocks-1
    switchTime = sp(2*i + 1);
    % only go if the block > 450 steps
    if switchTime - sp(2*i) > minBlockSize
        totalBlocksStudied = totalBlocksStudied+1;
        studied(totalBlocksStudied)=switchTime;
        % to keep track of progress, uncomment the line below.
        % display([num2str(switchTime) ': ' num2str(totalBlocksStudied)]);
        % for each stepIncrement back until totalStepsBack
        for j = 1:floor(totalStepsBack/stepIncrement + 1)
            timeBack = stepIncrement*(j-1);
            startTime = switchTime - timeBack;
            t = timeBack+25; % run trial up until switchpoint and then some
            % repeat trials
            for k = 1:trials
                switchPercentAtBlock(j,i) = switchPercentAtBlock(j,i)+...
                switchChecker(x(startTime,:),u(startTime,:),t,dt,r,length);
            end
            switchPercentAtBlock(j,i) = switchPercentAtBlock(j,i)/trials;
        end
    end
end

% remove zeros from small blocks
switchPercentAtBlock = switchPercentAtBlock(:,any(switchPercentAtBlock));
studied = studied(any(studied,1));


