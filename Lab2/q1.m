clear

V = 3; %Mean Voltage level of the signal
N = 1000; %Number of samples in the signal
variance = 4; %Variance of the signal
sigma = sqrt(variance); %Std Dev of the signal
A_V = 10; %Gain of the amplifier
signal = V + sigma * randn(1,N); %Voltage Signal. DC Lvl V (3V), with noise that has mean 0V and stddev sigma (6V)

sample_mean = mean(signal)
sample_stddev = std(signal)

amplified_signal = A_V .* signal; %Pass the signal through an amplifier
amplified_sample_mean = mean(amplified_signal)
amplified_sample_stddev = std(amplified_signal)

figure(1)
plot(signal)
hold on
plot(amplified_signal)
xlabel("Time (s)")
ylabel("Voltage (V)")
title("Voltage Amplifier")
legend("Signal", "Amplified Signal")