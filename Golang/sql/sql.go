package sql

import (
	"database/sql"
	"fmt"

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

// GetClientsByName is called within our user query for graphql
func (d *Db) GetClientsByName(name string) []Client {
	// Prepare query, takes a name argument, protects from sql injection
	stmt, err := d.Prepare("SELECT idClient, fName, lName, address, identification FROM clients WHERE fName='" + name + "'")
	if err != nil {
		fmt.Println("GetUserByName Preperation Err: ", err)
	}

	// Make query with our stmt, passing in name argument
	rows, err := stmt.Query()
	if err != nil {
		fmt.Println("GetUserByName Query Err: ", err)
	}

	// Create User struct for holding each row's data
	var r Client
	// Create slice of Users for our response
	clients := []Client{}
	// Copy the columns from row into the values pointed at by r (User)
	for rows.Next() {
		err = rows.Scan(
			&r.IDClient,
			&r.FName,
			&r.LName,
			&r.Address,
			&r.Identification,
		)
		if err != nil {
			fmt.Println("Error scanning rows: ", err)
		}
		clients = append(clients, r)
	}

	return clients
}

// GetClients is called within our user query for graphql
func (d *Db) GetClients() []Client {
	// Prepare query, takes a name argument, protects from sql injection
	stmt, err := d.Prepare("SELECT idClient, fName, lName, address, identification FROM clients")
	if err != nil {
		fmt.Println("GetUserByName Preperation Err: ", err)
	}

	// Make query with our stmt, passing in name argument
	rows, err := stmt.Query()
	if err != nil {
		fmt.Println("GetUserByName Query Err: ", err)
	}

	// Create User struct for holding each row's data
	var r Client
	// Create slice of Users for our response
	clients := []Client{}
	// Copy the columns from row into the values pointed at by r (User)
	for rows.Next() {
		err = rows.Scan(
			&r.IDClient,
			&r.FName,
			&r.LName,
			&r.Address,
			&r.Identification,
		)
		if err != nil {
			fmt.Println("Error scanning rows: ", err)
		}
		clients = append(clients, r)
	}

	return clients
}
