import csv

inputList = []
numValues = 72000
for i in range(numValues):
    angle = i / 100
    negAngle = -angle
    inputList.append(angle)
    inputList.append(negAngle)

rightList = inputList.copy()
for j in range(len(inputList)):
    angle = inputList[j]
    while (angle <= -180):
        angle += 360
    while (angle >= 180):
        angle -= 360
    rightList[j] = angle

with open('smallAngle.csv', mode='w', newline='') as file:
    fileWriter = csv.writer(file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    for k in range(len(inputList)):
        inAngle = inputList[k]
        rightAngle = rightList[k]
        leftAngle = rightAngle - 0.01
        middleAngle = rightAngle + 0.01
        fileWriter.writerow([inAngle, round(leftAngle, 2), round(middleAngle, 2), round(rightAngle, 2)])

#print(f'{int(max(inputList)/360)} rotations covered')
