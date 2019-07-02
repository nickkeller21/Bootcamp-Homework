import csv
months = 0
total = 0
increase = 0
increaseMonth = ""
decrease = 0
decreaseMonth = ""
with open('budget_data.csv', newline ='') as csvfile:
    data = csv.reader(csvfile, delimiter = ',')
    next(data)
    for row in data:
        total = total + int(row[1])
        months += 1
        if int(row[1]) > increase:
            increase = int(row[1])
            increaseMonth = row[0]
        elif int(row[1]) < decrease:
            decrease = int(row[1])
            decreaseMonth = row[0]
        
average = round(total/months, 2)
answer = ("Total Months: "+ str(months)+
    "\nTotal: $" + str(total)+
    "\nAverage Change: $"+str(average)+
    "\nGreatest Increase in Profits: " + increaseMonth+" $"+ str(increase)+
    "\nGreatest Decrease in Profits: " + decreaseMonth+" $"+ str(decrease)+
    "\nTotal Months: "+ str(months))
print(answer)
with open('Answer.csv', 'w', newline='\n') as f:
    f.write(answer)