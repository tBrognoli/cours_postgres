import json
import psycopg2
import random

dbname = False
user = False
password = False
sql_file = False
json_file = False
host = False
port = False

try:
    from config import *
except:
    pass

# Create DB
# ~$ sudo -i -u postgres
# ~$ createdb dtbName
# ctrl + d
# ~$ psql name
# ~$ GRANT all privilege on dtbName to userName


def main(dbname, user, password, sql_file, json_file, host, port):
    if not dbname or not user or not password:
        print("Sauvegardez les variables dans './config.py'"
              " pour ne pas avoir à les répéter ici"
              "dbname=''\nuser=''\npassword=''\nsql_file=''\njson_file=''")
        if not dbname:
            dbname = input("Nom de la base de donnée:\n")
        if not user:
            user = input("Nom de l'utilisateur:\n")
        if not password:
            password = input("")

    if port or host:
        cursor = connect_ddb(dbname, user, password, host, port)
    else:
        cursor = connect_ddb(dbname, user, password)
    if not cursor:
        return

    print("- Ajouter tables : 1\n"
          "- Ajouter données : 2")
    resp = input()

    if resp == "1":
        if not sql_file:
            sql_file = input("Nom du fichier sql :\n")
        worked = addTable(cursor, sql_file)
        if worked:
            main(dbname, user, password, sql_file, json_file, host, port)

    elif resp == "2":
        if not json_file:
            json_file = input("Nom du fichier json :\n")
        book_dict = json_to_dict(json_file)
        if book_dict:
            populate_db(cursor, book_dict)

    close_connection(cursor)
    return


def connect_ddb(dbname, user, password, host="localhost", port="5432"):
    connection = False
    try:
        connection = psycopg2.connect(
            user=user,
            password=password,
            host=host,
            port=port,
            database=dbname
        )
    except Exception as error:
        print(error)
        return False
    return connection.cursor() if connection else False


def addTable(cursor, sql_file):
    try:
        with open(sql_file, 'r') as myfile:
            sql_query = myfile.read()
    except Exception as error:
        print(error)
        return False

    sql_query = sql_query.replace("LOGICAL", "BOOLEAN").replace("\n", "")
    try:
        cursor.execute(sql_query)
        cursor.connection.commit()
    except Exception as error:
        print(error)
        return False

    print("WP BG, Tables ajoutés")
    return True


def json_to_dict(json_file):
    try:
        with open(json_file) as json_data:
            data_dict = json.load(json_data)
        data_str = json.dumps(data_dict)
        data_dict = json.loads(data_str)
    except Exception as error:
        print("Error while creating dict", error)
        return
    return data_dict if data_dict else False


def populate_db(cursor, books):
    # Add autors
    author_query = (
        "INSERT INTO auteur (id_author, name_author, code_author) "
        "VALUES (%s, %s, %s)")

    # FIXME, mettre la PK en autoincrément
    author_numb = 0
    for i, book in enumerate(books, 0):
        author = book['auteur']
        cursor.execute(
            "SELECT * FROM auteur WHERE name_author='%s'" % author)
        in_base = cursor.fetchall()
        if in_base:
            continue
        author_numb += 1
        data = (i, author, random.randint(10, 99))
        cursor.execute(author_query, data)

    cursor.connection.commit()
    count = cursor.rowcount
    print (author_numb, "auteurs ajoutés")


def close_connection(cursor):
    cursor.close()
    cursor.connection.close()


main(dbname, user, password, sql_file, json_file, host, port)
