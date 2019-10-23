const {
  GraphQLObjectType,
  GraphQLString,
  GraphQLInt,
  GraphQLList
} = require("graphql");

const session = require("../db/database");

const Restaurant = new GraphQLObjectType({
  name: "Restaurant",
  description: "This represents a Restaurant",
  fields: () => {
    return {
      contactNumber: {
        type: GraphQLString,
        resolve(restaurant) {
          return restaurant.contactNumber;
        }
      },
      name: {
        type: GraphQLString,
        resolve(restaurant) {
          return restaurant.name;
        }
      },
      address: {
        type: GraphQLString,
        resolve(restaurant) {
          return restaurant.address;
        }
      },
      disponibility: {
        type: new GraphQLList(GraphQLString),
        resolve(restaurant) {
          return restaurant.disponibility;
        }
      },
      dishes: {
        type: new GraphQLList(Dish),
        resolve(restaurant) {
          let query =
            "MATCH (:Restaurant {name: {nameParam}})-[:serves]->(dish) RETURN dish";
          return session
            .run(query, { nameParam: restaurant.name })
            .then(result => {
              return result.records.map(record => {
                return record.get("dish").properties;
              });
            })
            .catch(err => {
              console.log(err);
            });
        }
      },
      services: {
        type: new GraphQLList(Service),
        resolve(restaurant) {
          let query =
            "MATCH (:Restaurant {name: {nameParam}})-[:offers]->(service) RETURN service";
          return session
            .run(query, { nameParam: restaurant.name })
            .then(result => {
              return result.records.map(record => {
                return record.get("service").properties;
              });
            })
            .catch(err => {
              console.log(err);
            });
        }
      },
      provinces: {
        type: new GraphQLList(Province),
        resolve(restaurant) {
          let query =
            "MATCH (:Restaurant {name: {nameParam}})<-[:at]-(province) RETURN province";
          return session
            .run(query, { nameParam: restaurant.name })
            .then(result => {
              return result.records.map(record => {
                return record.get("province").properties;
              });
            })
            .catch(err => {
              console.log(err);
            });
        }
      },
      country: {
        type: new GraphQLList(Country),
        resolve(restaurant) {
          let query =
            "MATCH (:Restaurant {name: {nameParam}})<-[:at]-(province)-[:in]->(country) RETURN country";
          return session
            .run(query, { nameParam: restaurant.name })
            .then(result => {
              return result.records.map(record => {
                return record.get("country").properties;
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

const Dish = new GraphQLObjectType({
  name: "Dish",
  description: "This represents a dish",
  fields: () => {
    return {
      rating: {
        type: GraphQLInt,
        resolve(dish) {
          return parseInt(dish.rating, 10);
        }
      },
      name: {
        type: GraphQLString,
        resolve(dish) {
          return dish.name;
        }
      },
      price: {
        type: GraphQLInt,
        resolve(dish) {
          return parseInt(dish.price, 10);
        }
      },
      restaurants: {
        type: new GraphQLList(Restaurant),
        resolve(dish) {
          let query =
            "MATCH (:Dish {name: {nameParam}})<-[:serves]-(restaurant) RETURN restaurant";
          return session
            .run(query, { nameParam: dish.name })
            .then(result => {
              return result.records.map(record => {
                return record.get("restaurant").properties;
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

const Service = new GraphQLObjectType({
  name: "Service",
  description: "This represents a service",
  fields: () => {
    return {
      name: {
        type: GraphQLString,
        resolve(service) {
          return service.name;
        }
      },
      price: {
        type: GraphQLString,
        resolve(service) {
          return parseInt(service.price, 10);
        }
      },
      restaurants: {
        type: new GraphQLList(Restaurant),
        resolve(service) {
          let query =
            "MATCH (:Service {name: {nameParam}})<-[:offers]-(restaurant) RETURN restaurant";
          return session
            .run(query, { nameParam: service.name })
            .then(result => {
              return result.records.map(record => {
                return record.get("restaurant").properties;
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

const Province = new GraphQLObjectType({
  name: "Province",
  description: "This represents a province",
  fields: () => {
    return {
      province: {
        type: GraphQLString,
        resolve(province) {
          return province.province;
        }
      }
    };
  }
});

const Country = new GraphQLObjectType({
  name: "Country",
  description: "This represents a country",
  fields: () => {
    return {
      country: {
        type: GraphQLString,
        resolve(country) {
          return country.country;
        }
      }
    };
  }
});

module.exports = {
  Restaurant,
  Dish,
  Service,
  Province,
  Country
};
