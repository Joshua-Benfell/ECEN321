mu = 2.5;
var = 16; 
sigma = sqrt(var);
M = 5;
N = 10000;
v = M - 1;
Z = sigma * randn(M, N) + mu;
sample_sigma = std(Z);

means = sum(Z)/M;
t_vals = ((means - mu) ./ sample_sigma) .* sqrt(M);

dx = 0.25;
boundary = 2;
edges = linspace(-boundary, boundary, 2* boundary / dx);

H = hist(t_vals, edges);

hist_vals = H / (N * dx);
tpdf_vals = tpdf(edges, v);

figure(1)
subplot(1,2,1)

bar(edges, hist_vals, "DisplayName", "PMF");
hold on
plot(edges, tpdf_vals, "DisplayName", "tPDF");
hold off
xlabel('t');
ylabel('Probability Density(t)');
legend
title("PDF of t distribution")

subplot(1,2,2)
tcdf_vals = tcdf(edges, v);
plot(edges, tcdf_vals, "DisplayName", "tCDF from bin edges");
hold on
srt = sort(t_vals);
rnk = [1:N]/N;
cdf1 = tcdf(srt, v);
plot(srt, rnk, "DisplayName", "Rank vs Sorted");
plot(srt, cdf1, "DisplayName", "CDF vs Sorted");
legend
xlabel("t")
ylabel("Probabilty T <= t")
hold off
title("CDF of t distribution")