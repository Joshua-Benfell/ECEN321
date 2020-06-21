clear
close all
data = readtable('data.csv');
data.Unc__4 = str2double(data.Unc__4); % last column was a string for some reason
averageTemp = 12.93;
h = height(data);
temps = zeros(1, 12);
years = (data.Year(1):data.Year(end))';
currentYear = data.Year(1);
yearlyAverageTemps = zeros(length(years), 1);

YATIndex = 1;
index = 1; % temps index; index - 1 = num of non-NaN values for a given year values.
for r = 1:h
    if(data.Year(r) ~= currentYear || r == h)
        yearlyAverageTemps(YATIndex) = mean(temps);
        yearlyAverageTemps(YATIndex) = yearlyAverageTemps(YATIndex) * 12/(index-1); % fixes the fact that temps is always 12 long
        temps = zeros(1, 12); % reset 
        currentYear = data.Year(r); %increment
        index = 1; % reset
        YATIndex = YATIndex + 1; %Increment
    end
    anom = data.Anomaly(r);
    if not(isnan(anom))
        temps(index) = anom; % Get current months anomaly
        index = index + 1; % increment
    end
    
end

yearlyAverageTemps = yearlyAverageTemps + averageTemp;
plot(years, yearlyAverageTemps);

RR = corrcoef(years,yearlyAverageTemps);
RR = RR(1,2);
RR_sq = RR^2;

% Least Squares Line
xbar = mean(years);
ybar = mean(yearlyAverageTemps);

B_1hat = sum((years - xbar) .* (yearlyAverageTemps - ybar)) ./ sum(power((years-xbar),2));
B_0hat = ybar - B_1hat * xbar;
yhat = B_0hat + B_1hat * years;

n = length(yearlyAverageTemps);
ss_yhat = sqrt(((1-RR^2) .* sum(power((yearlyAverageTemps - ybar),2)))./(n-2));  %estimate of the std dev

hold on
plot(years, yhat);
legend("Berkeley Data on Wellington", "Least-Squares Line")
xlabel("Year")
ylabel("Temperature [^oC]")
title("Temperature Data for Wellington")

% Null Hypothesis: Rho = 0
% Alternate Hypothesis: Rho ~= 0
U = (RR * sqrt(n-2)) / sqrt(1-RR^2);
dof = n -1;
P = tcdf(U, dof);

dim = [.7 0.1 .9 0.25];
str = {strcat('R = ', num2str(RR)),strcat('R^2 = ', num2str(RR_sq)), strcat('s = ', num2str(ss_yhat)), strcat("\beta_0 = ", num2str(B_0hat)), strcat("\beta_1 = ", num2str(B_1hat)), strcat("P = ", num2str(P))};
annotation('textbox', dim, 'String', str, 'FitBoxToText', 'on');
set(gcf, 'Position',  [400, 400, 1000, 600]);

