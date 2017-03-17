var path              = require("path");
var htmlWebpackPlugin = require("html-webpack-plugin");

module.exports = {
	entry: "./src/app.elm",
	output: {
		path: path.join(__dirname, "dist"),
		filename: "index.js"
	},
	module: {
		loaders: [
			{
				test: /\.elm$/,
				exclude: [/node_modules/, /elm-stuff/],
				loader: "elm-webpack",
			}
		]
	},
	plugins:[new htmlWebpackPlugin({title: "Elm Recipe"})]
};
