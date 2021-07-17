import csv
maxAxial = 400

data = []

for i in range(maxAxial):
    if (i < 72):
        chunkLocation = "tooClose"
    elif (i > 183):
        chunkLocation = "tooFar"
    else:
        chunkLocation = "inRing"
    data.append([i, chunkLocation])

with open('chunkRing.csv', mode='w') as file:
    fileWriter = csv.writer(file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    for k in range(1, maxAxial):
        fileWriter.writerow(data[k])
