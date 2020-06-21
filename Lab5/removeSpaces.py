import re
file = open("data.txt", "r")
output = open("data.csv", "w")
outputLines = []
i = 0
for line in file:
	newLine = re.sub(r"\s+", ",",line)[:-1]
	output.write(newLine+"\n")
file.close()
output.close()