module.exports = (app, db) => {
  app.get("/restaurants", (req, res) => {
    let query = "MATCH (n:Restaurant) RETURN n";

    db.cypherQuery(query, function(err, result) {
      if (err) res.send(query);

      res.send(result.data);
    });
  });

  app.get("/restaurants/:id", (req, res) => {
    db.readNode(req.params.id, function(err, node) {
      if (err) throw err;

      res.send(node);
    });
  });

  app.post("/restaurants", (req, res) => {
    let query =
      "CREATE (a:Restaurant {name: '" +
      req.body.name +
      "', address: '" +
      req.body.address +
      "', contactNumber: '" +
      req.body.contactNumber +
      "', disponibility: '" +
      req.body.disponibility +
      "', enabled: 1}) WITH a MATCH (b:Province {province: '" +
      req.body.province +
      "'}) MERGE (b)-[r:at]->(a) RETURN a";

    console.log(query);

    db.cypherQuery(query, function(err, result) {
      if (err) res.send(query);

      res.send(result);
    });
  });

  app.put("/restaurants/:id", (req, res) => {
    db.updateNode(
      req.params.id,
      {
        contactNumber: req.body.contactNumber,
        name: req.body.name,
        address: req.body.address,
        disponibility: req.body.disponibility,
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

  app.delete("/restaurants/:name", (req, res) => {
    let query =
      "MATCH (n:Restaurant {name: '" +
      req.params.name +
      "'}) SET n.enabled = 0 RETURN n";

    db.cypherQuery(query, function(err, result) {
      if (err) res.send(query);

      res.send(result);
    });
  });
};
