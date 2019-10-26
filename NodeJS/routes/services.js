module.exports = (app, db) => {
  app.get("/catalog/services", (req, res) => {
    let query = "MATCH (n:Service) RETURN n";

    db.cypherQuery(query, function(err, result) {
      if (err) res.send(err);

      res.send(result.data);
    });
  });

  app.get("/catalog/services/:id", (req, res) => {
    db.readNode(req.params.id, function(err, node) {
      if (err) throw err;

      res.send(node);
    });
  });

  app.put("/catalog/services/:id", (req, res) => {
    db.updateNode(
      req.params.id,
      {
        name: req.body.name,
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

  app.delete("/catalog/services/:name", (req, res) => {
    let query =
      "MATCH (n:Service {name: '" +
      req.params.name +
      "'}) SET n.enabled = 0 RETURN n";

    db.cypherQuery(query, function(err, result) {
      if (err) res.send(err);

      res.send(result);
    });
  });
};
