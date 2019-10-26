CREATE (costarica:Country{country:"Costa Rica"})

CREATE (sanjose:Province{province:"San Jose"}),
       (sanjose)-[:in]->(costarica),
       (cartago:Province{province:"Cartago"}),
       (cartago)-[:in]->(costarica),
       (alajuela:Province{province:"Alajuela"}),
       (alajuela)-[:in]->(costarica),
       (heredia:Province{province:"Heredia"}),
       (heredia)-[:in]->(costarica),
       (guanacaste:Province{province:"Guanacaste"}),
       (guanacaste)-[:in]->(costarica),
       (puntarenas:Province{province:"Puntarenas"}),
       (puntarenas)-[:in]->(costarica),
       (limon:Province{province:"Limon"}),
       (limon)-[:in]->(costarica)

CREATE (babi:Restaurant{name:"Babington'sGraphinaLichen", address:"2FlorenceCenter", contactNumber:"596-888-9072", disponibility:["Lunes a Viernes", "9am a 10pm"], enabled: 1}),
       (babi)<-[:at]-(alajuela),
       (steverogers:Dish{name: "HamburguesaSteveRogers", price: 3000, rating:5, enabled: 1}),
       (babi)-[:serves]->(steverogers),
       (bizarro:Dish{name: "BizarroPizza", price: 4500, rating:5, enabled: 1}),
       (babi)-[:serves]->(bizarro),
       (express:Service{name: "ExpressService", price: 1000, enabled: 1}),
       (babi)-[:offers]->(express)

CREATE (north:Restaurant{name:"NorthernWildrice", address:"96100BuhlerAvenue", contactNumber: "600-913-8210", disponibility:["Lunes a Viernes", "9am a 10pm"], enabled: 1}),
       (north)<-[:at]-(cartago),
       (pintortilla:Dish{name: "Pintortilla", price: 3000, rating:5, enabled: 1}),
       (north)-[:serves]->(pintortilla),
       (casado:Dish{name: "Casado", price: 2500, rating:5, enabled: 1}),
       (north)-[:serves]->(casado),
       (traditional:Service{name: "TraditionalCostaRicanAppearance", price: 500, enabled: 1}),
       (north)-[:offers]->(traditional)

CREATE (jap:Restaurant{name:"JapaneseSweetColtsfoot", address:"WyndhamHerraduraHotel", contactNumber:"600-913-8231", disponibility:["Lunes a Sábado", "9am a 10pm"], enabled: 1}),
       (jap)<-[:at]-(guanacaste),
       (cheeseburger:Dish{name: "TheBigCheeseburger", price: 6000, rating: 5, enabled: 1}),
       (jap)-[:serves]->(cheeseburger),
       (chickendsandwich:Dish{name: "GrilledChickenSandwich", price: 4000, rating: 5, enabled: 1}),
       (jap)-[:serves]->(chickendsandwich),
       (livemusic:Service{name: "LiveMusic", price: 2000, enabled: 1}),
       (jap)-[:offers]->(livemusic)

CREATE (pso:Restaurant{name:"PsorotichiaLichen", address:"99951TonyCourt", contactNumber:"402-526-7782", disponibility:["Lunes a Viernes", "9am a 10pm"], enabled: 1}),
       (pso)<-[:at]-(puntarenas),
       (salmon:Dish{name: "SalmonNigiri", price: 3000, rating: 5, enabled: 1}),
       (pso)-[:serves]->(salmon),
       (sushi:Dish{name: "SushiSignature", price: 5000, rating: 5, enabled: 1}),
       (pso)-[:serves]->(sushi),
       (livecooking:Service{name: "LiveCooking", price: 1000, enabled: 1}),
       (pso)-[:offers]->(livecooking)

