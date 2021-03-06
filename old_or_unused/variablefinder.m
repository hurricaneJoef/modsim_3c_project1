clear all
close all
clc

% Load the validation data
tab_data_validate = readtable("wave1.csv", "Delimiter", ",");
tab_data_wave2 = readtable("wave2.csv", "Delimiter", ",");

% Configure the simulation
beta = 1 /80; % Infection rate (New / Susceptible / Infected / day)
gamma = 10 / 20; % Recovery rate (1 / day)
rho = 1/12;  % reinfection rate 
i_0 = 2;       % Initial count of infected persons
s_0 = 100 - i_0;
r_0 = 0;
best_rmse = 10000


both_waves_data = cat(1,tab_data_validate,tab_data_wave2)% combine both sets of data into one graph
z = zeros(max(size(both_waves_data.W)));%make zeros matrix of size of data to fix bugs involveing overwriting
idatacomp=z(1,:); %make zeros matrix of size of data to fix size issues on first over write
for beta = 1./(89:.001:90)%iterate through betas in estimate range. not the best way but quickest to code
    for gamma = 1./(1.2:.1:2.9)%same for gamma
        for rho = 1./(50:.5:70)%same for rho
            % Run simulation
            [S_long, I_long, R_long, W_long] = sir_simulate_v3(s_0, i_0, r_0, beta, gamma, rho, max(both_waves_data.W));
            %new sir_sim_v3 has rho in it
            for wi = 1:max(size(both_waves_data.W));% pick out data that has a matching point on the given curve (wi means week index)
                w=both_waves_data.W(wi);%find out what week number is on the data at the index of the week
                idatacomp(wi)=I_long(w);%store the infected for that week in an array set up the same as "both_waves_data.I"
            end
             %eval output
            rmse = sqrt(mean(  (both_waves_data.I-idatacomp').^2 )  );%calulate rms error of simulated vs real data
            if(rmse<best_rmse)% if the rmse is better than the best current rms replace the best values so far with new best values
                best_rmse  = rmse%this is uncommented to show progress
                best_beta  = beta;
                best_gamma = gamma;
                best_rho   = rho;
            end
        end
    end
    end

% Plot the fitted simulation
figure(3); clf; hold on;
[S_long, I_long, R_long, W_long] = sir_simulate_v3(s_0, i_0, r_0, best_beta, best_gamma, best_rho, 200);
best_rmse % show best values at end of analisys
1/best_beta
1/best_gamma
1/best_rho


%given ploting code
plot(W_long, I_long, 'k-'); label1 = "Simulated";
plot(tab_data_validate.W, tab_data_validate.I, 'r:', 'LineWidth', 1.5); label2 = "Wave 1";
plot(tab_data_wave2.W, tab_data_wave2.I, 'g:', 'LineWidth', 2.0); label3 = "Wave 2";

xlabel("Week")
ylabel("Infected Persons")
legend({label1, label2, label3})
title("Second Wave")