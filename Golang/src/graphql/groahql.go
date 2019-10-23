package graphql

import (
	"github.com/graphql-go/graphql"
	"github.com/graphql-go/handler"

	_ "github.com/go-sql-driver/mysql"
)

// Schema
var fields = graphql.Fields{
	"hello": &graphql.Field{
		Type: graphql.String,
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {
			return "world", nil
		},
	},
}
var rootQuery = graphql.ObjectConfig{Name: "RootQuery", Fields: fields}
var schemaConfig = graphql.SchemaConfig{Query: graphql.NewObject(rootQuery)}
var schema, err = graphql.NewSchema(schemaConfig)

//H GraphQL Schema
var H = handler.New(&handler.Config{
	Schema:   &schema,
	Pretty:   true,
	GraphiQL: true,
})
