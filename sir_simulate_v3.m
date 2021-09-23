function [S, I, R, W] = sir_simulate_v3(s_0, i_0, r_0, beta, gamma,rho, num_steps)
% fcn_simulate Simulate a SIR model
%
% Usage
%   [S, I, R, W] = fcn_simulate(s_0, i_0, r_0, beta, gamma, num_steps)
%
% Arguments
%   s_0 = initial number of susceptible individuals
%   i_0 = initial number of infected individuals
%   r_0 = initial number of recovered individuals
%
%   beta = infection rate parameter
%   gamma = recovery rate paramter
%
%   num_steps = number of simulation steps to simulate
%
% Returns
%   S = simulation history of susceptible individuals; vector
%   I = simulation history of infected individuals; vector
%   R = simulation history of recovered individuals; vector
%   W = simulation week; vector

% Setup
S = zeros(1, num_steps);
I = zeros(1, num_steps);
R = zeros(1, num_steps);
W = 1 : num_steps;

s = s_0;
i = i_0;
r = r_0;

% Store initial values
S(1) = s;
I(1) = i;
R(1) = r;

% Run simulation
for step = 2 : num_steps
    [s, i, r] = sir_step_v3(s, i, r, beta, gamma, rho);
    S(step) = s;
    I(step) = i;
    R(step) = r;
end

end