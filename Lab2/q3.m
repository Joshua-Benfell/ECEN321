clear

N = 1000;
x = linspace(0, 20, N);
y = sin(x);
variance = 1;
sigma = sqrt(variance);
noise = randn(1,N) * sigma;
noisy_signal = y + noise;

figure(1)
subplot(1,2,1)
scatter(x,y)
ylabel("Amplitude")
title("Sinusoidal Signal")

xlabel("Time (s)")
subplot(1,2,2)
scatter(x,noisy_signal)
xlabel("Time (s)")
title("Sinusoidal Signal with Noise")

figure(2)
scatter(noisy_signal, y)
xlabel("Noisy Signal")
ylabel("Signal")
title("Signals plotted against each other")

CC = cov(y, noisy_signal)
rho = CC(1,2)/sqrt(CC(1,1)*CC(2,2))