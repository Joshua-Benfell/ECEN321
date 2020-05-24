% Speech Distribution
close all
clear

%1
fid = fopen("Speech.pcm");
[signal N] = fread(fid, 'int16');
figure(1)
plot(signal)
%2
variance = var(signal);
%4
mu = 0;
%5

%parameters
alphaEsti = sqrt(2 * variance); % Initial Guess
betaEsti = 2; % Initial Guess
absx = abs(signal);

maxIters = 100;

%betaConditions
betaEnd = 5;
betaStep = 0.001;
betaStart = 0;
lastBeta = 0;

%alphaConditions
alphaStart = 0;
alphaEnd = 7e3;
alphaStep = 0.1;
lastAlpha = 0;

%array of past values
alphaVals = [alphaEsti];
betaVals = [];


figure(2)
for iters = 0:maxIters
    subplot(1,2,1)
    hold on
    f = zeros(betaEnd/betaStep+1, 1);
    i = 1;
    for beta = betaStart:betaStep:betaEnd
        if length(betaVals) > 1 && betaVals(end-1) == betaVals(end)
           break; 
        end
        f(i) = N * (log(beta) - log(2*alphaEsti) - gammaln(1/beta)) - sum((absx/alphaEsti).^beta);
        if i > 1 && f(i) < f(i-1)
            betaEsti = lastBeta;
            betaVals(end+1) = betaEsti;
            break
        end
        lastBeta = beta;
        i=i+1;
    end
    plot(betaStart:betaStep:betaEnd, f);
    f = zeros(alphaEnd/alphaStep+1, 1);
    i = 1;
    subplot(1,2,2);
    hold on
    for alpha = alphaStart:alphaStep:alphaEnd
        if length(alphaVals) > 1 && alphaVals(end-1) == alphaVals(end)
           break; 
        end
        f(i) = N * (log(betaEsti) - log(2*alpha) - gammaln(1/betaEsti)) - sum((absx/alpha).^betaEsti);
        if i > 1 && f(i) < f(i-1)
            alphaEsti = lastAlpha;
            alphaVals(end+1) = alphaEsti;
            break
        end
        lastAlpha = alpha;
        i=i+1;
    end
    plot(alphaStart:alphaStep:alphaEnd, f);
end
subplot(1,2,1)
title("\beta")
subplot(1,2,2)
title("\alpha")

figure(3)
[H, barCenters] = hist(signal, 50);
dx = barCenters(2)-barCenters(1);
histVals = H/(N*dx);
barEdges = barCenters - dx;
x = -30000:10:30000;
y = (betaEsti / (2 * alphaEsti * gamma(1/betaEsti)) * exp(-power(abs(x)./alphaEsti, betaEsti)));
plot(x,y);
hold on
bar(barEdges, histVals);
title("PDF of Speech")
ylabel("Probability Density")
xlabel("Amplitude")