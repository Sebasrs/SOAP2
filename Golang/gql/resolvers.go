package gql

import (
	"../sql"

	"github.com/graphql-go/graphql"
)

// Resolver struct holds a connection to our database
type Resolver struct {
	db *sql.Db
}

// ClientResolver resolves our user query through a db call to GetUserByName
func (r *Resolver) ClientResolver(p graphql.ResolveParams) (interface{}, error) {
	// Strip the name from arguments and assert that it's a string
	name, ok := p.Args["fName"].(string)

	if ok {
		users := r.db.GetClientsByName(name)
		return users, nil
	} else {
		users := r.db.GetClients()
		return users, nil
	}
}
