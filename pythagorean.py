import csv
maxAxial = 400

data = []

for i in range(maxAxial):
    row = []
    for j in range(maxAxial):
        distance = (i ** 2 + j ** 2) ** 0.5
        if (distance < 72):
            chunkLocation = "tooClose"
        elif (distance > 183):
            chunkLocation = "tooFar"
        else:
            chunkLocation = "inRing"
        theString = str(distance)
        row.append(theString)
    data.append(row)

with open('pythagorean.csv', mode='w') as file:
    fileWriter = csv.writer(file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    for k in range(maxAxial):
        fileWriter.writerow(data[k])
