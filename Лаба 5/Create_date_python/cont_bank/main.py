from random import randint

access = ["Общедоступный", "Закрытый", "Частичнодоступный"]
i = 1
cont_back = []
for i in range(12000):
    cont_back.append([access[randint(0, len(access)-1)], f'/courses/bank{i}'])
    i += 1

with open("content_bank_data.csv", "w", encoding="utf-8") as f:
    for x in cont_back:
        s = ";".join(x)
        f.write(s + "\n")