clear

V = 3; % Mean Voltage level of the signal
N = 1000; % Number of samples in the signal
M = 16; % Number of signals to make
variance = 4; % Variance of the signal
sigma = sqrt(variance); % Std Dev of the signal
A_V = 10; % Gain of the amplifier
signals = V + sigma * randn(M,N); % Voltage Signal. DC Lvl V (3V), with noise that has mean 0V and stddev sigma (6V)

sample_mean = mean(signals(1,:)) % Mean of one of the signals
sample_stddev = std(signals(1,:)) % Std Dev of one of the signals

normalised_signal = sum(signals) ./ M;

normalised_sample_mean = mean(normalised_signal)
normalised_sample_std = std(normalised_signal)