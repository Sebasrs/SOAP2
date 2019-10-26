module.exports = (app, db) => {
  app.get("/catalog/dishes", (req, res) => {
    let query = "MATCH (n:Dish) RETURN n";

    db.cypherQuery(query, function(err, result) {
      if (err) res.send(err);

      res.send(result.data);
    });
  });

  app.get("/catalog/dishes/:id", (req, res) => {
    db.readNode(req.params.id, function(err, node) {
      if (err) throw err;

      res.send(node);
    });
  });

  app.post("/catalog/dishes", (req, res) => {
    let query =
      "CREATE (a:Dish {name: '" +
      req.body.name +
      "', price: " +
      req.body.price +
      ", rating: " +
      req.body.rating +
      ", enabled: 1}) WITH a MATCH (b:Province {restaurant: '" +
      req.body.restaurant +
      "'}) MERGE (b)-[r:at]->(a) RETURN a";

    db.cypherQuery(query, function(err, result) {
      if (err) res.send(err);

      res.send(result);
    });
  });

  app.put("/catalog/dishes/:id", (req, res) => {
    db.updateNode(
      req.params.id,
      {
        name: req.body.name,
        rating: req.body.rating,
        price: req.body.price,
        enabled: 1
      },
      function(err, node) {
        if (err) throw err;

        if (node === true) {
          res.send(node);
        } else {
          res.send(err);
        }
      }
    );
  });

  app.delete("/catalog/dishes/:name", (req, res) => {
    let query =
      "MATCH (n:Dish {name: '" +
      req.params.name +
      "'}) SET n.enabled = 0 RETURN n";

    db.cypherQuery(query, function(err, result) {
      if (err) res.send(err);

      res.send(result);
    });
  });
};
