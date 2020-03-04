cr = [34 1 511 2 574 496 322 424 269 140 244 252 76 108 24 38 18 34 30 191]';
ni = [23 22 55 39 283 34 159 37 61 34 163 140 32 23 54 837 64 354 376 471]';

x = [cr;ni];
g = [ones(size(cr)); 2 * ones(size(ni))];

boxplot(x, g, "labels", ["Chromium", "Nickel"])
ylabel("Concentration (mg/kg)")
title("Concentration of Various Metals in Soil")
