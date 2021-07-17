import csv
radius = 3000

coordList = []
chunkList = []
offsetList = list(range(-199,200))
for i in range(0, int(radius/16)):
    coordList.append(16*i)
    chunkList.append(i)
    if i:
        coordList.append(1-16*i)
        chunkList.append(-i)

data = list(range(len(coordList)))

for m in range(len(chunkList)):
    rowList = []
    for n in range(len(offsetList)):
        destinationChunk = chunkList[m] + offsetList[n]
        netherCoords = destinationChunk * 2
        string = str(destinationChunk) + ";" + str(netherCoords)
        rowList.append(string)
    data[m] = rowList

headerRow = ['Coordinate', 'Chunk number']
for p in range(len(offsetList)):
    headerRow.append(offsetList[p])

with open('coordsToChunk.csv', mode='w') as file:
    fileWriter = csv.writer(file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    fileWriter.writerow(headerRow)
    for j in range(len(coordList)):
        dataRow = [coordList[j], chunkList[j]]
        for k in range(len(offsetList)):
            dataRow.append(data[j][k])
        fileWriter.writerow(dataRow)
