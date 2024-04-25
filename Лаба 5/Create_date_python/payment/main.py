from random import randint

def gen_price_and_com():
    if randint(1, 10) == 10:
        return [0, 0]
    else:
        return [randint(1, 10) * 1000 - randint(0, 1) * 500 - 1, 0 if randint(1, 10) == 10 else randint(1, 20) / 100]

method = ["Через платформу", "Перевод по СБП"]
payment = []
for i in range(12000):
    payment.append([method[randint(0, len(method)-1)]] + [str(x) for x in gen_price_and_com()])

with open("payment_data.csv", "w", encoding="utf-8") as f:
    for x in payment:
        s = ";".join(x)
        f.write(s + "\n")