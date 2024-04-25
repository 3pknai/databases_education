from random import randint

with open("question.txt") as f:
    question = [float(x.strip()) for x in f]

with open("userlogin.txt") as f:
    user = [x.strip() for x in f]

with open("user_to_question_data.csv", "w", encoding="utf-8") as f:
    for i in range(len(question)):
        users = []
        for j in range(randint(5, 200)):
            x = user[randint(0, len(user)-1)]
            while x in users:
                x = user[randint(0, len(user)-1)]
            users += [x]
            s = ";".join([str(i+1), x, str(randint(0, int(question[i]*100)) / 100)])
            f.write(s + "\n")