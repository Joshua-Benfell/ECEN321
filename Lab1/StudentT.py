import numpy as np
import matplotlib.pyplot as plt
from scipy.special import gamma
import scipy.stats as stats

def getColumn(col_num):
    return [row[col_num] for row in nums]


mean = 2.5
variance = 16
sigma = variance ** 0.5
M = 5
N = 10000

v = M - 1

nums = sigma * np.random.randn(M, N) + mean

# print(nums)
t_values = []

for i in range(N):
    col = getColumn(i)
    sample_mean = np.mean(col)
    sample_stddev = np.std(col)
    t = ((mean - sample_mean) / sample_stddev) * np.sqrt(M)
    t_values += [t]

# print(t_values)

# plt.hist(t_values, bins=80, range = (-10, 10))
plt.figure(1)
H, X = np.histogram(t_values, bins=40, range=(-10,10))
dx = X[1]-X[0]
plotVals = H / N
plotVals = plotVals / dx
plt.bar(X[:-1],plotVals,width=dx, color="blue", alpha=0.5)

tpdf = gamma((v+1)/2) / (np.sqrt(v*np.pi) * gamma(v/2) * np.power(1+(np.power((X+dx/2), 2)/v), (v+1)/2))  # +dx/2 just moves over the center x values
plt.plot(X, tpdf)

# plt.figure(2)

tcdf = stats.t.cdf(X, N-1)
plt.plot(X,tcdf)
# plt.figure(2)
# tcdf = np.cumsum(H/N)
# plt.plot(X[1:],tcdf)

# tcdf = np.cumsum(tpdf*dx)
# plt.plot(X,tcdf)

plt.show()