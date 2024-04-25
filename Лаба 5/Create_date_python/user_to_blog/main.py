from random import randint

with open("userlogin.txt") as f:
    user = [line.strip() for line in f]

priv = ["Создатель", "Редактор", "Читатель"]

with open("user_to_blog_data.csv", "w", encoding="utf-8") as f:
    for i in range(10000):
        users = []
        for j in range(randint(1, 35)):
            x = user[randint(0, len(user)-1)]
            while x in users:
                x = user[randint(0, len(user)-1)]
            users += [x]
            s = (";".join([str(i+1), x, priv[randint(0, len(priv)-1)]]))
            f.write(s + "\n")
        