clear
close all
x = 0:200;
ss = 16; %std dev
y = x + randn(1, length(x)) * ss; % add noise to line y=x
plot(x,x) % Original Line y=x
hold on
plot(x,y) % noisy line
rr = corrcoef(x,y);
rr = rr(1,2);

xbar = mean(x);
ybar = mean(y);
B_1hat = sum((x-xbar).*(y-ybar)) ./ sum(power((x-xbar),2));
B_0hat = ybar - B_1hat * xbar;
yhat = B_0hat + B_1hat * x;
plot(x, yhat);

n = length(y);
ss_yhat = sqrt(((1-rr^2) .* sum(power((y - ybar),2)))./(n-2))  %estimate of the std dev

legend("Original Line; y=x", "Gaussian Noise Added", "Least-Squares Line");
title("Demo Line Recovery")
xlabel("x")
ylabel("y")

dim = [.65 0 .9 0.25];
str = strcat('r = ', num2str(rr),newline,' \sigma = ', num2str(ss_yhat));
annotation('textbox', dim, 'String', str, 'FitBoxToText', 'on');
