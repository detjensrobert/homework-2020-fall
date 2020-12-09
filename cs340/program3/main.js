const express = require("express");
const mysql = require("./dbcon.js");
const bodyParser = require("body-parser");

const app = express();
const handlebars = require("express-handlebars").create({
  defaultLayout: "main",
});

const port = process.argv[2];
if (!port) {
  console.log("[ ERR ] Fatal: No port given!");
  exit(1);
}

app.engine("handlebars", handlebars.engine);
app.use(bodyParser.urlencoded({ extended: true }));
app.set("view engine", "handlebars");
app.set("port", port); // gets port number from command line input
app.set("mysql", mysql);

app.all("*", function (req, res, next) {
  console.log(`[ REQ ] ${req.method} ${req.url}`);
  next();
});

app.use("/static", express.static("public"));
app.use("/employee", require("./employee.js")); // links employee functions
app.use("/", express.static("public")); // sets file pointer to public for .css to be linked in main.handlebars

app.use((req, res) => {
  res.status(404);
  res.render("404");
});

app.use((err, req, res, next) => {
  console.error("[ ERR ] " + err.stack);
  res.status(500);
  res.render("500");
});

app.listen(app.get("port"), () => {
  console.log("[ INFO ] Started on port " + app.get("port"));
});
