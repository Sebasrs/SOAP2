package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/Sebasrs/SOAP2/Golang/gql"
	"github.com/Sebasrs/SOAP2/Golang/server"
	"github.com/Sebasrs/SOAP2/Golang/sql"

	"github.com/go-chi/chi"
	"github.com/go-chi/chi/middleware"
	"github.com/go-chi/render"
	"github.com/graphql-go/graphql"
)

func main() {

	router, db := initializeAPI()
	defer db.Close()

	// Deploy server on port 8100
	log.Fatal(http.ListenAndServe(":8100", router))
}

func initializeAPI() (*chi.Mux, *sql.Db) {
	router := chi.NewRouter()

	// Database connection
	db, err := sql.New("root:password@tcp(mysql:3306)/soa")

	if err != nil {
		log.Fatal(err)
	}

	rootQuery := gql.NewRoot(db)

	sc, err := graphql.NewSchema(
		graphql.SchemaConfig{Query: rootQuery.Query, Mutation: rootQuery.Mutation},
	)
	if err != nil {
		fmt.Println("Error creating schema: ", err)
	}

	s := server.Server{
		GqlSchema: &sc,
	}

	router.Use(
		render.SetContentType(render.ContentTypeJSON),
		middleware.Logger,
		middleware.DefaultCompress,
		middleware.StripSlashes,
		middleware.Recoverer,
	)

	// Create the graphql route with a Server method to handle it
	router.Get("/orders", s.ServiceWelcome())
	router.Post("/orders/graphql", s.GraphQL())
	return router, db
}
