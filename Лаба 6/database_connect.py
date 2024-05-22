import pymysql
import pymysql.cursors

NULL = "NULL"

def select_from(table, login, name, password, time, email, date_of_birth,
                telephone, country, avatar, shortname, coursename, description, duration, rating, beggining,
                              price, access, role, limit=20, offset=0):
    connection = pymysql.connect(
        host="127.0.0.1",
        port=3306,
        user="root",
        password="1234",
        database="online learning platform",
        cursorclass=pymysql.cursors.DictCursor
    )

    where = []
    if table == "user":
        join = ""
        row = ["*"]
        if len(login)  <= 26:
            if len(login) > 0: where.append(f"Login LIKE '{login}'")
        else: return False, []
        if len(name)  <= 50:
            if len(name) > 0: where.append(f"Name LIKE '{name}'")
        else: return False, []
        if len(password)  <= 45:
            if len(password) > 0: where.append(f"Password LIKE '{password}'")
        else: return False, []
        if len(time) > 0: where.append(f"The_time_of_the_last_access_to_the_system = '{time.replace("T", " ") + ":00"}'")
        if len(email)  <= 50:
            if len(email) > 0: where.append(f"Mail LIKE '{email}'")
        else: return False, []
        if len(date_of_birth) > 0: where.append(f"Date_of_birth = '{date_of_birth}'")
        if len(telephone)  <= 15:
            if len(telephone) > 0: where.append(f"Telephone LIKE '{telephone}'")
        else: return False, []
        if len(country)  <= 80:
            if len(country) > 0: where.append(f"Country LIKE '{country}'")
        else: return False, []
        if len(avatar)  <= 140:
            if len(avatar) > 0: where.append(f"Avatar LIKE '{avatar}'")
        else: return False, []
    elif table == "course":
        join = """ JOIN payment ON course.Payment_id_payment = payment.id_payment
JOIN `content bank` ON course.`Content bank_id_content_bank` = `content bank`.id_content_bank """
        row = ["`Short name`", "Name", "Description", "Duration", "Rating", "The_beginning_of_the_course",
                "payment.Price", "`Content bank`.Access_rights"]
        if len(shortname)  <= 20:
            if len(shortname) > 0: where.append(f"`Short name` LIKE '{shortname}'")
        else: return False, []
        if len(coursename)  <= 50:
            if len(coursename) > 0: where.append(f"Name LIKE '{coursename}'")
        else: return False, []
        if len(description) > 0: where.append(f"Description LIKE '{description}'")
        if len(duration) > 0: where.append(f"Duration = {duration}")
        if len(rating) > 0: where.append(f"Rating = {rating}")
        if len(beggining) > 0: where.append(f"The_beginning_of_the_course = '{beggining.replace("T", " ") + ":00"}'")
        if len(price) > 0: where.append(f"payment.Price = '{price}'")
        if len(access) > 0: where.append(f"`Content bank`.Access_rights = '{access}'")
    elif table == "user to course":
        join = ""
        row = ["*"]
        if len(shortname)  <= 45:
            if len(shortname) > 0: where.append(f"`Course_Short name` LIKE '{shortname}'")
        else: return False, []
        if len(login)  <= 26:
            if len(login) > 0: where.append(f"User_Login LIKE '{login}'")
        else: return False, []
        if len(role)  <= 45:
            if len(role) > 0: where.append(f"Role LIKE '{role}'")
        else: return False, []

    try:
        with connection.cursor() as cursor:
            select_user_query = f"""SELECT {", ".join(row)} FROM `{table}` {join} {('WHERE ' if len(where) > 0 else "") + " AND ".join(where)} LIMIT {limit} OFFSET {offset}"""
            print(select_user_query)
            cursor.execute(select_user_query)
            rows = cursor.fetchall()
    finally:
        connection.close()
    
    return True, rows


