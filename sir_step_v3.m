function [s_n, i_n, r_n] = sir_step_v3(s, i, r, beta, gamma, rho)
% fcn_step Advance an SIR model one timestep
%
% Usage
%   [s_n, i_n, r_n] = fcn_step(s, i, r, beta, gamma)
% 
% Arguments
%   s = current number of susceptible individuals
%   i = current number of infected individuals
%   r = current number of recovered individuals
%   
%   beta = infection rate parameter
%   gamma = recovery rate paramter
<<<<<<< HEAD
%   rho = reinfection rate paramtr
=======
>>>>>>> 7d0aad264de5fe4034f2b522b84e1b16ba8ac4cf
% 
% Returns
%   s_n = next number of susceptible individuals
%   i_n = next number of infected individuals
%   r_n = next number of recovered individuals

% compute new infections and recoveries
infected = beta * i * s;
recovered = gamma * i;
resusceptible = rho *  r;
% Enforce invariants
total = s + i + r;
<<<<<<< HEAD
infected = min(s, infected);                % Cannot infect more people than current s
infected = min(total - i, infected);        % Cannot infect more than total
recovered = min(i, recovered);              % Cannot recover more people than current i
recovered = min(total - r, recovered);      % Cannot recover more than total
resusceptible= min(r, resusceptible);       % Cannot resuccept more people than current r
resusceptible= min(total-s, resusceptible); % Cannot resuccept more than total
=======
infected = min(s, infected);           % Cannot infect more people than current s
infected = min(total - i, infected);   % Cannot infect more than total
recovered = min(i, recovered);         % Cannot recover more people than current i
recovered = min(total - r, recovered); % Cannot recover more than total
resusceptible= min(r, resusceptible);
resusceptible= min(total-s, resusceptible);
>>>>>>> 7d0aad264de5fe4034f2b522b84e1b16ba8ac4cf
% Update state
s_n = s + resusceptible - infected;
i_n = i + infected - recovered;
r_n = r + recovered - resusceptible;

% This way of enforcing invariants does not actually conserve persons!
%s_n = max(s_n, 0);
%i_n = max(i_n, 0);
%r_n = max(r_n, 0);
    
end
