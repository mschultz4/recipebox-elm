// require( './styles/main.scss' );
// var $ = jQuery = require( '../../node_modules/jquery/dist/jquery.js' );           // <--- remove if jQuery not needed
// require( '../../node_modules/bootstrap-sass/assets/javascripts/bootstrap.js' );   // <--- remove if Bootstrap's JS not needed 
// require("bootstrap");
// inject bundled Elm app into div#main
var Elm = require( "./main.elm" );
Elm.Main.embed( document.getElementById( "main" ) );