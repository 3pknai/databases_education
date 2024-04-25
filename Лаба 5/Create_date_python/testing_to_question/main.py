from random import randint

with open("testing_to_question_data.csv", "w", encoding="utf-8") as f:
    for i in range(20000):
        quest = []
        for j in range(randint(3, 30)):
            x = randint(1, 30000)
            while x in quest:
                x = randint(1, 30000)
            quest += [x]
            s = ";".join([str(i+1), str(x), str(j+1)])
            f.write(s + "\n")