package sql

import (
	"database/sql"
	"fmt"
	"time"

	//mysql driver
	_ "github.com/go-sql-driver/mysql"
)

// Db is our database struct used for interacting with the database
type Db struct {
	*sql.DB
}

// New makes a new database using the connection string and
// returns it, otherwise returns the error
func New(connString string) (*Db, error) {
	db, err := sql.Open("mysql", connString)
	if err != nil {
		return nil, err
	}

	// Check that our connection is good
	err = db.Ping()
	if err != nil {
		return nil, err
	}

	return &Db{db}, nil
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
	if col != "none" {
		query = "SELECT name, restaurants.address, contactNumber, disponibilityDays, disponibilityHours, fName, lName, clients.address, identification, orderDate FROM orders INNER JOIN soa.restaurants ON soa.orders.idRestaurant = soa.restaurants.idRestaurant INNER JOIN soa.clients ON soa.orders.idClient = soa.clients.idClient WHERE soa.orders." + col + "=" + name
	} else {
		query = "SELECT name, restaurants.address, contactNumber, disponibilityDays, disponibilityHours, fName, lName, clients.address, identification, orderDate FROM orders INNER JOIN soa.restaurants ON soa.orders.idRestaurant = soa.restaurants.idRestaurant INNER JOIN soa.clients ON soa.orders.idClient = soa.clients.idClient"
	}
	stmt, err := d.Prepare(query)
	if err != nil {
		fmt.Println("GetOrdersByAttribute Preperation Err: ", err)
	}

	// Make query with our stmt, passing in name argument
	rows, err := stmt.Query()
	if err != nil {
		fmt.Println("GetOrdersByAttribute Query Err: ", err)
	}

	// Create User struct for holding each row's data
	var r Client
	var t Restaurant
	var o Order
	var date string
	layout := "2006-01-02 15:04:05"
	// Create slice of Client for our response
	orders := []Order{}
	// Copy the columns from row into the values pointed at by r (Client)
	for rows.Next() {
		err = rows.Scan(
			&t.Name,
			&t.Address,
			&t.ContactNumber,
			&t.DisponibilityDays,
			&t.DisponibilityHours,
			&r.FName,
			&r.LName,
			&r.Address,
			&r.Identification,
			&date,
		)
		o.IDClient = r
		o.IDRestaurant = t
		o.OrderDate, _ = time.Parse(layout, date)
		if err != nil {
			fmt.Println("Error scanning rows: ", err)
		}
		orders = append(orders, o)
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
	// Executes te insert
	res, err := stmt.Exec(idRestaurant, idClient)
	if err != nil {
		fmt.Println("GetOrdersByAttribute Query Err: ", err)
	}

	var o Order

	orderID, _ := res.LastInsertId()
	o.IDOrder = int(orderID)

	return o
}

// DeleteOrder is called within our user query for graphql
func (d *Db) DeleteOrder(idOrder int) int {
	var query = "DELETE FROM orders WHERE idOrder = ?"
	stmt, err := d.Prepare(query)
	if err != nil {
		fmt.Println("GetOrdersByAttribute Preperation Err: ", err)
	}
	// Make query with our stmt, passing in name argument
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
	// Make query with our stmt, passing in name argument
	res, err := stmt.Exec(newClientID, idOrder)
	if err != nil {
		fmt.Println("GetOrdersByAttribute Query Err: ", err)
	}

	rowsAffected, _ := res.RowsAffected()

	return int(rowsAffected)
}
