import csv
maxAxial = 400

data = []

for i in range(maxAxial):
    data.append([i, i * 16])

with open('mult16.csv', mode='w', newline='') as file:
    fileWriter = csv.writer(file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    for k in range(1, maxAxial):
        fileWriter.writerow(data[k])
