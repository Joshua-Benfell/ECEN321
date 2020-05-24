%Gaussian Distribution
close all
clear
mu = 10;
variance = 4;
sigma = sqrt(variance);

ten = sigma * randn(1000, 10) + mu;
tenThou = sigma * randn(1000, 10000) + mu;

%1
tenMu = mean(ten, 2);
tenThouMu = mean(tenThou, 2);
%2
tenVar = var(ten, 0, 2);
tenThouVar = var(tenThou, 0, 2);
%3
index = 1:1:1000;

figure(1)

subplot(2,2,1)
scatter(index, tenMu)
title("\mu of Ten Experiments")

subplot(2,2,3)
scatter(index, tenVar)
title("\sigma^2 of Ten Experiments")

subplot(2,2,2)
scatter(index, tenThouMu)
title("\mu of Ten Thousand Experiments")

subplot(2,2,4)
scatter(index, tenThouVar)
title("\sigma^2 of Ten Thousand Experiments")

%4
figure(2)

subplot(2,2,1)
[N, X] = hist(tenMu, 30);
binWidth = X(2) - X(1);
bar(X, N - binWidth/2) %plot bars shifted back from the center half a bin width
title("\mu of Ten Experiments")

subplot(2,2,3)
[N, X] = hist(tenVar, 30);
binWidth = X(2) - X(1);
bar(X, N - binWidth/2)
title("\sigma^2 of Ten Experiments")

subplot(2,2,2)
[N, X] = hist(tenThouMu, 30);
binWidth = X(2) - X(1);
bar(X, N - binWidth/2)
title("\mu of Ten Thousand Experiments")

subplot(2,2,4)
[N, X] = hist(tenThouVar, 30);
binWidth = X(2) - X(1);
bar(X, N - binWidth/2)
title("\sigma^2 of Ten Thousand Experiments")


