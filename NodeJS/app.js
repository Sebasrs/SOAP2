const express = require("express");
const bodyparser = require("body-parser");

const db = require("./db/database");

const PORT = 3001;
const app = express();

app.use(bodyparser.json());

require("./routes/restaurants")(app, db);
require("./routes/dishes")(app, db);
require("./routes/services")(app, db);

app.listen(PORT, () => {
  console.log(`Listen on port ${PORT}`);
});