def insert_into(table, login, name, password, time, email, date_of_birth,
                telephone, country, avatar, shortname, coursename, description, duration, rating, beggining,
                price, access, role):
    connection = pymysql.connect(
        host="127.0.0.1",
        port=3306,
        user="root",
        password="1234",
        database="online learning platform",
        cursorclass=pymysql.cursors.DictCursor
    )

    if table == "user":
        if not(0 < len(login) <= 26): return False
        if not(0 < len(name) <= 50): return False
        if not(0 < len(password)  <= 45): return False
        if len(time) == 0: return False
        if not(0 < len(email) <= 50): return False
        if len(date_of_birth) == 0: return False
        if len(telephone) > 15: return False
        if not(0 < len(country) <= 80): return False
        if len(avatar) > 140: return False

        try:
            with connection.cursor() as cursor:
                insert_query = f"""INSERT `user`(Login, Name, Password, The_time_of_the_last_access_to_the_system, Mail, Date_of_birth, Telephone, Country, Avatar)
                                   VALUES ("{login}", "{name}", "{password}", "{time.replace("T", " ") + ":00"}", "{email}", "{date_of_birth}", "{telephone if telephone != "" else NULL}", "{country}", "{avatar if avatar != "" else NULL}");"""
                insert_query = insert_query.replace('"NULL"', 'NULL')
                print(insert_query)
                cursor.execute(insert_query)
                connection.commit()
        finally:
            connection.close()

    elif table == "course":
        if not(0 < len(shortname)  <= 20): return False
        if not(0 < len(coursename)  <= 50): return False
        
        try:
            with connection.cursor() as cursor:
                cursor.execute("SELECT MAX(id_content_bank) as id FROM `content bank`")
                id_content_bank = cursor.fetchall()
                id_content_bank = (0 if len(id_content_bank) == 0 else id_content_bank[0]["id"]) + 1
                insert_query = f"""INSERT `content bank`(id_content_bank, Access_rights, Location_on_the_server) 
                                  VALUES ({id_content_bank}, "{access}", "/course/{id_content_bank}")"""
                cursor.execute(insert_query)

                
                cursor.execute("SELECT MAX(id_forum) as id FROM `forum`")
                id_forum = cursor.fetchall()
                id_forum = (0 if len(id_forum) == 0 else id_forum[0]["id"]) + 1
                insert_query = f"""INSERT `forum`(id_forum, Number_of_messages, The_subject_of_the_question) 
                                  VALUES ({id_forum}, 0, "")"""
                cursor.execute(insert_query)

                cursor.execute("SELECT MAX(id_payment) as id FROM `payment`")
                id_payment = cursor.fetchall()
                id_payment = (0 if len(id_payment) == 0 else id_payment[0]["id"]) + 1
                insert_query = f"""INSERT `payment`(id_payment, method, price, commission) 
                                  VALUES ({id_payment}, "Оплата по Сбер", {price if price != "" else 0}, 0.0)"""
                cursor.execute(insert_query)

                insert_query = f"""INSERT `course`(`Short name`, Name, Description, Duration, Rating, The_beginning_of_the_course, Payment_id_payment, Forum_id_forum, `Content bank_id_content_bank`)
                                  VALUES ("{shortname}", "{coursename}", "{description if description != "" else NULL}", {duration if duration != "" else NULL}, {rating if rating != "" else NULL}, "{(beggining.replace("T", " ") + ":00") if beggining != "" else NULL}", {id_payment}, {id_forum}, {id_content_bank})"""
                insert_query = insert_query.replace('"NULL"', 'NULL')
                cursor.execute(insert_query)

                connection.commit()
        finally:
            connection.close()

    elif table == "user to course":
        if not(0 < len(shortname) <= 45): return False, []
        if not(0 < len(login) <= 26): return False, []
        if not(0 < len(role)  <= 45): return False, []

        try:
            with connection.cursor() as cursor:
                insert_query = f"""INSERT `user to course`(`Course_Short name`, User_Login, Role)
                                   VALUES("{shortname}", "{login}", "{role}");"""
                print(insert_query)
                cursor.execute(insert_query)
                connection.commit()
        finally:
            connection.close()
    
    return True


