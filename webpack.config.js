var path              = require("path");
var htmlWebpackPlugin = require("html-webpack-plugin");

module.exports = {
	entry: [
		// "webpack-dev-server/client?" + require("os").hostname() + ":8080",
		 path.resolve(__dirname, 
		"src/index.js")],

	devServer: {
		// serve index.html in place of 404 responses
		historyApiFallback: true,
		contentBase: path.resolve(__dirname, "src")
	},

	output: {
		path: path.join(__dirname, "dist"),
		filename: "main.js"
	},

	module: {
		loaders: [
			{
				test: /\.elm$/,
				exclude: [/node_modules/, /elm-stuff/],
				loader: "elm-hot-loader!elm-webpack-loader?verbose=true&warn=true&debug=true",
			},
		],

		noParse: /\.elm$/
	},

	plugins:[ 
		new htmlWebpackPlugin({
			template: path.resolve(__dirname, "src/index.html"),
			inject:   'body',
			filename: 'index.html'
   		})
	]
};
