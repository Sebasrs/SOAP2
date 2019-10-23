package gql

import "github.com/graphql-go/graphql"

// Client describes a graphql object containing a User
var Client = graphql.NewObject(
	graphql.ObjectConfig{
		Name: "client",
		Fields: graphql.Fields{
			"fName": &graphql.Field{
				Type: graphql.String,
			},
			"lName": &graphql.Field{
				Type: graphql.String,
			},
			"address": &graphql.Field{
				Type: graphql.String,
			},
			"identification": &graphql.Field{
				Type: graphql.String,
			},
		},
	},
)
