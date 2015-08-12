% switchChecker.m
% Nick Lavrov '15
% Princeton University
 

function isSwitched = switchChecker(x, u, N, dt, r, length)
% Runs SPP with given initial state x and u for N steps
% Checks if ending alignment is different from starting alignment
[~, ~, anew]=initializedSpp(x,u,N,dt,r,length);
isSwitched = sign(mean(u)) ~= sign(anew(end));
