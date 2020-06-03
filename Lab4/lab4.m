clear

lambda = 3; %Arrival Rate
M = 100;  %Number of arrivals in time t
t = 5;  %Arbitrary arrival time.
K = 0:round(t*lambda*2); %possible values for number of events in time t
cl = 0.01; %confidence level

vals = [100, 500, 1000, 5000, 10000, 50000, 100000];
chi2Vals = zeros(length(vals));
critVals = zeros(length(vals));

figure(1)
annotation('textbox', [0 0.9 1 0.1], ...
    'String', "Expected and Observed Outcomes for Varying number of samples, N, scaled by N", ...
    'EdgeColor', 'none', ...
    'HorizontalAlignment', 'center') % Figure title
for I = 1:length(vals)
    subplot(2, 4, I)
    hold on
    N = vals(I); %Number of experiments
    Y = -log(rand(M,N))/lambda; %Inter Arrival Times; exponential random variable
    arrivalTimes = cumsum(Y);

    arrivals = sum(arrivalTimes<=t,1); %Count the number of arrivals in time t
    O_K = hist(arrivals, K); %Observed Events

    P = exp(-lambda*t) * (lambda*t).^K ./ gamma(K+1); %Poisson Dist. Gamma(k+1) = k!
    E_K = N*P; %ExpectedEvents

    % Ensure that each bin has an expected value of at least 5
    %Expected K
    [r, c, v] = find(E_K >= 5);
    E_K(c(1)) = sum(E_K(1:c(1)));
    E_K(c(end)) = sum(E_K(c(end):end));
    E_K = E_K(c(1):c(end));
    plot(E_K/N);
    %Observed K
    %no find in this one to keep dimensions consistent
    O_K(c(1)) = sum(O_K(1:c(1)));
    O_K(c(end)) = sum(O_K(c(end):end));
    O_K = O_K(c(1):c(end));
    plot(O_K/N);
    
    title(strcat({"N = ", N}));
    %Define degrees of freedom as num bins - 1
    nu = length(E_K) - 1;

    %Chi Square Values
    chi2 = sum((O_K-E_K).^2./E_K);
    crit = chi2inv(1-cl, nu);
    
    chi2Vals(I) = chi2;
    critVals(I) = crit;
end
