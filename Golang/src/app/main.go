package main

import (
	"encoding/json"
	"fmt"
	"net/http"

	db "../dbmanager"
	gql "../graphql"
)

func main() {

	http.Handle("/graphql", gql.H)

	http.HandleFunc("/", root)

	http.HandleFunc("/hola", helloWorld)

	http.ListenAndServe(":8080", nil)

}

func root(w http.ResponseWriter, r *http.Request) {
	type User struct {
		Name string `json:"name"`
		ID   int    `json:"id"`
	}

	users := []User{}

	result := db.Dbquery("SELECT id, name FROM user")

	var user User
	for result.Next() {
		err := result.Scan(&user.ID, &user.Name)
		if err != nil {
			panic("ERROR")
		}

		users = append(users, user)
	}

	result.Close()

	json, err := json.Marshal(users)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.Write(json)
}

func helloWorld(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello World\n")
}
