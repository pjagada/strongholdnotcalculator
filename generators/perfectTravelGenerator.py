import numpy as np
import math
import pandas as pd

error = 0.005 # max user error in degrees
divisions = 9000
maxAngle = 90
maxDistance = 100
angles = np.linspace(-180, maxAngle*2, divisions*4 + 1)
slopes = [None]*(divisions*4 + 1)

for i in range(0, maxDistance+1):
    for j in range(0, maxDistance+1):
        a = math.atan2(i + 0.5, j + 0.5)/math.pi*180 # real angle
        a0 = a - error # min possible angle
        a1 = a + error # max possible angle
        index0 = round(a0*divisions/maxAngle)
        index1 = round(a1*divisions/maxAngle)
        for index in range(index0, index1 + 1):
            dist = np.sqrt((i + 0.5) * (i + 0.5) + (j + 0.5) * (j + 0.5)) * 16
            if slopes[index] == None:
                slopes[index+divisions*3] = ["-"+str(j),str(i),str(round(dist,2))+"|"]
                slopes[index+divisions*2] = [str(i),str(j),str(round(dist,2))+"|"]
                slopes[index] = ["-"+str(i),str(j),str(round(dist,2))+"|"]
                slopes[index+divisions] = ["-"+str(j),"-"+str(i),str(round(dist,2))+"|"]

            #elif dist<=maxDistance*16 :
            #    slopes[index+divisions*3].extend(("-"+str(j),str(i),str(round(dist,2))+"|"))
            #    slopes[index+divisions*2].extend((str(i),str(j),str(round(dist,2))+"|"))
            #    slopes[index].extend(("-"+str(i),str(j),str(round(dist,2))+"|"))
            #    slopes[index+divisions].extend(("-"+str(j),"-"+str(i),str(round(dist,2))+"|"))
for i in range(0,divisions*4+1):
	print(str(angles[i])+" "+slopes[i][0]+" "+slopes[i][1])
#pd.DataFrame([", ".join([str(e) for e in entries]) if entries != None else "" for entries in slopes], index=angles).to_csv("triangulation table.csv")