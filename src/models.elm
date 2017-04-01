module Models exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)
-- MODEL

type alias Recipes =
    { recipes : List Recipe
    , visibility : String
    , uid : Int
    }


type alias Recipe =
    { name : String
    , ingredients : String
    , instructions : List String
    , notes : String
    , favorite : Bool
    , rid : Int
    , newRoute : Route
    }

emptyRecipes : Recipes
emptyRecipes = 
    { recipes = []
    , visibility = "ALL"
    , uid  = 0
    }


newRecipe : Route -> Recipe
newRecipe route = 
    { name = ""
    , ingredients = ""
    , instructions = []
    , notes = ""
    , favorite = False
    , rid = 0
    , newRoute = route
    }


type Msg
    = Add String
    | ToggleFavorite 
    | UpdateName String
    | UpdateIngredients String
    | OnLocationChange Navigation.Location



-- URL PARSING


type Route
  = Home
  | New
  | Import
  | Login
  | NotFound


route : UrlParser.Parser (Route -> a) a
route =
  UrlParser.oneOf
    [ UrlParser.map Home top
    , UrlParser.map New (UrlParser.s "New")
    , UrlParser.map Import (UrlParser.s "Import")
    , UrlParser.map Login (UrlParser.s "Login")
    ]
 
parseLocation : Location -> Route
parseLocation location =
    case (UrlParser.parseHash route location) of
        Just route ->
            route

        Nothing ->
            NotFound
