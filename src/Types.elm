module Types exposing (..)

import Navigation exposing (Location)
import Http exposing (..)
import Dict


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
    = UpdateTitle String
    | UpdateIngredient
    | UpdateIngredients String
    | UpdateInstruction
    | UpdateInstructions String
    | UpdateNotes String
    | ToggleFavorite
    | OnLocationChange Navigation.Location
    | SaveRecipe
    | Send
    | PostResponse (Result Http.Error (Dict.Dict String String))
    | RecipePostResponse (Result Http.Error String)


type Route
    = Home
    | New
    | Import
    | Login
    | NotFound
