import csv

def rounded(n):
    return str(round(n, 2))

def roughlyEqual(a, b):
    a = float(a)
    if (a - b < 0.005):
        return True
    else:
        return False

data = []

with open('angleOffsets1.csv', mode='r') as csvfile:
    spamreader = csv.reader(csvfile, delimiter=',', quotechar='|')
    for row in spamreader:
        data.append(row)


print(len(data))
#print(data[0:100])
full = []
full.append(data.pop(0))
current = -179.88

while(current <= 179.88):
    if (data and roughlyEqual(data[0][0], current)):
        full.append(data.pop(0))
    else:
        full.append([rounded(current)])
    current += 0.01

with open('angleOffsets.csv', mode='w', newline='') as file:
    fileWriter = csv.writer(file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    for j in range(len(full)):
        dataRow = full[j]
        fileWriter.writerow(dataRow)

print(len(full))
