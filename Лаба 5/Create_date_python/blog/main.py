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

def gen_name():
    return "".join(["qwertyuiopasdfghjklzxcvbnm"[randint(0, 25)] for _ in range(randint(5, 20))])

with open("blog/text.csv") as f:
    text = [line.strip() for line in f]

i = 0
with open("blog_data.csv", "w", encoding="utf-8") as f:
    for i in range(10000):
        s = (";".join([text[i], generate_datetime(), gen_name()]))
        f.write(s + "\n")
        i += 1
