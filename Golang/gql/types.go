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

// Restaurant describes a graphql object containing a Restaurant
var Restaurant = graphql.NewObject(
	graphql.ObjectConfig{
		Name: "restaurant",
		Fields: graphql.Fields{
			"name": &graphql.Field{
				Type: graphql.String,
			},
			"address": &graphql.Field{
				Type: graphql.String,
			},
			"contactNumber": &graphql.Field{
				Type: graphql.String,
			},
			"disponibilityDays": &graphql.Field{
				Type: graphql.String,
			},
			"disponibilityHours": &graphql.Field{
				Type: graphql.String,
			},
		},
	},
)

// Order describes a graphql object containing a Order
var Order = graphql.NewObject(
	graphql.ObjectConfig{
		Name: "order",
		Fields: graphql.Fields{
			"idClient": &graphql.Field{
				Type: Client,
			},
			"idRestaurant": &graphql.Field{
				Type: Restaurant,
			},
			"orderDate": &graphql.Field{
				Type: graphql.DateTime,
			},
		},
	},
)