def delete_from(table, login, name, password, time, email, date_of_birth,
                telephone, country, avatar, shortname, coursename, description, duration, rating, beggining,
                              price, access, role):
    connection = pymysql.connect(
        host="127.0.0.1",
        port=3306,
        user="root",
        password="1234",
        database="online learning platform",
        cursorclass=pymysql.cursors.DictCursor
    )

    where = []
    if table == "user":
        if len(login)  <= 26:
            if len(login) > 0: where.append(f"Login LIKE '{login}'")
        else: return False
        if len(name)  <= 50:
            if len(name) > 0: where.append(f"Name LIKE '{name}'")
        else: return False
        if len(password)  <= 45:
            if len(password) > 0: where.append(f"Password LIKE '{password}'")
        else: return False
        if len(time) > 0: where.append(f"The_time_of_the_last_access_to_the_system = '{time.replace("T", " ") + ":00"}'")
        if len(email)  <= 50:
            if len(email) > 0: where.append(f"Mail LIKE '{email}'")
        else: return False
        if len(date_of_birth) > 0: where.append(f"Date_of_birth = '{date_of_birth}'")
        if len(telephone)  <= 15:
            if len(telephone) > 0: where.append(f"Telephone LIKE '{telephone}'")
        else: return False
        if len(country)  <= 80:
            if len(country) > 0: where.append(f"Country LIKE '{country}'")
        else: return False
        if len(avatar)  <= 140:
            if len(avatar) > 0: where.append(f"Avatar LIKE '{avatar}'")
        else: return False

        try:
            with connection.cursor() as cursor:
                delete_user_query = f"""DELETE FROM `{table}` {('WHERE ' if len(where) > 0 else "") + " AND ".join(where)}"""
                print(delete_user_query)
                cursor.execute(delete_user_query)
                connection.commit()
        finally:
            connection.close()

    elif table == "course":
        if len(shortname)  <= 20:
            if len(shortname) > 0: where.append(f"`Short name` LIKE '{shortname}'")
        else: return False
        if len(coursename)  <= 50:
            if len(coursename) > 0: where.append(f"Name LIKE '{coursename}'")
        else: return False
        if len(description) > 0: where.append(f"Description LIKE '{description}'")
        if len(duration) > 0: where.append(f"Duration = {duration}")
        if len(rating) > 0: where.append(f"Rating = {rating}")
        if len(beggining) > 0: where.append(f"The_beginning_of_the_course = '{beggining.replace("T", " ") + ":00"}'")
        if len(price) > 0: where.append(f"Price = '{price}'")
        if len(access) > 0: where.append(f"Access_rights = '{access}'")

        try:
            with connection.cursor() as cursor:
                delete_user_query = f"""DELETE `{table}` FROM `{table}` JOIN payment ON payment.id_payment = course.Payment_id_payment
                                        JOIN `content bank` ON `content bank`.id_content_bank = course.`Content bank_id_content_bank`
                                        {('WHERE ' if len(where) > 0 else "") + " AND ".join(where)}"""
                print(delete_user_query)
                cursor.execute(delete_user_query)
                connection.commit()
        finally:
            connection.close()

    elif table == "user to course":
        if len(shortname)  <= 45:
            if len(shortname) > 0: where.append(f"`Course_Short name` LIKE '{shortname}'")
        else: return False
        if len(login)  <= 26:
            if len(login) > 0: where.append(f"User_Login LIKE '{login}'")
        else: return False
        if len(role)  <= 45:
            if len(role) > 0: where.append(f"Role LIKE '{role}'")
        else: return False

        try:
            with connection.cursor() as cursor:
                delete_user_query = f"""DELETE FROM `{table}` {('WHERE ' if len(where) > 0 else "") + " AND ".join(where)}"""
                print(delete_user_query)
                cursor.execute(delete_user_query)
                connection.commit()
        finally:
            connection.close()
    
    return True


