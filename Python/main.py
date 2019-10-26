from app import app
from flask import jsonify
from flask import flash, request
from flask_csv import send_csv

import mysql.connector

mydb = mysql.connector.connect(
    host="mysql",
    user="root",
    passwd="password",
    database="soa"
)

database = mydb.cursor()


@app.route('/orders')
def orders():
    try:
        query = ("SELECT restaurants.name AS Restaurant, clients.fName AS ClientFirstName, clients.lName "
                 + "AS ClientLastName, orders.orderDate AS Date "
                 + "FROM restaurants "
                 + "JOIN orders ON restaurants.idRestaurant = orders.idRestaurant "
                 + "JOIN clients ON clients.idClient = orders.idClient")
        database.execute(query)
        rows = database.fetchall()

        csv = []

        for i in rows:
            csv_temp = {}
            csv_temp['Restaurant'] = i[0]
            csv_temp['ClientFirstName'] = i[1]
            csv_temp['ClientLastName'] = i[2]
            csv_temp['Date'] = i[3]
            csv.append(csv_temp)

        return send_csv(csv, "test.csv", ["Restaurant", "ClientFirstName", "ClientLastName", "Date"])

    except Exception as e:
        print(e)


@app.route('/orders/day/<int:day>')
def ordersDay(day):
    try:
        query = ("SELECT restaurants.name AS Restaurant, clients.fName AS ClientFirstName, clients.lName "
                 + "AS ClientLastName, orders.orderDate AS Date "
                 + "FROM restaurants "
                 + "JOIN orders ON restaurants.idRestaurant = orders.idRestaurant "
                 + "JOIN clients ON clients.idClient = orders.idClient WHERE DAY(orders.orderDate) = " + str(day))
        database.execute(query)
        rows = database.fetchall()

        csv = []

        for i in rows:
            csv_temp = {}
            csv_temp['Restaurant'] = i[0]
            csv_temp['ClientFirstName'] = i[1]
            csv_temp['ClientLastName'] = i[2]
            csv_temp['Date'] = i[3]
            csv.append(csv_temp)

        return send_csv(csv, "test.csv", ["Restaurant", "ClientFirstName", "ClientLastName", "Date"])
    except Exception as e:
        print(e)


@app.route('/orders/month/<int:month>')
def ordersMonth(month):
    try:
        query = ("SELECT restaurants.name AS Restaurant, clients.fName AS ClientFirstName, clients.lName "
                 + "AS ClientLastName, orders.orderDate AS Date "
                 + "FROM restaurants "
                 + "JOIN orders ON restaurants.idRestaurant = orders.idRestaurant "
                 + "JOIN clients ON clients.idClient = orders.idClient WHERE MONTH(orders.orderDate) = " + str(month))
        database.execute(query)
        rows = database.fetchall()

        csv = []

        for i in rows:
            csv_temp = {}
            csv_temp['Restaurant'] = i[0]
            csv_temp['ClientFirstName'] = i[1]
            csv_temp['ClientLastName'] = i[2]
            csv_temp['Date'] = i[3]
            csv.append(csv_temp)

        return send_csv(csv, "test.csv", ["Restaurant", "ClientFirstName", "ClientLastName", "Date"])
    except Exception as e:
        print(e)


@app.route('/orders/year/<int:year>')
def ordersYear(year):
    try:
        query = ("SELECT restaurants.name AS Restaurant, clients.fName AS ClientFirstName, clients.lName "
                 + "AS ClientLastName, orders.orderDate AS Date "
                 + "FROM restaurants "
                 + "JOIN orders ON restaurants.idRestaurant = orders.idRestaurant "
                 + "JOIN clients ON clients.idClient = orders.idClient WHERE YEAR(orders.orderDate) = " + str(year))
        database.execute(query)
        rows = database.fetchall()

        csv = []

        for i in rows:
            csv_temp = {}
            csv_temp['Restaurant'] = i[0]
            csv_temp['ClientFirstName'] = i[1]
            csv_temp['ClientLastName'] = i[2]
            csv_temp['Date'] = i[3]
            csv.append(csv_temp)

        return send_csv(csv, "test.csv", ["Restaurant", "ClientFirstName", "ClientLastName", "Date"])
    except Exception as e:
        print(e)


@app.route('/users')
def use():
    try:
        query = ("SELECT clients.fName, clients.lName, clients.address, clients.identification, users.userName, users.password "
                 + "FROM users "
                 + "JOIN clients ON clients.idClient = users.Client_idClient;")
        database.execute(query)
        rows = database.fetchall()

        csv = []

        for i in rows:
            csv_temp = {}
            csv_temp['ClientFirstName'] = i[0]
            csv_temp['ClientLastName'] = i[1]
            csv_temp['ClientAddress'] = i[2]
            csv_temp['ClientIdentification'] = i[3]
            csv_temp['UserName'] = i[4]
            csv_temp['Password'] = i[5]
            csv.append(csv_temp)

        return send_csv(csv, "test.csv", ["ClientFirstName", "ClientLastName", "ClientAddress", "ClientIdentification", "UserName", "Password"])
    except Exception as e:
        print(e)


@app.route('/restaurants/<int:id>')
def user(id):
    try:
        query = ("SELECT restaurants.name AS Restaurant, clients.fName AS ClientFirstName, clients.lName AS ClientLastName, orders.orderDate AS Date "
                 + "FROM restaurants "
                 + "JOIN orders ON restaurants.idRestaurant = orders.idRestaurant "
                 + "JOIN clients ON clients.idClient = orders.idClient WHERE restaurants.idRestaurant = " + str(id))
        database.execute(query)
        rows = database.fetchall()

        csv = []

        for i in rows:
            csv_temp = {}
            csv_temp['RestaurantName'] = i[0]
            csv_temp['ClientFirstName'] = i[1]
            csv_temp['ClientLastName'] = i[2]
            csv_temp['Date'] = i[3]
            csv.append(csv_temp)

        return send_csv(csv, "test.csv", ["RestaurantName", "ClientFirstName", "ClientLastName", "Date"])
    except Exception as e:
        print(e)


@app.route("/")
def index():
    resp = "Funciona"
    return resp


@app.errorhandler(404)
def not_found(error=None):
    message = {
        'status': 404,
        'message': 'Not Found: ' + request.url,
    }
    resp = jsonify(message)
    resp.status_code = 404

    return resp


if __name__ == "__main__":
    app.run(port=8120)
