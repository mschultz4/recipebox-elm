var path = require("path");

module.exports = {
    entry: "./src/app.js",
    output: {
        path: path.join(__dirname, "dist"),
        filename: "bundle.js"
    },
    externals: {
        lodash: "_"
    } ,
    module: {
        loaders: [{
            test: /\.js$/,
            exclude: /node_modules/,
            loader: "babel"],
            query: {
        presets: ['es2015']
      }

        }]
    }
};
