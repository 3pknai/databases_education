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

def gen_question_name():
    return "".join(["qwertyuiopasdfghjklzxcvbnm0123456789-"[randint(0, 36)] for _ in range(randint(5, 20))])

with open("question/text.csv") as f:
    text = [line.strip() for line in f]

types = ["Короткий ответ", "Сопоставьте варианты", "Эссе", "Подробный ответ", "Вставить пропуски",
         "Программа"]

score = []

with open("question_data.csv", "w", encoding="utf-8") as f:
    for x in text:
        y = randint(1000, 10000) / 100
        score.append(y)
        s = ";".join([gen_question_name(), x, str(y), generate_datetime(), types[randint(0, len(types)-1)],
                      str(randint(1, 100)), str(randint(0, 20))])
        f.write(s + "\n")

with open("question.txt", "w") as f:
    for x in score:
        f.write(str(x) + "\n")