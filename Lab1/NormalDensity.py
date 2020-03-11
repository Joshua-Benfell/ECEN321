import numpy as np
import matplotlib.pyplot as plt
# Ensure we are using tkinter for matplotlib
import scipy.special as sc
# matplotlib.use("TkAgg")

vecLen = 1000
mean = 2.5
variance = 16
sigma = variance ** 0.5


# nums = np.array([sigma * np.random.randn() + mean for i in range(vecLen)])
# nums = np.random.normal(mean, sigma, vecLen)
# Can also do np.random.normal(mean, sigma, vecLen). randn is what the lab script says to use
nums = sigma * np.random.randn(vecLen) + mean

# Need Mean and Variance
sampleMean = np.mean(nums)
sampleVariance = np.var(nums)
sampleStdDev = np.std(nums)

print("Sample Mean: {}, Sample Variance: {}, Sample STDDEV: {}".format(sampleMean, sampleVariance, sampleStdDev))

bins = 30

plt.figure(1)
histValues,bins = np.histogram(nums, bins) # Display a histogram and return the counts for each bin.
# print(histValues)
binSize = bins[1]-bins[0]
histValues = histValues / vecLen
histProbabilities = histValues / binSize
# print(histProbabilities)
print(sum(histProbabilities))
plt.bar(bins[:-1],histProbabilities,width=binSize, color="blue", alpha=0.5)


x = np.linspace(bins[0], bins[-1], 10000)
samplePdf = ( 1/np.sqrt(2 * np.pi * variance) ) * np.exp(np.power((x-mean), 2)/(-2*variance) )  #expected one
# print(samplePdf)
plt.plot(x, samplePdf)

estimatedPdf = ( 1/np.sqrt(2 * np.pi * sampleVariance) ) * np.exp(np.power((x-sampleMean), 2)/(-2*sampleVariance) ) # uses mean and variance of sample
plt.plot(x, estimatedPdf)

cdf = (1/2)*(1 + sc.erf((x-mean)/(sigma*np.sqrt(2))))  # Expected CDF
plt.figure(2)
plt.plot(x,cdf)

sampleCdf = (1/2)*(1 + sc.erf((x-sampleMean)/(sampleStdDev*np.sqrt(2))))
plt.plot(x,sampleCdf)


plt.show()


