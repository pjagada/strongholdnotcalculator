import csv

data = []

with open('rawOffsetSheet.csv', mode='r') as csvfile:
    spamreader = csv.reader(csvfile, delimiter=',', quotechar='|')
    for row in spamreader:
        #print(row)
        shortRow = [row[i] for i in range(len(row)) if row[i] != '']
        #print(shortRow)
        data.append(shortRow)
with open('angleOffsets.csv', mode='w', newline='') as file:
    fileWriter = csv.writer(file, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
    for j in range(len(data)):
        dataRow = data[j]
        fileWriter.writerow(dataRow)
