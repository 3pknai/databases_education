from random import randint

def generate_datetime():
    year = randint(2021, 2023)
    month = randint(1, 12)
    day = randint(1, 28)
    hour = randint(0, 23)
    minute = randint(0, 59)
    second = randint(0, 59)
    return '"' + str(year) + "-{:>02d}-".format(month) + "{:>02d} ".format(day) + "{:>02d}".format(hour) + \
        ":{:>02d}:".format(minute) + "{:>02d}".format(second) + '"'

course = []

with open("course/short.csv") as f:
    short = [line.strip() for line in f]

with open("course/name.csv") as f:
    name = [line.strip() for line in f]

with open("course/description.csv") as f:
    desc = [line.strip() for line in f]

course_dict = dict()
i = 0
for x in short:
    course_dict[x] = (name[i], desc[i])
    i += 1

i = 1
with open("course_data.csv", "w") as f:
    for x in course_dict:
        s = ";".join([x, course_dict[x][0], course_dict[x][1], str(randint(168, 50000)), str(randint(30, 50) / 100), generate_datetime(), str(i), str(i), str(i)])
        f.write(s + "\n")
        i += 1

with open("courseshort.txt", "w") as f:
    for x in course_dict:
        f.write(x + "\n")
