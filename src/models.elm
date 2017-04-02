module Models exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)


-- MODEL


type alias Model =
    { uid : Int
    , newRoute : Route
    , recipes : List Recipe
    , newIngredient : String
    , newInstruction : String
    , newTitle : String
    , newIngredients : List String
    , newInstructions : List String
    , newNotes : String
    , newFavorite : Bool
    }


type alias Recipe =
    { title : String
    , ingredients : List String
    , instructions : List String
    , notes : String
    , favorite : Bool
    }


emptyModel : Route -> Model
emptyModel route =
    { newRoute = route
    , uid = 0
    , recipes = []
    , newIngredient = ""
    , newInstruction = ""
    , newTitle = ""
    , newIngredients = []
    , newInstructions = []
    , newNotes = ""
    , newFavorite = False
    }


type Msg
    = AddIngredient
    | AddInstruction
    | ToggleFavorite
    | UpdateTitle String
    | UpdateIngredients String
    | UpdateInstructions String
    | OnLocationChange Navigation.Location
    | SaveRecipe



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
