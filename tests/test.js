const pgp = require("pg-promise")();
let cn = {
    host: "localhost",
    port: 5432,
    database: 'recipebox',
    pools: 10,
    user: 'mschultz'
};
const db = pgp(cn);

db.tx(t => {
    return t.one("INSERT INTO recipes (title, notes, favorite) VALUES ('test', 'tester', false) RETURNING recipeid")
        .then(recipeid => {
            return t.batch([t.none("INSERT INTO ingredients (recipeid, ingredient, ordernumber) VALUES (${recipeid}, 'tester', 34)", recipeid)]);
        });
})
.then(events => {
    console.log(events);
})
.catch(error => {
    console.log(error);
    // error
});

pgp.end();