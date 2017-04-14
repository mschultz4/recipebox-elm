module Types exposing (..)

import Navigation exposing (Location)
import Http exposing (..)


-- MODEL


type alias Model =
    { uid : Int
    , newRoute : Route
    , recipes : List Recipe
    , newIngredient : Ingredient
    , newInstruction : Instruction
    , newTitle : String
    , newIngredients : List Ingredient
    , newInstructions : List Instruction
    , newNotes : String
    , newFavorite : Bool
    }


type alias Recipe =
    { title : String
    , ingredients : List Ingredient
    , instructions : List Instruction
    , notes : String
    , favorite : Bool
    }


type alias Recipes =
    { recipes : List Recipe
    }


type alias Ingredient =
    { ingredient : String
    , sequence : Int
    }


type alias Instruction =
    { instruction : String
    , sequence : Int
    }


emptyModel : Route -> Model
emptyModel route =
    { newRoute = route
    , uid = 0
    , recipes = []
    , newIngredient = { ingredient = "", sequence = 0 }
    , newInstruction = { instruction = "", sequence = 0 }
    , newTitle = ""
    , newIngredients = []
    , newInstructions = []
    , newNotes = ""
    , newFavorite = False
    }


type Msg
    = UpdateTitle String
    | AddIngredient
    | UpdateNewIngredient String
    | AddInstruction
    | UpdateNewInstruction String
    | UpdateNotes String
    | ToggleFavorite
    | OnLocationChange Navigation.Location
    | SaveRecipe
    | GetRecipes
    | GetRecipeResponse (Result Http.Error Recipes)
    | PostRecipeResponse (Result Http.Error String)


type Route
    = Home
    | New
    | Import
    | Login
    | NotFound
