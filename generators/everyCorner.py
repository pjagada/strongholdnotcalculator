from itertools import product,chain
import csv
from collections import defaultdict
from math import atan,degrees,pi,sqrt
import os

RANGE=3200

def getAngles(dist,chunkX,chunkZ):
    print(chunkX,chunkZ)
    angles = defaultdict(list)
    for x,z in product(range(-dist//16,dist//16 + 1),repeat=2):
        angle = round(degrees((-1+2*int(x<0)) * abs((pi if z < 0 else 0) - atan(abs((x+0.5-(chunkX/16))/(z+0.5-(chunkZ/16)))))),2)
        angles[angle].append((x,z))
    return angles

def ascendSort(oldList):
    newList = []
    while (oldList != []):
        minIdx = -1
        minDist = 99999
        for i in range(len(oldList)):
            dist = sqrt((oldList[i][0] ** 2) + (oldList[i][1] ** 2))
            if (dist < minDist):
                minIdx = i
                minDist = dist
        theTuple = oldList.pop(minIdx)
        newList.append(theTuple)
    return newList

for q in range(16):
    data = [(x,z,getAngles(RANGE,x,z)) for x,z in chain.from_iterable([[(x1+0.3,z1+0.3),(x1+0.3,z1+0.7),(x1+0.7,z1+0.3),(x1+0.7,z1+0.7)] for x1,z1 in product(range(q,q+1),range(0,16))])]
    print("build data")
    total = len(data)
    completed = set()

    for i in range(len(data)):
        percent = int(i * 100 / total)
        if (percent not in completed):
            completed.add(percent)
            print(f"{percent}% done")
            standX = str(data[i][0])
            standZ = str(data[i][1])
            file = "offsets\\" + "x" + standX + "z" + standZ + ".csv"
            with open(file,mode='w',newline='') as csvfile:
                writer = csv.writer(csvfile,quoting=csv.QUOTE_ALL)
                angles = data[i]
                for key,value in angles[2].items():
                    newList = ascendSort(value)
                    writer.writerow([key,*[f"{x} {z}" for x,z in newList]])
    print("done")
