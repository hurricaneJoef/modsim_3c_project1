clear all
close all
clc

% Load the validation data
tab_data_validate = readtable("wave1.csv", "Delimiter", ",");
tab_data_wave2 = readtable("wave2.csv", "Delimiter", ",");

% Configure the simulation
beta = 1 /87; % Infection rate (New / Susceptible / Infected / day)
gamma = 10 / 19; % Recovery rate (1 / day)
rho = 1/19.5;  % reinfection rate 
i_0 = 2;       % Initial count of infected persons
s_0 = 100 - i_0;
r_0 = 0;

% Run simulation
[S_long, I_long, R_long, W_long] = sir_simulate_v3(s_0, i_0, r_0, beta, gamma, rho, 100);

% Plot the fitted simulation
figure(3); clf; hold on;

plot(W_long, I_long, 'k-'); label1 = "Simulated";
plot(tab_data_validate.W, tab_data_validate.I, 'r:', 'LineWidth', 1.5); label2 = "Wave 1";
plot(tab_data_wave2.W, tab_data_wave2.I, 'g:', 'LineWidth', 2.0); label3 = "Wave 2";

xlabel("Week")
ylabel("Infected Persons")
legend({label1, label2, label3})
title("Second Wave")