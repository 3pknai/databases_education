from flask import Flask, render_template, url_for, request, flash, session, redirect
from database_connect import select_from

app = Flask(__name__)
app.config["SECRET_KEY"] = "d1u292ueh2192uidJDWJIODJO!*@*@Y@*!HU@DH@*"

tables = ["-- | --", "user", "course", "user_to_course"]

users = {"3pknai": ["1234", "Святослав", "slavabokov2004@mail.ru", "2004-12-04"],
         "iklya": ["147", "Илья", "iklyaM@yandex.ru", "2004-10-02"]}


@app.route("/", methods=["POST", "GET"])
def index():
    if request.method == "POST":
        req = request.form
        
        for x in req.keys():
            print(x, req[x])
        print()
        print(req["table-select"])

        limit = req["limit"] if req["limit"] != "" else 10
        offset = req["offset"] if req["offset"] != "" else 0

        print(limit, offset, req["limit"], req["offset"])

        if req["table-select"] in tables[1:]:
            res = select_from(req["table-select"].replace("_"," "), limit, offset)
            th = res[0].keys()
            tr = [[x[y] for y in th] for x in res]
        else:
            th = ["", "", ""]
            tr = [["", "", ""], ["", "", ""]]



        if th != ["", "", ""]:
            flash("Форма получена", category="success")
        else:
            flash("Форма не получена", category="error")
    else:
        th = ["", "", ""]
        tr = [["", "", ""], ["", "", ""]]
    
    return render_template("index.html", title="Онлайн платформа для обучения", tables=tables, rows=tr, columns=th)





@app.route("/home", methods=["POST", "GET"])
def home():
    if "userLogged" in session and request.method == "GET":
        return render_template("home.html", username=session["userLogged"], name=users[session["userLogged"]][1],
                                email=users[session["userLogged"]][2], date_of_birth=users[session["userLogged"]][3])
    elif "userLogged" in session and request.method == "POST":
        del session["userLogged"]
        return redirect(url_for("auth"))
    else:
        return "Вы не авторизованы"

@app.route("/auth", methods=["POST", "GET"])
def auth():
    if "userLogged" in session:
        return redirect(url_for("home"))
    elif request.method == "POST" and request.form["username"] in users and request.form["password"] == users[request.form["username"]][0]:
        session["userLogged"] = request.form["username"]
        return redirect(url_for("home"))
    else:
        return render_template("auth.html")

@app.errorhandler(404)
def pageNotFount(error):
    return render_template("page404.html", title="Страница не найдена")

if __name__ == "__main__":
    app.run(debug=True)