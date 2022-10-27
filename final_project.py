try:
    fileName = input("What is the name of the ballot file?\n")
    myFile = open(fileName, "r")
except FileNotFoundError:
    print("The file", fileName, "was not found")
else:
    totalBallots = 0
    ballots = {}
    none = 0
    fv = 0
    fullVote = []
    fvCheck = []
    for i in myFile:
        totalBallots = totalBallots + 1
        dupCheck = []
        fvCheck.append(i.strip())
        raw = i.split(' ')
        for k in range(len(raw)):
            raw[k] = raw[k].strip()
        for j in raw:
            if j != "none":
                if j not in fullVote:
                    ballots[j] = 0
                    fullVote.append(j)
                if j not in dupCheck:
                    ballots[j] = ballots[j] + 1
                dupCheck.append(j)
            else:
                none = none + 1
    myFile.close()
    print()
    print("Total # of ballots:", totalBallots)
    print()
    ##got help from stack overflow stackoverflow.com/questions/51325462/how-to-sort-dictionary-values
    sortedBal = dict(sorted(ballots.items(), key = lambda x: int(x[1]), reverse = True))
    for l in sortedBal:
        print(str(l) + ":", sortedBal[l])
    print()
    print("empty:",none)
    for i in fvCheck:
        line = i.split(' ')
        for j in range(len(fullVote)):
            if fullVote[j] not in line:
                break
            elif j == len(fullVote)-1:
                fv = fv +1
    print("full:",fv)
