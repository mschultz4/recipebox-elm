var path = require("path");

module.exports = {
	entry: "./src/app.elm",
	output: {
		path: path.join(__dirname, "dist"),
		filename: "bundle.js"
	},
	externals: {
		lodash: "_"
	},
	module: {
		loaders: [{
				test: /\.js$/,
				exclude: [/node_modules/, /elm-stuff/],
				loader: "babel",
				query: {
					presets: ['es2015']
				}
			},
			{
				test: /\.elm$/,
				exclude: [/node_modules/, /elm-stuff/],
				loader: "elm-webpack",
			}
		]
	}
};
