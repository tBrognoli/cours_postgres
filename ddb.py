import json
import psycopg2
import random
from faker import Faker
import re
from datetime import datetime
from datetime import timedelta
from title_table import *
import time

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


# DELETE DB
# dropdb dtbName
# Create DB
# ~$ sudo -i -u postgres
# ~$ createdb dtbName
# ctrl + d
# ~$ psql name
# ~$ GRANT all privilege on dtbName to userName


def main(dbname, user, password, sql_file, json_file, host, port):
    if not dbname or not user or not password:
        print("Sauvegardez les variables dans './config.py'")
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

    print(
        "#################################\n"
        "# - Ajouter tables : 1\n"
        "# - Ajouter données : 2\n"
        "# - Ajouter user: 3\n"
        "# - Add data every 3 minutes : 4\n"
        "# - Lauch Eleonore Dehombreux : 5"
    )
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
            worked = populate_db(cursor, book_dict)
            if worked:
                main(dbname, user, password, sql_file, json_file, host, port)

    elif resp == "3":
        worked = addUser(cursor, 50)
        if worked:
            main(dbname, user, password, sql_file, json_file, host, port)

    elif resp == "4":
        print("Ajout d'un ouvrage toutes les 3 minutes")
        i = 0
        while True:
            book_dict = get_book()
            if i != 0:
                time.sleep(180)
            print("Adding book, title='%s'" % book_dict[0]['title'])
            populate_db(cursor, book_dict)
            i += 1

    elif resp == "5":
        Elonore_Dehombreux(cursor)
        main(dbname, user, password, sql_file, json_file, host, port)

    close_connection(cursor)
    return


def connect_ddb(dbname, user, password, host="localhost", port="5432"):
    connection = False
    try:
        connection = psycopg2.connect(
            user=user, password=password, host=host, port=port, database=dbname
        )
    except Exception as error:
        print(error)
        return False
    return connection.cursor() if connection else False


def addTable(cursor, sql_file):
    try:
        with open(sql_file, "r") as myfile:
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


def addUser(cursor, numb):
    # Add users
    user_query = (
        "INSERT INTO subscriber (id_subscriber, "
        "card_number, last_name, email, first_name, delay,"
        " date_start, date_end) VALUES ('%s', %s, %s, %s, %s, %s, %s, %s)"
    )
    fake = Faker()
    for i in range(0, numb):
        card_number = random.randint(1111, 9999)
        name = fake.name()
        first_name = re.search(r"(.*)\s", name).group(1)
        last_name = re.search(r".*\s(.*)", name).group(1)
        email = name.replace(" ", "_") + "@gmail.com"
        boole = [True, False]
        delay = boole[random.randint(0, 1)]
        date_start = datetime.now()
        date_end = date_start + timedelta(days=random.randint(5, 50))
        data = (
            random.randint(0, 99999999),
            card_number,
            last_name,
            email,
            first_name,
            delay,
            date_start,
            date_end,
        )
        cursor.execute(user_query, data)
    cursor.connection.commit()
    print (i, "users ajoutés")
    return True


def populate_db(cursor, books):
    # Add autors
    author_query = (
        "INSERT INTO auteur (id_author, name_author, code_author) "
        "VALUES (%s, %s, %s)"
    )

    # FIXME, mettre la PK en autoincrément
    author_numb = 0
    for i, book in enumerate(books, 0):
        author = book["auteur"]
        cursor.execute("SELECT * FROM auteur WHERE name_author='%s'" % author)
        in_base = cursor.fetchall()
        if in_base:
            continue
        author_numb += 1
        data = (random.randint(0, 99999999), author, random.randint(10, 99))
        cursor.execute(author_query, data)

    cursor.connection.commit()
    if author_numb:
        print(author_numb, "auteurs ajoutés")

    # Add Theme
    theme_query = (
        "INSERT INTO theme (id_theme, room, name_theme, code_theme)"
        " VALUES (%s, %s, %s, %s)"
    )
    genre_numb = 0
    for i, book in enumerate(books, 0):
        genre = book["genre"]
        cursor.execute("SELECT * FROM theme WHERE name_theme='%s'" % genre)
        in_base = cursor.fetchall()
        if in_base:
            continue
        genre_numb += 1
        data = (random.randint(0, 99999999), random.randint(0, 5), genre, genre[:2])
        cursor.execute(theme_query, data)
    cursor.connection.commit()
    if genre_numb:
        print(genre_numb, "themes ajoutés")

    # Add Ouvrage
    book_query = (
        "INSERT INTO ouvrage (id_book, ISBN, edition,"
        " code_title, id_theme, id_author, title, number_example) "
        "VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
    )
    book_numb = 0
    for i, book in enumerate(books, 0):
        titre = book["title"]
        cursor.execute("SELECT * FROM ouvrage WHERE title='%s'" % titre)
        in_base = cursor.fetchall()
        if in_base:
            continue
        book_numb += 1
        author = book["auteur"]
        genre = book["genre"]
        cursor.execute("SELECT * FROM auteur WHERE name_author='%s'" % author)
        id_aut = cursor.fetchall()[0][0]

        cursor.execute("SELECT * FROM theme WHERE name_theme='%s'" % genre)
        id_genre = cursor.fetchall()[0][0]

        isbn = random.randint(1111111111111, 9999999999999)
        edition_lis = [
            "Jacky et michmich",
            "Playboy",
            "FREDO l'AGLO",
            "PornHub",
            "UNICORN",
            "PONEY",
            "AYOUBA&co",
        ]
        code_title = titre[:2]
        number_ex = random.randint(1, 9)
        data = (
            random.randint(0, 99999999),
            isbn,
            edition_lis[random.randint(0, len(edition_lis) - 1)],
            code_title,
            str(id_genre),
            str(id_aut),
            titre,
            str(number_ex),
        )
        cursor.execute(book_query, data)

    cursor.connection.commit()
    if book_numb:
        print (book_numb, "ouvrages ajoutés")
    return True


def close_connection(cursor):
    cursor.close()
    cursor.connection.close()


def get_book():
    fake = Faker()
    title = noun[random.randint(0, len(noun) - 1)] + " of " + adjective[random.randint(0, len(adjective) - 1)]
    book = [{
        "auteur": fake.name(),
        "title": title,
        "genre": genre_lis[random.randint(0, len(genre_lis) - 1)]
    }]
    return book


def Elonore_Dehombreux(cursor):
    with open("fun.sql", "r") as myfile:
        sql_query = myfile.read()

    cursor.execute(sql_query)
    cursor.connection.commit()
    print("GGGGGGGGGGGG")

main(dbname, user, password, sql_file, json_file, host, port)
