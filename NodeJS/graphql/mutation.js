const {
  GraphQLObjectType,
  GraphQLString,
  GraphQLInt,
  GraphQLList,
  GraphQLNonNull
} = require("graphql");

const session = require("../db/database");
const { Restaurant, Dish, Service, Province, Country } = require("./typedef");

const Mutation = new GraphQLObjectType({
  name: "Mutation",
  description: "Functions to set stuff",
  fields: () => {
    return {
      updateDish: {
        type: new GraphQLList(Dish),
        args: {
          name: {
            type: new GraphQLNonNull(GraphQLString)
          },
          price: {
            type: new GraphQLNonNull(GraphQLInt)
          },
          rating: {
            type: new GraphQLNonNull(GraphQLInt)
          }
        },
        resolve(source, args) {
          let query =
            "MATCH (n:Dish {name: {nameParam}}) SET n.price = {priceParam}, n.rating = {ratingParam} RETURN n";

          return session
            .run(query, {
              nameParam: args.name,
              priceParam: parseInt(args.price, 10),
              ratingParam: parseInt(args.rating, 10)
            })
            .then(result => {
              session.close();
              return result.records.map(record => {
                return record.get("n").properties;
              });
            })
            .catch(err => {
              console.log(err);
            });
        }
      },
      updateService: {
        type: new GraphQLList(Service),
        args: {
          name: {
            type: new GraphQLNonNull(GraphQLString)
          },
          price: {
            type: new GraphQLNonNull(GraphQLInt)
          }
        },
        resolve(source, args) {
          let query =
            "MATCH (n:Service {name: {nameParam}}) SET n.price = {priceParam} RETURN n";

          return session
            .run(query, {
              nameParam: args.name,
              priceParam: parseInt(args.price, 10)
            })
            .then(result => {
              session.close();
              return result.records.map(record => {
                return record.get("n").properties;
              });
            })
            .catch(err => {
              console.log(err);
            });
        }
      },
      updateRestaurant: {
        type: new GraphQLList(Restaurant),
        args: {
          name: {
            type: new GraphQLNonNull(GraphQLString)
          },
          address: {
            type: new GraphQLNonNull(GraphQLString)
          },
          contactNumber: {
            type: new GraphQLNonNull(GraphQLString)
          },
          disponibility: {
            type: new GraphQLNonNull(new GraphQLList(GraphQLString))
          }
        },
        resolve(source, args) {
          let query =
            "MATCH(n:Restaurant {name: $name}) SET n.address = $address, n.contactNumber = $contactNumber, n.disponibility = $disponibility RETURN n";

          return session
            .run(query, args)
            .then(result => {
              session.close();
              return result.records.map(record => {
                return record.get("n").properties;
              });
            })
            .catch(err => {
              console.log(err);
            });
        }
      },
      deleteDish: {
        type: Dish,
        args: {
          name: {
            type: new GraphQLNonNull(GraphQLString)
          }
        },
        resolve(source, args) {
          let query =
            "MATCH(n:Dish) where n.name = $name WITH n, { name: n.name, price: n.price, rating: n.rating } AS dish DETACH DELETE n RETURN dish";

          return session
            .run(query, args)
            .then(result => {
              let dish = {
                name: result.records[0].get("dish").name,
                price: result.records[0].get("dish").price.low,
                rating: result.records[0].get("dish").rating.low
              };

              session.close();
              return dish;
            })
            .catch(err => {
              console.log(err);
            });
        }
      },
      deleteService: {
        type: Service,
        args: {
          name: {
            type: new GraphQLNonNull(GraphQLString)
          }
        },
        resolve(source, args) {
          let query =
            "MATCH(n:Service) where n.name = $name WITH n, { name: n.name, price: n.price } AS service DETACH DELETE n RETURN service";

          return session
            .run(query, args)
            .then(result => {
              let service = {
                name: result.records[0].get("service").name,
                price: result.records[0].get("service").price.low
              };

              session.close();
              return service;
            })
            .catch(err => {
              console.log(err);
            });
        }
      },
      addCountry: {
        type: new GraphQLList(Country),
        args: {
          name: {
            type: new GraphQLNonNull(GraphQLString)
          }
        },
        resolve(source, args) {
          let query = "CREATE (n:Country {country: $name}) RETURN n";

          return session
            .run(query, args)
            .then(result => {
              session.close();
              return result.records.map(record => {
                return record.get("n").properties;
              });
            })
            .catch(err => {
              console.log(err);
            });
        }
      },
      addProvince: {
        type: new GraphQLList(Province),
        args: {
          name: {
            type: new GraphQLNonNull(GraphQLString)
          },
          province: {
            type: new GraphQLNonNull(GraphQLString)
          }
        },
        resolve(source, args) {
          let query =
            "CREATE (a:Province {province: $province}) WITH a MATCH (b:Country {country: $name}) MERGE (a)-[r:in]->(b) RETURN a";

          return session
            .run(query, args)
            .then(result => {
              session.close();
              return result.records.map(record => {
                return record.get("a").properties;
              });
            })
            .catch(err => {
              console.log(err);
            });
        }
      },
      addRestaurant: {
        type: new GraphQLList(Restaurant),
        args: {
          province: {
            type: new GraphQLNonNull(GraphQLString)
          },
          name: {
            type: new GraphQLNonNull(GraphQLString)
          },
          address: {
            type: new GraphQLNonNull(GraphQLString)
          },
          contactNumber: {
            type: new GraphQLNonNull(GraphQLString)
          },
          disponibility: {
            type: new GraphQLNonNull(new GraphQLList(GraphQLString))
          }
        },
        resolve(source, args) {
          let query =
            "CREATE (a:Restaurant {name: $name, address: $address, contactNumber: $contactNumber, disponibility: $disponibility}) WITH a MATCH (b:Province {province: $province}) MERGE (b)-[r:at]->(a) RETURN a";

          return session
            .run(query, args)
            .then(result => {
              session.close();
              return result.records.map(record => {
                return record.get("a").properties;
              });
            })
            .catch(err => {
              console.log(err);
            });
        }
      },
      addDish: {
        type: new GraphQLList(Dish),
        args: {
          restaurant: {
            type: new GraphQLNonNull(GraphQLString)
          },
          name: {
            type: new GraphQLNonNull(GraphQLString)
          },
          price: {
            type: new GraphQLNonNull(GraphQLInt)
          },
          rating: {
            type: new GraphQLNonNull(GraphQLInt)
          }
        },
        resolve(source, args) {
          let query =
            "CREATE (a:Dish {name: {nameParam}, price: {priceParam}, rating: {ratingParam}}) WITH a MATCH (b:Restaurant {name: {restaurantParam}}) MERGE (b)-[r:serves]->(a) RETURN a";

          return session
            .run(query, {
              nameParam: args.name,
              priceParam: parseInt(args.price),
              ratingParam: parseInt(args.rating),
              restaurantParam: args.restaurant
            })
            .then(result => {
              session.close();
              return result.records.map(record => {
                return record.get("a").properties;
              });
            })
            .catch(err => {
              console.log(err);
            });
        }
      },
      addService: {
        type: new GraphQLList(Service),
        args: {
          restaurant: {
            type: new GraphQLNonNull(GraphQLString)
          },
          name: {
            type: new GraphQLNonNull(GraphQLString)
          },
          price: {
            type: new GraphQLNonNull(GraphQLInt)
          }
        },
        resolve(source, args) {
          let query =
            "CREATE (a:Service {name: {nameParam}, price: {priceParam}}) WITH a MATCH (b:Restaurant {name: {restaurantParam}}) MERGE (b)-[r:offers]->(a) RETURN a";

          return session
            .run(query, {
              nameParam: args.name,
              priceParam: parseInt(args.price),
              restaurantParam: args.restaurant
            })
            .then(result => {
              session.close();
              return result.records.map(record => {
                return record.get("a").properties;
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

module.exports = Mutation;