def update(table, login, name, password, time, email, date_of_birth,
                telephone, country, avatar, shortname, coursename, description, duration, rating, beggining,
                              price, access, role):
    connection = pymysql.connect(
        host="127.0.0.1",
        port=3306,
        user="root",
        password="1234",
        database="online learning platform",
        cursorclass=pymysql.cursors.DictCursor
    )

    set = []
    if table == "user":
        if 0 < len(login)  <= 26:
            pole = "Login"
        else: return False
        if len(name)  <= 50:
            if len(name) > 0: set.append(f"Name = '{name}'")
        else: return False
        if len(password)  <= 45:
            if len(password) > 0: set.append(f"Password = '{password}'")
        else: return False
        if len(time) > 0: set.append(f"The_time_of_the_last_access_to_the_system = '{time.replace("T", " ") + ":00"}'")
        if len(email)  <= 50:
            if len(email) > 0: set.append(f"Mail = '{email}'")
        else: return False
        if len(date_of_birth) > 0: set.append(f"Date_of_birth = '{date_of_birth}'")
        if len(telephone)  <= 15:
            if len(telephone) > 0: set.append(f"Telephone = '{telephone}'")
        else: return False
        if len(country)  <= 80:
            if len(country) > 0: set.append(f"Country = '{country}'")
        else: return False
        if len(avatar)  <= 140:
            if len(avatar) > 0: set.append(f"Avatar = '{avatar}'")
        else: return False

        try:
            with connection.cursor() as cursor:
                if len(set) > 0:
                    update_user_query = f"""UPDATE `{table}` SET {", ".join(set)} WHERE `{pole}` = '{login}'"""
                    print(update_user_query)
                    cursor.execute(update_user_query)
                    connection.commit()
        finally:
            connection.close()

    elif table == "course":
        if 0 < len(shortname)  <= 20:
            pole = "Short name"
        else: return False
        if len(coursename)  <= 50:
            if len(coursename) > 0: set.append(f"Name = '{coursename}'")
        else: return False
        if len(description) > 0: set.append(f"Description = '{description}'")
        if len(duration) > 0: set.append(f"Duration = {duration}")
        if len(rating) > 0: set.append(f"Rating = {rating}")
        if len(beggining) > 0: set.append(f"The_beginning_of_the_course = '{beggining.replace("T", " ") + ":00"}'")

        try:
            with connection.cursor() as cursor:
                if len(set) > 0:
                    update_user_query = f"""UPDATE `{table}` SET {", ".join(set)} WHERE `{pole}` = '{shortname}'"""
                    print(update_user_query)
                    cursor.execute(update_user_query)
                    connection.commit()
        finally:
            connection.close()

    elif table == "user to course":
        if 0 < len(shortname)  <= 45:
            None
        else: return False
        if 0 < len(login)  <= 26:
            None
        else: return False
        if len(role)  <= 45:
            if len(role) > 0: set.append(f"Role = '{role}'")
        else: return False

        try:
            with connection.cursor() as cursor:
                if len(set) > 0:
                    update_user_query = f"""UPDATE `{table}` SET {", ".join(set)} WHERE `Course_Short name` = '{shortname}' AND `User_Login` = '{login}'"""
                    print(update_user_query)
                    cursor.execute(update_user_query)
                    connection.commit()
        finally:
            connection.close()
    
    return True


def user_list():
    connection = pymysql.connect(
        host="127.0.0.1",
        port=3306,
        user="root",
        password="1234",
        database="online learning platform",
        cursorclass=pymysql.cursors.DictCursor
    )

    try:
        with connection.cursor() as cursor:
            select_user_query = f"""SELECT * FROM user"""
            print(select_user_query)
            cursor.execute(select_user_query)
            rows = cursor.fetchall()
    finally:
        connection.close()

    users = {rows[i]["Login"]:[rows[i]["Password"], rows[i]["Name"], rows[i]["Mail"], rows[i]["Date_of_birth"], rows[i]["Country"], rows[i]["Avatar"]] for i in range(len(rows))}
    
    return users


def courses_list(username):
    connection = pymysql.connect(
        host="127.0.0.1",
        port=3306,
        user="root",
        password="1234",
        database="online learning platform",
        cursorclass=pymysql.cursors.DictCursor
    )

    try:
        with connection.cursor() as cursor:
            select_user_query = f"""SELECT * FROM `user to course` WHERE User_Login = '{username}'"""
            print(select_user_query)
            cursor.execute(select_user_query)
            rows = cursor.fetchall()
    finally:
        connection.close()

    courses = [(rows[i]["Course_Short name"], rows[i]["Role"]) for i in range(len(rows))]
    
    return courses


def average_age():
    connection = pymysql.connect(
        host="127.0.0.1",
        port=3306,
        user="root",
        password="1234",
        database="online learning platform",
        cursorclass=pymysql.cursors.DictCursor
    )

    try:
        with connection.cursor() as cursor:
            select_user_query = f"""SELECT AVG(TIMESTAMPDIFF(YEAR, Date_of_birth, CURRENT_DATE)) AS 'Средний возраст пользователей на платформе'
                                    FROM user;"""
            cursor.execute(select_user_query)
            row = cursor.fetchall()
    finally:
        connection.close()
    
    return row[0]['Средний возраст пользователей на платформе']


def prepods():
    connection = pymysql.connect(
        host="127.0.0.1",
        port=3306,
        user="root",
        password="1234",
        database="online learning platform",
        cursorclass=pymysql.cursors.DictCursor
    )

    try:
        with connection.cursor() as cursor:
            select_user_query = f"""SELECT COUNT(DISTINCT(User_Login)) AS count_prepod
                                    FROM `user to course`
                                    WHERE Role LIKE "Преподаватель_" OR Role = "Преподаватель";"""
            cursor.execute(select_user_query)
            row = cursor.fetchall()
    finally:
        connection.close()
    
    return row[0]['count_prepod']
