import numpy as np
import matplotlib.pyplot as plt
# Ensure we are using tkinter for matplotlib
from scipy import special
# matplotlib.use("TkAgg")

N = 1000
mean = 2.5
variance = 16
sigma = variance ** 0.5
bins = 30

nums = sigma * np.random.randn(N) + mean

# Need Mean and Variance
sampleMean = np.mean(nums)
sampleVariance = np.var(nums)
sampleStdDev = np.std(nums)

print("Sample Mean: {}, Sample Variance: {}, Sample STDDEV: {}".format(sampleMean, sampleVariance, sampleStdDev))


plt.figure(1)
plt.subplot(1,2,1)
# PMF
H,X = np.histogram(nums, bins, range=(-12+mean,12+mean)) # Make histogram values and return them and the counts for each bin.

dx = X[1] - X[0]
H = H / N
histProbabilities = H / dx
# print(histProbabilities)
# print(sum(histProbabilities))
plt.bar(X[:-1],histProbabilities,width=dx, color="blue", alpha=0.5, label="Histogram")

# PDFs

expectedPDF = ( 1/np.sqrt(2 * np.pi * variance) ) * np.exp(np.power((X-mean), 2)/(-2*variance) )  #expected one
plt.plot(X, expectedPDF, label="Theoretical PDF")

samplePDF = ( 1/np.sqrt(2 * np.pi * sampleVariance) ) * np.exp(np.power((X-sampleMean), 2)/(-2*sampleVariance) ) # uses mean and variance of sample
plt.plot(X, samplePDF, label="Sample PDF")

plt.legend(loc="upper right")
plt.xlabel("x")
plt.ylabel("Probability Density(x)")
plt.title("PDF of Normal Distribution")

# CDFs

cdf = (1/2)*(1 + special.erf((X-mean)/(sigma*np.sqrt(2))))  # Expected CDF
plt.subplot(1,2,2)
plt.plot(X,cdf, label="Theoretical CDF")

sampleCdf = (1/2)*(1 + special.erf((X-sampleMean)/(sampleStdDev*np.sqrt(2))))
plt.plot(X,sampleCdf, label="Sample CDF")

histCDF = np.cumsum(H)
plt.plot(X[1:], histCDF, label="Histogram CDF")

plt.legend(loc="upper left")
plt.xlabel("x")
plt.ylabel("Probability that X < x")
plt.title("CDF of Normal Distribution")

plt.show()


