from random import randint

with open("forum/title.csv") as f:
    subject = [line.strip() for line in f]

i = 0
forum = []
for i in range(12000):
    forum.append([str(x) for x in [randint(0, 100), subject[i]]])
    i += 1

with open("forum_data.csv", "w", encoding="utf-8") as f:
    for x in forum:
        s = ";".join(x)
        f.write(s + "\n")