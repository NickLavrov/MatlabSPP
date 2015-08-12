% initializedSpp.m
% Nick Lavrov '15
% Princeton University
% Code modified from Szeto 2009
%

function [x, u, alignment] = initializedSpp(x0, u0, N, dt, r, length)
% Same as SppModel, but with initial states
% x0 and u0 provied.
% Runs SPP simulation of numLocusts locusts
% for N steps with time step dt, interaction
% radius r, and length domain length.
% Returns a matrix of all positions x,
% all velocities u, and alignments.
% Typical values: SppModel(30, 5000, 1, 4, 90)

beta = 1;
xi = 3*sqrt(dt);
numLocusts = size(x0, 2);
alignment = zeros(1, N);
x = zeros(N, numLocusts);
u = zeros(N, numLocusts);
x(1, :) = x0;
u(1, :) = u0;
alignment(1) = sum(u(1, :)) / numLocusts;

% Main loop
for i = 2:N
    % Update position
    
    for j = 1:numLocusts
        x(i, j) = mod(x(i-1, j) + dt*u(i-1, j), length);
    end
    % Update velocity
    for j = 1:numLocusts
        % Calculate local average velocity from neighbors within interation radius
        velocitySum = 0;
        numIR = 0;
        for k = 1:numLocusts
            if ((abs(x(i-1, j) - x(i-1, k)) < r) || (abs(x(i-1, j) - x(i-1, k)) > (length - r)))
                velocitySum = velocitySum + u(i-1, k);
                numIR = numIR + 1;
            end
        end
        localAverageVelocity = velocitySum / numIR;
        % Derive G from local average velocity
        G = 0;
        if (localAverageVelocity >= 0)
            G = (localAverageVelocity + beta) / (1 + beta);
        end
        if (localAverageVelocity <= 0)
            G = (localAverageVelocity - beta) / (1 + beta);
        end
        % Find noise term
        Q = (rand()-.5) * xi;
        % Update new velocity
        u(i, j) = u(i-1, j) + dt*(G - u(i-1, j)) + Q;
    end
    % Calculate alignment at this time step
    alignment(i) = sum(u(i, :)) / numLocusts;
end