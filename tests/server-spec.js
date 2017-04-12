let test    = require("tape");
let queries = require("../server/queries.js");

test("builds string", (t) => {
    let arr = [1,2,3];
    let id  = "the id'";

    t.equals(queries.buildValues(id, arr, 44), "(the id, 1, 44), (the id, 2, 44), (the id, 3, 44)");
    t.end();
});
