% switchPoints.m
% Nick Lavrov '15
% Princeton University

function [switchPointsArray, alignmentArray] = switchPoints(alignment)
% Returns indices of the alignment array and the alignment sign
% where switches have started and ended.

% Constants
startSwitchThreshold = 0.0; % alignment at the start of a switch 
endSwitchThreshold = -0.5; % alignment at the end of a switch 
stabilityLength = 40; % min length to sustain alignment to be considered
                      % as a switch
dropFirstStep = 100; % ignore the first 100 steps of the simulation 

% State checkers
alignmentState = 1;
isStabilized = false;
stableCounter = 0;

% Initialize arrays to store switch points
switchPointsArray = zeros(numel(alignment),1);
alignmentArray = zeros(numel(alignment),1);
currentSwitchIndex = 1;
tempSwitchStart = 1;
tempSwitchEnd = 1;

% Make sure not to start at a switching point
% Get initial alignment state
while ~isStabilized
    alignmentState = sign(alignment(dropFirstStep));
    a = alignment(dropFirstStep:dropFirstStep+stabilityLength*2);
    b = sign(a) == alignmentState;
    if (~all(b))
        dropFirstStep = dropFirstStep+stabilityLength;
    else
        isStabilized = true;
    end
end

% Main loop
for i = dropFirstStep:numel(alignment)-stabilityLength
    if sign(alignment(i)) ~= alignmentState
        % start counting to see if stable state is long enough
        stableCounter = stableCounter + 1;
        if stableCounter > stabilityLength
            %go back until a<-0.5, end of switch
            %go back until a<0.0, start of switch
            j=i;
            if alignmentState == 1
                while  alignment(j) < endSwitchThreshold
                    j = j - 1;
                end
                tempSwitchEnd = j;
                while  alignment(j) < startSwitchThreshold
                    j = j - 1;
                end
                tempSwitchStart = j;
            end
            if alignmentState == -1
                while  alignment(j) > -endSwitchThreshold
                    j = j - 1;
                end
                tempSwitchEnd = j;
                while  alignment(j) > -startSwitchThreshold
                    j = j - 1;
                end
                tempSwitchStart = j;
            end
            switchPointsArray(currentSwitchIndex) = tempSwitchStart;
            switchPointsArray(currentSwitchIndex+1) = tempSwitchEnd;
            alignmentArray(currentSwitchIndex) = alignmentState;
            alignmentArray(currentSwitchIndex+1) = -alignmentState;
            alignmentState = -alignmentState;
            stableCounter = 0;
            currentSwitchIndex = currentSwitchIndex + 2;
        end
    end
    
end

% Remove zeros at the end
i1 = find(switchPointsArray, 1, 'last');
switchPointsArray = switchPointsArray(1:i1);
i2 = find(alignmentArray, 1, 'last');
alignmentArray = alignmentArray(1:i1);

