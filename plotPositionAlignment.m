% Nick Lavrov
%
% Runs SPPModel2 and plots the position of each locust
% at each time step and the alignment at each time step.


numLocusts = 30; % number of locusts
N = 5000; % number of steps
dt = 1; % size of step
r = 4; % interaction radius
length = 90; % length of domain
[x, u, a] = SPPModel2(numLocusts, N, dt, r, length);

% plot positions
figure(1);
plot(x, '.');
xlabel('Time');ylabel('Position');

% plot alignment
figure(2);
plot(a);
xlabel('Time');ylabel('Alignment');


