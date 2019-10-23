package gql

import (
	"strconv"

	"../sql"

	"github.com/graphql-go/graphql"
)

// Resolver struct holds a connection to our database
type Resolver struct {
	db *sql.Db
}

// OrderResolver resolves our user query through a db call to GetOrders
func (r *Resolver) OrderResolver(p graphql.ResolveParams) (interface{}, error) {
	// Strip the name from arguments and assert that it's a string
	idRestaurant, ok := p.Args["idRestaurant"].(int)
	idClient, ok1 := p.Args["idClient"].(int)

	if ok {
		orders := r.db.GetOrdersByAttribute(strconv.Itoa(idRestaurant), "idRestaurant")
		return orders, nil
	} else if ok1 {
		orders := r.db.GetOrdersByAttribute(strconv.Itoa(idClient), "idClient")
		return orders, nil
	}

	orders := r.db.GetOrders()

	return orders, nil
}
