const neo4j = require("node-neo4j");
db = new neo4j("neo4j:123456@neo4j:7474");

module.exports = db;
