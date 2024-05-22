from flask import Flask, render_template, url_for, request, flash, session, redirect
from database_connect import select_from, insert_into, delete_from, update, user_list, courses_list, average_age, prepods

app = Flask(__name__)
app.config["SECRET_KEY"] = "d1u292ueh2192uidJDWJIODJO!*@*@Y@*!HU@DH@*"

tables = ["-- | --", "user", "course", "user_to_course"]

@app.route("/", methods=["POST", "GET"])
def index():
    if request.method == "POST":
        req = request.form
        
        for x in req.keys():
            print(x, req[x])
        print()

        table_select = req["table-select"]
        login = req["login"]
        name = req["name"]
        password = req["password"]
        time = req['datetime']
        email = req["email"]
        date_of_birth = req["date_of_birth"]
        telephone = req["telephone"]
        country = req["country"]
        avatar = req["avatar"]

        shortname = req["shortname"]
        coursename = req["coursename"]
        description = req["description"]
        duration = req["duration"]
        rating = req["rating"]
        beggining = req["beggining"]
        price = req["price"]
        access = req["access"]

        role = req["role"]

        limit = req["limit"] if req["limit"] != "" else 10
        offset = req["offset"] if req["offset"] != "" else 0

        if req["table-select"] in tables[1:] and req["table-CRUD"] == "read":
            b, res = select_from(table_select.replace("_"," "), login, name, password, time, email, date_of_birth,
                              telephone, country, avatar, shortname, coursename, description, duration, rating, beggining,
                              price, access, role, limit, offset)
            if not b:
                flash("Некорректный ввод", category="error")
                th = ["", "", ""]
                tr = [["", "", ""], ["", "", ""]]
            else:
                if len(res) > 0:
                    th = res[0].keys()
                    tr = [[x[y] for y in th] for x in res]
                else:
                    flash("Форма получена (не было найдено записей по этому запросу)", category="success")
                    th = ["", "", ""]
                    tr = [["", "", ""], ["", "", ""]]
        elif req["table-select"] in tables[1:] and req["table-CRUD"] == "creating":
            b = insert_into(table_select.replace("_"," "), login, name, password, time, email, date_of_birth,
                              telephone, country, avatar, shortname, coursename, description, duration, rating, beggining,
                              price, access, role)
            if not b:
                flash("Неудачное добавление записи", category="error")
            else:
                flash("Удачное добавление записи", category="success")
            th = ["", "", ""]
            tr = [["", "", ""], ["", "", ""]]
        elif req["table-select"] in tables[1:] and req["table-CRUD"] == "delete":
            b = delete_from(table_select.replace("_"," "), login, name, password, time, email, date_of_birth,
                              telephone, country, avatar, shortname, coursename, description, duration, rating, beggining,
                              price, access, role)
            if not b:
                flash("Неудачное удаление записей", category="error")
            else:
                flash("Удачное удаление записей", category="success")
            th = ["", "", ""]
            tr = [["", "", ""], ["", "", ""]]
        elif req["table-select"] in tables[1:] and req["table-CRUD"] == "update":
            b = update(table_select.replace("_"," "), login, name, password, time, email, date_of_birth,
                              telephone, country, avatar, shortname, coursename, description, duration, rating, beggining,
                              price, access, role)
            if not b:
                flash("Неудачное обновление записей", category="error")
            else:
                flash("Удачное обновление записей", category="success")
            th = ["", "", ""]
            tr = [["", "", ""], ["", "", ""]]

        else:
            flash("Форма не получена", category="error")
            th = ["", "", ""]
            tr = [["", "", ""], ["", "", ""]]

    else:
        th = ["", "", ""]
        tr = [["", "", ""], ["", "", ""]]
    
    return render_template("index.html", title="Онлайн платформа для обучения", tables=tables, rows=tr, columns=th, age=average_age(), prepods=prepods())


@app.route("/home", methods=["POST", "GET"])
def home():
    users = user_list()

    if "userLogged" in session and request.method == "GET":
        return render_template("home.html", username=session["userLogged"], name=users[session["userLogged"]][1],
                                email=users[session["userLogged"]][2], date_of_birth=users[session["userLogged"]][3],
                                country=users[session["userLogged"]][4], avatar=users[session["userLogged"]][5],
                                courses=courses_list(session["userLogged"]))
    elif "userLogged" in session and request.method == "POST":
        del session["userLogged"]
        return redirect(url_for("auth"))
    else:
        return "Вы не авторизованы"

@app.route("/auth", methods=["POST", "GET"])
def auth():
    users = user_list()

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