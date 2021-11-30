from itertools import product,chain
import csv
from collections import defaultdict, OrderedDict
from math import atan,degrees,pi,sqrt
import os
import threading

threads = 8 # 1, 2, 4, 8, or 16

RANGE = 3200

def getAngles(dist,chunkX,chunkZ):
    print(chunkX,chunkZ)
    angles = defaultdict(list)
    for x,z in product(range(-dist//16,dist//16 + 1),repeat=2):
        angle = round(degrees((-1+2*int(x<0)) * abs((pi if z < 0 else 0) - atan(abs((x+0.5-(chunkX/16))/(z+0.5-(chunkZ/16)))))),2)
        angles[angle].append((x,z))
    for i in range(-17989, 17989):
        missed_angle = i/100
        if missed_angle not in angles:
            angles[missed_angle] = []
    sorted_angles = OrderedDict(sorted(angles.items(), key=lambda x: x[0]))
    return sorted_angles

def doit(q):
    q = int(q)
    print(f"starting thread {q} to {q+(16//threads)}")
    total = 1024 / threads
    completed = set()
    tablesDone = 0
    for m in range(16):
        data = [(x,z,getAngles(RANGE,x,z)) for x,z in chain.from_iterable([[(x1+0.3,z1+0.3),(x1+0.3,z1+0.7),(x1+0.7,z1+0.3),(x1+0.7,z1+0.7)] for x1,z1 in product(range(q, q+(16//threads)),range(m,m+1))])]
        print("build data")

        for i in range(len(data)):
            standX = str(data[i][0])
            standZ = str(data[i][1])
            file = "tables\\offsets\\" + "x" + standX + "z" + standZ + ".csv"
            with open(file,mode='w',newline='') as csvfile:
                writer = csv.writer(csvfile,quoting=csv.QUOTE_ALL)
                angles = data[i]
                for key,value in angles[2].items():
                    newList = sorted(value, key=lambda x: x[0]**2+x[1]**2)
                    writer.writerow([key,*[f"{x} {z}" for x,z in newList]])
            tablesDone += 1
            percent = int(tablesDone * 100 / total)
            if (percent not in completed):
                completed.add(percent)
                print(f"{percent}% done with thread {int(q / (16 / threads))}")
    print(f"finishing thread {q} to {q+(16//threads)}")


assert(threads in [1,2,4,8,16]), "Can only use 1, 2, 4, 8, or 16 threads"

print("running with " + str(threads) + " threads")

threadList = []
for i in range(threads):
    threadList.append(threading.Thread(target=doit, args=(i*(16/threads),)))

for t1 in threadList:
    t1.start()

for t2 in threadList:
    t2.join()


print("everything done")
