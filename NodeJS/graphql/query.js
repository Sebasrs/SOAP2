const {
  GraphQLObjectType,
  GraphQLString,
  GraphQLList,
  GraphQLNonNull
} = require("graphql");

const session = require("../db/database");
const { Restaurant, Dish, Service, Province, Country } = require("./typedef");

const Query = new GraphQLObjectType({
  name: "Query",
  description: "Root query object",
  fields: () => {
    return {
      restaurants: {
        type: new GraphQLList(Restaurant),
        args: {
          name: {
            type: GraphQLString
          }
        },
        resolve(root, args) {
          let query =
            args.name == ""
              ? "MATCH (n:Restaurant) RETURN n"
              : "MATCH (n:Restaurant) WHERE n.name = $name RETURN n";

          return session
            .run(query, args)
            .then(result => {
              return result.records.map(record => {
                return record.get("n").properties;
              });
            })
            .catch(err => {
              console.log(err);
            });
        }
      },
      dishes: {
        type: new GraphQLList(Dish),
        args: {
          name: {
            type: GraphQLString
          }
        },
        resolve(root, args) {
          let query =
            args.name == ""
              ? "MATCH (n:Dish) RETURN n"
              : "MATCH (n:Dish) WHERE n.name = $name RETURN n";

          return session
            .run(query, args)
            .then(result => {
              return result.records.map(record => {
                return record.get("n").properties;
              });
            })
            .catch(err => {
              console.log(err);
            });
        }
      },
      services: {
        type: new GraphQLList(Service),
        args: {
          name: {
            type: GraphQLString
          }
        },
        resolve(root, args) {
          let query =
            args.name == ""
              ? "MATCH (n:Service) RETURN n"
              : "MATCH (n:Service) WHERE n.name = $name RETURN n";

          return session
            .run(query, args)
            .then(result => {
              return result.records.map(record => {
                return record.get("n").properties;
              });
            })
            .catch(err => {
              console.log(err);
            });
        }
      },
      provinces: {
        type: new GraphQLList(Province),
        args: {
          province: {
            type: GraphQLString
          }
        },
        resolve(root, args) {
          let query =
            args.name == ""
              ? "MATCH (n:Province) RETURN n"
              : "MATCH (n:Province) WHERE n.province = $province RETURN n";

          return session
            .run(query, args)
            .then(result => {
              return result.records.map(record => {
                return record.get("n").properties;
              });
            })
            .catch(err => {
              console.log(err);
            });
        }
      },
      countries: {
        type: new GraphQLList(Country),
        args: {
          country: {
            type: GraphQLString
          }
        },
        resolve(root, args) {
          let query =
            args.name == ""
              ? "MATCH (n:Country) RETURN n"
              : "MATCH (n:Country) WHERE n.country = $country RETURN n";

          return session
            .run(query, args)
            .then(result => {
              return result.records.map(record => {
                return record.get("n").properties;
              });
            })
            .catch(err => {
              console.log(err);
            });
        }
      }
    };
  }
});

module.exports = Query;
