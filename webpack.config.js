var path              = require("path");
var htmlWebpackPlugin = require("html-webpack-plugin");

module.exports = {
	entry: path.join(__dirname, "src/index.js"),
	output: {
		path: path.join(__dirname, "dist"),
		filename: "main.js"
	},
	module: {
		loaders: [
			{
				test: /\.elm$/,
				exclude: [/node_modules/, /elm-stuff/],
				loader: "elm-webpack-loader?verbose=true&warn=true&debug=true",
			},
		]
	},
	plugins:[ new htmlWebpackPlugin({
		template: 'src/index.html',
		inject:   'body',
		filename: 'index.html'
   		})
	]
};
