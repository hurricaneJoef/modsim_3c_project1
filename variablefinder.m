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
rmselast = 10000


%lastbeta =0.0067


%lastgamma =0.5000


%lastrho =0.1429
dataall = cat(1,tab_data_validate,tab_data_wave2)

for beta = 1./(30:170)
% Run simulation
    for gamma = 1./(.9:.05:5.5)
        for rho = 1./(1:100)

            [S_long, I_long, R_long, W_long] = sir_simulate_v3(s_0, i_0, r_0, beta, gamma, rho, 200);
            o=1;
            z = zeros(max(size(dataall.W)));
            idatacomp=z(1,:);
            for wi = 1:max(size(dataall.W))
                w=dataall.W(wi);
                idatacomp(o)=I_long(w);
                o=o+1;
                %eval output
            end
            rmse = sqrt(mean(mean((dataall.I-idatacomp).^2)))
            if(rmse<rmselast)
                rmselast  = rmse
                lastbeta  = beta;
                lastgamma = gamma;
                lastrho   = rho;
            end
        end
    end
    end

% Plot the fitted simulation
figure(3); clf; hold on;
[S_long, I_long, R_long, W_long] = sir_simulate_v3(s_0, i_0, r_0, lastbeta, lastgamma, lastrho, 200)
rmselast
lastbeta
lastgamma
lastrho
%{
o=1
z = zeros(max(size(dataall.W)))
idatacomp=z(1,:)
for wi = 1:max(size(dataall.W))
    w=dataall.W(wi)
    r = I_long(w)
    idatacomp(o)=I_long(w)
    o=o+1
    %eval output
end
rmse = sqrt(mean(mean((dataall.I-idatacomp).^2)))
%}
plot(W_long, I_long, 'k-'); label1 = "Simulated";
plot(tab_data_validate.W, tab_data_validate.I, 'r:', 'LineWidth', 1.5); label2 = "Wave 1";
plot(tab_data_wave2.W, tab_data_wave2.I, 'g:', 'LineWidth', 2.0); label3 = "Wave 2";

xlabel("Week")
ylabel("Infected Persons")
legend({label1, label2, label3})
title("Second Wave")