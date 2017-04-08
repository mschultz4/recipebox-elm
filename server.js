"use strict";

let express    = require('express');
let app        = express();
let pg         = require('pg');
let assert     = require('assert');
let bcrypt     = require('bcryptjs');
let bodyParser = require('body-parser');
let path       = require('path');

const saltRounds = 10;
const port       = 8080;
const connectionString = process.env.DATABASE_URL || 'postgres://localhost:5432/recipebox';

//app.use(express.static('./dist'));
app.use(bodyParser.json());
// app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, "dist")));

app.get('/', function (req, res) {
  res.render('./dist/index.html');
});

app.get('/api', function (req, res) {
  return res.json({
    data: 'hello there'
  });
});

app.post('/api/saverecipe', function (req, res) {
  pg.connect(connectionString, (err, client, done) => {

      // Handle connection errors
      if (err) {
        done();
        console.log(err);
        return res.status(500).json({success: false, data: err});
      }

      // SQL Query > Update Data
      client.query(
        `INSERT INTO recipes ( title, favorite, notes) 
         VALUES (($1), ($2),($3));`
         , [req.body.title, req.body.favorite, req.body.notes])
        .then( () => client.end());
      
      // SQL Query > Select Data
      // const query = client.query("SELECT * FROM items ORDER BY id ASC");

      // Stream results back one row at a time
      // query.on('row', (row) => {
      //   results.push(row);
      // });
  });
  console.log(req.body);
  return res.json("saved");
});

app.post("/test", function (req, res){
  console.log(req);
  return res.json({
    data: 'hello there'
  });
})

app.post('/api/signup', function (req, res) {
    userCollection
      .findOne({"email": req.body.email})
      .then(function(user){
        if (user){
            return res.json({"message": "user already exists"});
        }

      bcrypt.genSalt(saltRounds, function(err, salt) {
        assert.equal(null, err);
        bcrypt.hash(req.body.password, salt, function(err, hash) {
          assert.equal(null, err);
          var user = {
            email: req.body.email,
            password: hash
          };

          userCollection.insertOne({email: req.body.email, password: hash});

          return res.json({
            message: "user created",
            authenticated: true,
            data: user
          });
        });
      });
    });
});

app.post('/api/signin', function(req, res){
  userCollection.findOne({email: req.body.email}).then(function(user){
    if (!user) {
      return res.json({
        message: "user not found",
        authenticated: false
      });
    }

    bcrypt.compare(req.body.password, user.password, function(err, authenticated){
        assert.equal(err, null);
        return res.json({authenticated: authenticated});
    });
  });

});

app.get('/api/recipes/:creator_id', function(req, res){
    recipeCollection
      .find({}, {creator_id: req.params.creator_id}, function(err, recipes){
        assert.equal(err, null);
        res.json(recipes.toArray());
      });
});

app.post('/api/recipes', function(req, res){
    recipeCollection
      .insertOne({
        creator_id: req.body.creator_id,
        recipe : req.body.recipe
      })
      .then(function(document){
        res.json({
          "message": "recipe created",
          "document": document
        });
      });
});

app.listen(port, function () {
  console.log('Example app listening on port ' + port + '!');
});


// user and persist their recipie
// now localstorage:
