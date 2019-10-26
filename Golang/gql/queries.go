package gql

import (
	"github.com/Sebasrs/SOAP2/Golang/sql"
	"github.com/graphql-go/graphql"
)

// Root holds a pointer to a graphql object
type Root struct {
	Query    *graphql.Object
	Mutation *graphql.Object
}

// NewRoot returns base query type. This is where we add all the base queries
func NewRoot(db *sql.Db) *Root {

	resolver := Resolver{db: db}

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
		Mutation: graphql.NewObject(
			graphql.ObjectConfig{
				Name: "Mutation",
				Fields: graphql.Fields{
					"createOrder": &graphql.Field{
						Type: Order,
						Args: graphql.FieldConfigArgument{
							"idRestaurant": &graphql.ArgumentConfig{
								Type: graphql.NewNonNull(graphql.Int),
							},
							"idClient": &graphql.ArgumentConfig{
								Type: graphql.NewNonNull(graphql.Int),
							},
						},
						Resolve: resolver.OrderCreator,
					},
					"deleteOrder": &graphql.Field{
						Type: graphql.Int,
						Args: graphql.FieldConfigArgument{
							"idOrder": &graphql.ArgumentConfig{
								Type: graphql.NewNonNull(graphql.Int),
							},
						},
						Resolve: resolver.OrderDeleter,
					},
					"updateOrder": &graphql.Field{
						Type: graphql.Int,
						Args: graphql.FieldConfigArgument{
							"idOrder": &graphql.ArgumentConfig{
								Type: graphql.NewNonNull(graphql.Int),
							},
							"newClientId": &graphql.ArgumentConfig{
								Type: graphql.NewNonNull(graphql.Int),
							},
						},
						Resolve: resolver.OrderUpdater,
					},
				},
			}),
	}
	return &root
}
