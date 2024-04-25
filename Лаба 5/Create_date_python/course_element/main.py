from random import randint

def gen_name():
    return "".join(["qwertyuiopasdfghjklzxcvbnm"[randint(0, 25)] for _ in range(randint(5, 20))])

types = ["Ссылка", "Файл", "PDF", "Презентация", "Документ", "Видеовстреча", "Исходный код", "Диаграмма"]

with open("course_element_data.csv", "w", encoding="utf-8") as f:
    for i in range(12000):
        for j in range(randint(5, 30)):
            s = ";".join([str(j+1), gen_name(), types[randint(0, len(types)-1)], str(randint(0, 1)),
                          "" if randint(0, 10) != 7 else f"bank_content/course_element/{j+1}", str(i+1)])
            f.write(s + "\n")