import csv
'''
angleList = list(range(-18000, 18000))

for j in range(len(angleList)):
    angleList[j] = angleList[j] / 100

data = list(range(len(angleList)))

for i in range(len(data)):
    data[i] = list(range(len(angleList)))

'''

offsetsList = []
xLists = []
zLists = []
angleList = []

with open('angleOffsets.csv', mode='r') as csvfile:
    spamreader = csv.reader(csvfile, delimiter=' ', quotechar='|')
    for row in spamreader:
        offsetxList = []
        offsetzList = []
        rowString = ', '.join(row)
        rowList = rowString.split(',')
        for k in range(len(rowList)):
            if (rowList[0] != 'Angle' and rowList[1] != 'sadge'):
                if (rowList[k] != ''):
                    if (k == 0):
                        angleList.append(float(rowList[k]))
                    elif (k % 2) == 1:
                        offsetxList.append(int(rowList[k]))
                    else:
                        offsetzList.append(int(rowList[k]))
        if (rowList[0] != 'Angle' and rowList[1] != 'sadge'):
            xLists.append(offsetxList)
            zLists.append(offsetzList)


#for m in range(len(angleList)):
#m = 1
    #print(f'{angleList[m]}: {xLists[m]}, {zLists[m]}')

print("read four's sheet")
#print(angleList)
size = len(angleList)
headerRow = ['']
for r in range(size):
    headerRow.append(str(angleList[r]))
#print(headerRow)
pPoint = 0
'''
data = []
for t in range(size):
    shortList = []
    for u in range(size):
        shortList.append('')
    data.append(shortList)
    progress = int(100 * t / size)
    if (progress >= pPoint):
        print(f"empty data progress: {progress}%")
        pPoint += 1

print("made empty dataset")
#print(data)
'''
'''
pPoint = 0
for p in range(len(angleList)):
    column = []
    angle1 = angleList[p]
    xList1 = xLists[p]
    zList1 = zLists[p]
    for q in range(len(angleList)):
        angle2 = angleList[q]
        xList2 = xLists[q]
        zList2 = zLists[q]
        for a in range(len(zList1)):
            for b in range(len(zList2)):
                if (zList1[a] == zList2[b]):
                    xDiff = xList1[a] - xList2[b]
                    if (xDiff == 1 or xDiff == 0 or xDiff == -1):
                        data[p][q] = "x offsets: " + str(xList1[a]) + ", " + str(xList2[b]) + "; z offset: " + str(zList1[a])
                        #print("x offsets: " + str(xList1[a]) + " and " + str(xList2[b]) + "; z offset: " + str(zList1[a]))
    progress = int(100 * p / size)
    if (progress >= pPoint):
        print(f"complete dataset progress: {progress}%")
        pPoint += 1
'''

#print("finished all comparisons")
pPoint = 0.0
with open('twoEye2.csv', mode='w') as file:
    fileWriter = csv.writer(file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    fileWriter.writerow(headerRow)
    for p in range(size):
        data = []
        for t in range(size):
            data.append('')
        xList1 = xLists[p]
        zList1 = zLists[p]
        for q in range(size):
            xList2 = xLists[q]
            zList2 = zLists[q]
            for a in range(len(zList1)):
                for b in range(len(zList2)):
                    if (zList1[a] == zList2[b]):
                        xDiff = xList1[a] - xList2[b]
                        if (xDiff == 1 or xDiff == 0 or xDiff == -1):
                            data[q] = str(xList1[a]) + " " + str(xList2[b]) + "; " + str(zList1[a])
        dataRow = [str(angleList[p])] + data
        fileWriter.writerow(dataRow)
        progress = 100 * p / size
        if (progress >= pPoint):
            print(f"progress: {progress:.1f}%")
            pPoint += 0.1
