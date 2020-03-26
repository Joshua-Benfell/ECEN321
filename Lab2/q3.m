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
subplot(1,2,2)
scatter(x,noisy_signal)



CC = cov(y, noisy_signal)
rho = CC(1,2)/sqrt(CC(1,1)*CC(2,2))