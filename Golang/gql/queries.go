package gql

import (
	"../sql"
	"github.com/graphql-go/graphql"
)

// Root holds a pointer to a graphql object
type Root struct {
	Query *graphql.Object
}

// NewRoot returns base query type. This is where we add all the base queries
func NewRoot(db *sql.Db) *Root {
	// Create a resolver holding our databse. Resolver can be found in resolvers.go
	resolver := Resolver{db: db}

	// Create a new Root that describes our base query set up. In this
	// example we have a user query that takes one argument called name
	root := Root{
		Query: graphql.NewObject(
			graphql.ObjectConfig{
				Name: "Query",
				Fields: graphql.Fields{
					"orders": &graphql.Field{
						Type: graphql.NewList(Order),
						Args: graphql.FieldConfigArgument{
							"orderDate": &graphql.ArgumentConfig{
								Type: graphql.DateTime,
							},
							"idRestaurant": &graphql.ArgumentConfig{
								Type: graphql.Int,
							},
							"idClient": &graphql.ArgumentConfig{
								Type: graphql.Int,
							},
						},
						Resolve: resolver.OrderResolver,
					},
				},
			},
		),
	}
	return &root
}