CREATE (bos:Restaurant{name:"BostonIvy", address:"2FlorenceCenter", contactNumber:"596-888-9072", disponibility:["Lunes a Viernes", "9am a 10pm"], enabled: 1}),
       (bos)<-[:at]-(puntarenas),
       (tonystark:Dish{name: "HamburguesaTonyStark", price: 3000, rating:5, enabled: 1}),
       (bos)-[:serves]->(tonystark),
       (joker:Dish{name: "JokerPizza", price: 4500, rating:5, enabled: 1}),
       (bos)-[:serves]->(joker),
       (express2:Service{name: "ExpressService2", price: 1000, enabled: 1}),
       (bos)-[:offers]->(express2)

CREATE (plu:Restaurant{name: "PlumedGoldenrod", address:"51262SauthoffPoint", contactNumber: "596-888-9445", disponibility:["Lunes a Viernes", "9am a 10pm"], enabled: 1}),
       (plu)<-[:at]-(cartago),
       (pescado:Dish{name: "Pescado", price: 3000, rating:5, enabled: 1}),
       (plu)-[:serves]->(pescado),
       (pollo:Dish{name: "Pollo", price: 2500, rating:5, enabled: 1}),
       (plu)-[:serves]->(pollo),
       (traditional2:Service{name: "TraditionalCostaRicanAppearance2", price: 500, enabled: 1}),
       (plu)-[:offers]->(traditional2)

CREATE (car:Restaurant{name:"Carelessweed", address:"0916TennesseePlaza", contactNumber:"556-406-9779", disponibility:["Lunes a Sábado", "9am a 10pm"], enabled: 1}),
       (car)<-[:at]-(alajuela),
       (jamburger:Dish{name: "TheBigJamburger", price: 6000, rating: 5, enabled: 1}),
       (car)-[:serves]->(jamburger),
       (chickend:Dish{name: "GrilledChicken", price: 4000, rating: 5, enabled: 1}),
       (car)-[:serves]->(chickend),
       (livemusic2:Service{name: "LiveMusic2", price: 2000, enabled: 1}),
       (car)-[:offers]->(livemusic2)

CREATE (rus:Restaurant{name:"Rusby'sHawkweed", address:"5987LyonsParkway", contactNumber:"767-101-9966", disponibility:["Lunes a Viernes", "9am a 10pm"], enabled: 1}),
       (rus)<-[:at]-(guanacaste),
       (salmonk:Dish{name: "SalmonNigiki", price: 3000, rating: 5, enabled: 1}),
       (rus)-[:serves]->(salmonk),
       (sushish:Dish{name: "Sushi", price: 5000, rating: 5, enabled: 1}),
       (rus)-[:serves]->(sushish),
       (livecooking2:Service{name: "LiveCooking2", price: 1000, enabled: 1}),
       (rus)-[:offers]->(livecooking2)

CREATE (yel:Restaurant{name:"YellowPepperweed", address:"2437MelroseStreet", contactNumber:"358-363-0460", disponibility:["Lunes a Viernes", "9am a 10pm"], enabled: 1}),
       (yel)<-[:at]-(sanjose),
       (clarkkent:Dish{name: "HamburguesaClarkKent", price: 3000, rating:5, enabled: 1}),
       (yel)-[:serves]->(clarkkent),
       (jondu:Dish{name: "JonduPizza", price: 4500, rating:5, enabled: 1}),
       (yel)-[:serves]->(jondu),
       (express3:Service{name: "ExpressService3", price: 1000, enabled: 1}),
       (yel)-[:offers]->(express3)

CREATE (lon:Restaurant{name: "LongflowerThreadplant", address:"545FiskTrail", contactNumber: "356-450-2387", disponibility:["Lunes a Viernes", "9am a 10pm"], enabled: 1}),
       (lon)<-[:at]-(limon),
       (carne:Dish{name: "Carne", price: 3000, rating:5, enabled: 1}),
       (lon)-[:serves]->(carne),
       (vegetales:Dish{name: "Vegetales", price: 2500, rating:5, enabled: 1}),
       (lon)-[:serves]->(vegetales),
       (traditional3:Service{name: "TraditionalCostaRicanAppearance3", price: 500, enabled: 1}),
       (lon)-[:offers]->(traditional3)

