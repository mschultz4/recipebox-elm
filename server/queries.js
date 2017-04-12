const buildValues = (id, values) => {
    return values 
        .map(val => "(" + id + ", '" + val + "', " + 44 + ")")
        .join(", ");
    };

module.exports = { 
    buildValues: buildValues
};