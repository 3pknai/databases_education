from random import randint

with open("courseshort.txt") as f:
    course = [x.strip() for x in f]

with open("userlogin.txt") as f:
    user = [x.strip() for x in f]

roles = ["Преподаватель", "Студент", "Студент", "Студент", "Студент"]

with open("user_to_course_data.csv", "w", encoding="utf-8") as f:
    for i in range(len(course)):
        users = []
        for j in range(randint(5, 120)):
            x = user[randint(0, len(user)-1)]
            while x in users:
                x = user[randint(0, len(user)-1)]
            users += [x]
            s = ";".join([course[i], x, roles[randint(0, len(roles)-1)]])
            f.write(s + "\n")