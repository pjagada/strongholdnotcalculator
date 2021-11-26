import csv
radius = 8000

inputList = []
chunkList = []
blockList = []
for i in range(0, radius):
    for j in [i + 0.3, i - 0.3]:
        inputList.append(j)
        if (j == -0.3):
            chunkList.append(int(j/16) - 1)
            blockList.append((j-int(j/16)*16)+16)
        else:
            chunkList.append(int(j/16))
            blockList.append(j-int(j/16)*16)
    if i:
        for j in [-i + 0.3, -i - 0.3]:
            inputList.append(j)
            chunkList.append(int(j/16) - 1)
            blockList.append((j-int(j/16)*16)+16)

headerRow = ['Coordinate', 'Chunk number', 'Block number']

with open('coordsToChunkAndBlock.csv', mode='w', newline='') as file:
    fileWriter = csv.writer(file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    fileWriter.writerow(headerRow)
    for j in range(len(inputList)):
        dataRow = [inputList[j], chunkList[j], blockList[j]]
        fileWriter.writerow(dataRow)
