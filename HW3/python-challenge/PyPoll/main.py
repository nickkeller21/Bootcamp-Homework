import csv
totalVoters = 0
khan = 0
correy = 0
li = 0
o =  0
with open('election_data.csv', newline ='') as csvfile:
    data = csv.reader(csvfile, delimiter = ',')
    next(data)
    for row in data:
        totalVoters += 1
        if row[2] == "Khan":
            khan += 1
        elif row[2] == "Correy":
            correy += 1
        elif row[2] == "Li":
            li += 1
        elif row[2] == "O'Tooley":
            o += 1

dic = {"Khan":khan,"Correy":correy,"Li":li,"O'Tooley":o}
winner = max(dic, key=dic.get)

answer = ("Election Results"+
    "\n------------------------"+
    "\nTotal Votes:" + str(totalVoters)+
    "\n------------------------"+
    "\nKhan: " + str(round((khan/totalVoters)*100))+"% "+str(khan)+
    "\nCorrey: " + str(round((correy/totalVoters)*100))+"% "+str(correy)+
    "\nLi: " + str(round((li/totalVoters)*100))+"% "+str(li)+
    "\nO'Tooley: " + str(round((o/totalVoters)*100))+"% "+str(o)+
    "\n------------------------"+
    "\nWinner:"+ winner)

print(answer) 
with open('Answer.csv', 'w', newline='\n') as f:
    f.write(answer)