const express = require("express");
const expressql = require("express-graphql");
const schema = require("./graphql/schema");

const PORT = 5000;
const app = express();

app.use(
  "/graphql",
  expressql({
    schema: schema,
    pretty: true,
    graphiql: true
  })
);

app.listen(PORT, () => {
  console.log(`Listen on port ${PORT}`);
});
