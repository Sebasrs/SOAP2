package dbmanager

import "database/sql"

//Dbquery database interface
func Dbquery(query string) *sql.Rows {

	db, err := sql.Open("mysql", "root:Serbas1500@tcp(127.0.0.1:3306)/SOAP2")

	// if there is an error opening the connection, handle it
	if err != nil {
		panic(err.Error())
	}

	result, err := db.Query(query)

	// if there is an error inserting, handle it
	if err != nil {
		panic(err.Error())
	}

	// defer the close till after the main function has finished
	// executing
	defer db.Close()

	return result
}
