import numpy as np
import matplotlib.pyplot as plt
from scipy.special import gamma
import scipy.stats as stats

def getColumn(col_num):
    return np.array([row[col_num] for row in nums])


mean = 2.5
variance = 16
sigma = variance ** 0.5
M = 5
N = 10000

v = M - 1

nums = sigma * np.random.randn(M, N) + mean

sampleStdDev = np.std(nums)
# print(nums)
chi_values = []

for i in range(N):
    col = getColumn(i)
    sample_variance = np.var(col)
    sample_mean = np.mean(col)
    col_diff2 = np.power((col-sample_mean), 2)
    chi_values.append(np.sum(col_diff2)/variance)

plt.figure(1)
plt.subplot(1,2,1)
H, X = np.histogram(chi_values, bins=50, range=(-5,20))
dx = X[1]-X[0]
plotVals = H / N
plotVals = plotVals / dx
plt.bar(X[:-1],plotVals,width=dx, color="blue", alpha=0.5, label="Experimental PMF")

chipdf = stats.chi2.pdf(X+dx/2,v)
plt.plot(X, chipdf, label="Theoretical PDF v = 4")


chipdf2 = stats.chi2.pdf(X+dx/2,M)
plt.plot(X, chipdf2, label="Theoretical PDF v = 5")
plt.legend(loc="upper right")

plt.ylabel("Probability Density($x^2$)")
plt.xlabel("$x^2$")
plt.title("Chi$^2$ Density for sum of differences from the sample mean")

plt.subplot(1,2,2)

chi_values_2 = []

for i in range(N):
    col = getColumn(i)
    sample_variance = np.var(col)
    sample_mean = np.mean(col)
    col_diff2 = np.power((col-mean), 2)
    chi_values_2.append(np.sum(col_diff2)/variance)

H2, X2 = np.histogram(chi_values_2, bins=50, range=(-5,20))
dx2 = X2[1]-X2[0]
plotVals2 = H2 / N
plotVals2 = plotVals2 / dx2
plt.bar(X2[:-1],plotVals2,width=dx2, color="blue", alpha=0.5, label="Experimental PMF")

chipdf_2 = stats.chi2.pdf(X2+dx2/2,v)
chipdf2_2 = stats.chi2.pdf(X2+dx2/2,M)


plt.plot(X2, chipdf_2, label="Theoretical PDF v = 4")
plt.plot(X2, chipdf2_2, label="Theoretical PDF v = 5")
plt.legend(loc="upper right")
plt.ylabel("Probability Density($x^2$)")
plt.xlabel("$x^2$")
plt.title("Chi$^2$ Density for sum of differences from the true mean")
plt.show()