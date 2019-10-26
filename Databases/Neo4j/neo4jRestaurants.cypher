CREATE (costarica:Country{country:"Costa Rica"})

CREATE (cartago:Province{province:"Cartago"}),
       (cartago)-[:in]->(costarica),
       (sanjose:Province{province:"San José"}),
       (sanjose)-[:in]->(costarica)

CREATE (lasanwuchera:Restaurant{name:"La Sanwuchera", address:"Frente al ITCR", contactNumber:"25567878", disponibility:["Lunes a Viernes", "12:00am a 9:00pm"], enabled: 1}),
       (lasanwuchera)<-[:at]-(cartago),
       (steverogers:Dish{name: "Hamburguesa Steve Rogers", price: 3000, rating:5, enabled: 1}),
       (lasanwuchera)-[:serves]->(steverogers),
       (bizarro:Dish{name: "Bizarro Pizza", price: 4500, rating:5, enabled: 1}),
       (lasanwuchera)-[:serves]->(bizarro),
       (express:Service{name: "Express Service", price: 1000, enabled: 1}),
       (lasanwuchera)-[:offers]->(express)

CREATE (latorilleria:Restaurant{name:"La Tortillería", address:"Frente a la basilica de los angeles", contactNumber: "25565935", disponibility:["Lunes a Viernes", "8:00am a 6:00pm"], enabled: 1}),
       (latorilleria)<-[:at]-(cartago),
       (pintortilla:Dish{name: "Pintortilla", price: 3000, rating:5, enabled: 1}),
       (latorilleria)-[:serves]->(pintortilla),
       (casado:Dish{name: "Casado", price: 2500, rating:5, enabled: 1}),
       (latorilleria)-[:serves]->(casado),
       (traditional:Service{name: "Traditional Costa Rican appearance", price: 500, enabled: 1}),
       (latorilleria)-[:offers]->(traditional)

CREATE (hardrockcafe:Restaurant{name:"Hard Rock Cafe", address:"Wyndham Herradura Hotel", contactNumber:"25563432", disponibility:["Lunes a Sábado", "12:00am a 11:00pm"], enabled: 1}),
       (hardrockcafe)<-[:at]-(sanjose),
       (cheeseburger:Dish{name: "The Big Cheeseburger", price: 6000, rating: 5, enabled: 1}),
       (hardrockcafe)-[:serves]->(cheeseburger),
       (chickendsandwich:Dish{name: "Grilled Chicken Sandwich", price: 4000, rating: 5, enabled: 1}),
       (hardrockcafe)-[:serves]->(chickendsandwich),
       (livemusic:Service{name: "Live Music", price: 2000, enabled: 1}),
       (hardrockcafe)-[:offers]->(livemusic)

CREATE (matsuri:Restaurant{name:"Matsuri", address:"Bv. Ernesto Rohrmoser", contactNumber:"25561194", disponibility:["Lunes a Viernes", "1:00pm a 9:00pm"], enabled: 1}),
       (matsuri)<-[:at]-(sanjose),
       (salmon:Dish{name: "Salmon Nigiri", price: 3000, rating: 5, enabled: 1}),
       (matsuri)-[:serves]->(salmon),
       (sushi:Dish{name: "Sushi Signature", price: 5000, rating: 5, enabled: 1}),
       (matsuri)-[:serves]->(sushi),
       (livecooking:Service{name: "Live Cooking", price: 1000, enabled: 1}),
       (matsuri)-[:offers]->(livecooking)


