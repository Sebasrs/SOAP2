package sql

import (
	"database/sql"
	"fmt"
	"time"

	//mysql driver
	_ "github.com/go-sql-driver/mysql"
)

// Db struct to interact with the database
type Db struct {
	*sql.DB
}

// Client shape
type Client struct {
	IDClient       int
	FName          string
	LName          string
	Address        string
	Identification string
}

//Restaurant shape
type Restaurant struct {
	IDRestaurant       int
	Name               string
	Address            string
	DisponibilityDays  string
	DisponibilityHours string
	ContactNumber      string
}

// Order shape
type Order struct {
	IDOrder      int
	IDClient     Client
	IDRestaurant Restaurant
	OrderDate    time.Time
}

// GetOrdersByAttribute is called within our user query for graphql
func (d *Db) GetOrdersByAttribute(name string, col string) []Order {
	var query string
	query = `SELECT name, restaurants.address, contactNumber, disponibilityDays, disponibilityHours, fName, lName, clients.address, identification, orderDate
					 FROM orders 
					 INNER JOIN soa.restaurants 
			  		 ON soa.orders.idRestaurant = soa.restaurants.idRestaurant 
			 		 INNER JOIN soa.clients 
		 				 ON soa.orders.idClient = soa.clients.idClient 
					 WHERE soa.orders.`

	if col != "none" {
		query = query + col + "=" + name
	}

	stmt, err := d.Prepare(query)
	if err != nil {
		fmt.Println("GetOrdersByAttribute Preperation Err: ", err)
	}

	rows, err := stmt.Query()
	if err != nil {
		fmt.Println("GetOrdersByAttribute Query Err: ", err)
	}

	var dbClient Client
	var dbRestaurant Restaurant
	var dbOrder Order
	var date string

	dateLayout := "2006-01-02 15:04:05"

	orders := []Order{}

	for rows.Next() {
		err = rows.Scan(
			&dbRestaurant.Name,
			&dbRestaurant.Address,
			&dbRestaurant.ContactNumber,
			&dbRestaurant.DisponibilityDays,
			&dbRestaurant.DisponibilityHours,
			&dbClient.FName,
			&dbClient.LName,
			&dbClient.Address,
			&dbClient.Identification,
			&date,
		)

		dbOrder.IDClient = dbClient
		dbOrder.IDRestaurant = dbRestaurant
		dbOrder.OrderDate, _ = time.Parse(dateLayout, date)

		if err != nil {
			fmt.Println("Error scanning rows: ", err)
		}

		orders = append(orders, dbOrder)
	}

	return orders
}

// CreateOrder is called within our createOrder mutation for graphql
func (d *Db) CreateOrder(idRestaurant int, idClient int) Order {
	var query = "INSERT INTO orders (idRestaurant, idClient) VALUES (?, ?)"

	stmt, err := d.Prepare(query)

	if err != nil {
		fmt.Println("GetOrdersByAttribute Preperation Err: ", err)
	}

	res, err := stmt.Exec(idRestaurant, idClient)

	if err != nil {
		fmt.Println("GetOrdersByAttribute Query Err: ", err)
	}

	var dbOrder Order

	orderID, _ := res.LastInsertId()
	dbOrder.IDOrder = int(orderID)

	return dbOrder
}

// DeleteOrder is called within our user query for graphql
func (d *Db) DeleteOrder(idOrder int) int {
	var query = "DELETE FROM orders WHERE idOrder = ?"
	stmt, err := d.Prepare(query)
	if err != nil {
		fmt.Println("GetOrdersByAttribute Preperation Err: ", err)
	}

	res, err := stmt.Exec(idOrder)
	if err != nil {
		fmt.Println("GetOrdersByAttribute Query Err: ", err)
	}

	rowsAffected, _ := res.RowsAffected()

	return int(rowsAffected)
}

// UpdateOrder is called within our user query for graphql
func (d *Db) UpdateOrder(idOrder int, newClientID int) int {
	var query = "UPDATE orders SET idClient = ? WHERE idOrder = ?"

	stmt, err := d.Prepare(query)

	if err != nil {
		fmt.Println("GetOrdersByAttribute Preperation Err: ", err)
	}

	res, err := stmt.Exec(newClientID, idOrder)

	if err != nil {
		fmt.Println("GetOrdersByAttribute Query Err: ", err)
	}

	rowsAffected, _ := res.RowsAffected()

	return int(rowsAffected)
}
