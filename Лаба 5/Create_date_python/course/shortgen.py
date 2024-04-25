from random import randint

def gen():
    name = ["front", "back", "ai", "python", "cpp", "math", "analyse", "csv", "gpt5", "qwerty",
            "n", "csharp", "xyz", "comp", "comp_vis", "vision"]
    alph = "qwertyuiopasdfghjklzxcvbnm"
    x = name[randint(0, len(name) - 1)] + "-" + str(randint(1, 200)) + "-" + alph[randint(0, len(alph) - 1)]
    y = x.split("-")
    return x, y[0] + " course at " + y[1]

short = []
name = []
i = 0
while i != 12000:
    x = gen()
    if x[0] not in short:
        short += [x[0]]
        name += [x[1]]
        i += 1

print(short[0])

with open("course/short.csv", "w") as f:
    for x in short:
        f.write(x + "\n")

with open("course/name.csv", "w") as f:
    for x in name:
        f.write(x + "\n")