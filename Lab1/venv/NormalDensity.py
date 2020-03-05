import numpy as np
import matplotlib.pyplot as plt
# Ensure we are using tkinter for matplotlib
import matplotlib
matplotlib.use("TkAgg")

vecLen = 1000
mean = 2.5
variance = 16
sigma = variance **0.5


nums = np.array([sigma * np.random.randn() + mean for i in range(vecLen)])
# Can also do np.random.normal(mean, sigma, vecLen). randn is what the lab script says to use


# Need Mean and Variance
sampleMean = np.mean(nums)
sampleVariance = np.var(nums)
sampleStdDev = np.std(nums)

# print(sampleMean, sampleVariance, sampleStdDev)

bins = 20
plt.hist(nums, bins)

plt.show()
