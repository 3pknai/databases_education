import pymysql
import pymysql.cursors

# connection.commit()
def select_from(table, limit=20, offset=0):
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
            select_user_query = f"""SELECT * FROM `{table}` LIMIT {limit} OFFSET {offset}"""
            cursor.execute(select_user_query)
            rows = cursor.fetchall()
    finally:
        connection.close()
    
    return rows



