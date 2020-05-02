clear

N = 100000;
v1_val = 1.934;
v1_uncertainty = 0.001;
V_1 = unifrnd(v1_val-v1_uncertainty, v1_val+v1_uncertainty, 1, N);
v2_val = 2.53;
v2_uncertainty = 0.01;
V_2 = unifrnd(v2_val-v2_uncertainty, v2_val+v2_uncertainty, 1, N);

V_3 = V_2 - V_1;

dx = 0.01;
boundary = 1;
edges = linspace(0.55, 0.65, boundary / dx);

[histVals, bins] = hist(V_3, edges);
figure(1)
plot(edges, histVals/N);
sum(histVals/N)
title("PDF of V_2 - V_1")
xlabel("Voltage (V)")
ylabel("Probability Density")

std(V_1)
std(V_2)

mean(V_3)
std(V_3)*1000