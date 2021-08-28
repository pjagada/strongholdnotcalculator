import csv

inputList = []
numValues = 36000
for i in range(numValues):
    angle = i
    #negAngle = -angle
    inputList.append(angle)
    #inputList.append(negAngle)

rightList = inputList.copy()
for j in range(len(inputList)):
    angle = inputList[j]
    while (angle < -36):
        angle += 36
    while (angle > 36):
        angle -= 36
    rightList[j] = angle

with open('bigAngle.csv', mode='w', newline='') as file:
    fileWriter = csv.writer(file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    for k in range(len(inputList)):
        inAngle = inputList[k]
        rightAngle = rightList[k]
        #leftAngle = rightAngle - 0.01
        #middleAngle = rightAngle + 0.01
        fileWriter.writerow([inAngle, rightAngle])

print(f'{int(max(inputList)/36)} rotations covered')
