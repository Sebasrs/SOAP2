const neo4j = require("node-neo4j");
db = new neo4j("http://neo4j:12345@localhost:7474");

module.exports = db;
