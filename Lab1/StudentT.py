import numpy as np
import matplotlib.pyplot as plt


def getColumn(col_num):
    return [row[col_num] for row in nums]


mean = 2.5
variance = 16
sigma = variance ** 0.5
M = 5
size = 10000

nums = sigma * np.random.randn(M, size) + mean

# print(nums)
t_values = []

for i in range(size):
    col = getColumn(i)
    sample_mean = np.mean(col)
    sample_stddev = np.std(col)
    t = ((mean - sample_mean) / sample_stddev) * np.sqrt(M)
    t_values += [t]

print(t_values)

# plt.hist(t_values, bins=80, range = (-10, 10))
histVals, bins = np.histogram(t_values, bins=40, range=(-10,10))
binSize = bins[1]-bins[0]
plotVals = histVals / size
plotVals = plotVals / binSize
plt.bar(bins[:-1],plotVals,width=binSize, color="blue", alpha=0.5)
plt.show()