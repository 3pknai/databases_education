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

def generate_date():
    year = randint(1975, 2016)
    month = randint(1, 12)
    day = randint(1, 28)
    return '"' + str(year) + "-{:>02d}-".format(month) + "{:>02d}".format(day) + '"'

with open("user/login.csv") as f:
    login = [line.strip() for line in f]

with open("user/name.csv") as f:
    name = [line.strip() for line in f]

with open("user/password.csv") as f:
    password = [line.strip() for line in f]

with open("user/mail.csv") as f:
    mail = [line.strip() for line in f]

with open("user/phone.csv") as f:
    phone = [line.strip() for line in f]

with open("user/country.csv") as f:
    country = [line.strip() for line in f]

with open("user/avatar.csv") as f:
    avatar = [line.strip() for line in f]

i = 0
user_dict = dict()
for x in login:
    if x not in user_dict and len(x) < 24:
        user_dict[x] = (name[i], password[i], mail[i],
                        phone[i], country[i], avatar[i])
        i += 1

with open("user_data.csv", "w") as f:
    for x in user_dict:
        s = ";".join([x, user_dict[x][0], user_dict[x][1], generate_datetime(),
                      user_dict[x][2], generate_date(), user_dict[x][3], user_dict[x][4], user_dict[x][5]])
        f.write(s + "\n")

with open("userlogin.txt", "w") as f:
    for x in user_dict:
        f.write(x + "\n")
