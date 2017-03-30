module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
    Html.beginnerProgram { model = newRecipe, view = view, update = update }



-- MODEL


type alias Recipes =
    { recipes : List Recipe
    , visibility : String
    , uid : Int
    }


type alias Recipe =
    { name : String
    , ingredients : List String
    , instructions : List String
    , notes : String
    , favorite : Bool
    , rid : Int
    }

emptyRecipes : Recipes
emptyRecipes = 
    { recipes = []
    , visibility = "ALL"
    , uid  = 0
    }


newRecipe : Recipe
newRecipe = 
    { name = ""
    , ingredients = []
    , instructions = []
    , notes = ""
    , favorite = False
    , rid = 0
    }



-- UPDATE


type Msg
    = Add String
    | ToggleFavorite


update : Msg -> Recipe -> Recipe
update msg model=
    case msg of
        Add name ->
            { model | name = name }

        ToggleFavorite ->
            { model 
                | favorite = 
                    if model.favorite then
                        False
                    else 
                        True
            }



-- VIEW


view : Recipe -> Html Msg
view model =
    section []
        [ h5 [] [ text "Recipe List" ]
        , input [ type_ "text", placeholder "Name", onInput Add ] []
        , div [] [text (toString model.name)]
        ]
