module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Navigation exposing (Location)
import UrlParser exposing (..)

main =
    Navigation.program OnLocationChange 
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions 
        }



-- MODEL


init : Navigation.Location -> ( Recipe, Cmd Msg )
init location = 
    ( newRecipe (parseLocation location)
    , Cmd.none 
    )

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



-- UPDATE


type Msg
    = Add String
    | ToggleFavorite 
    | UpdateName String
    | UpdateIngredients String
    | OnLocationChange Navigation.Location


update : Msg -> Recipe -> (Recipe, Cmd Msg)
update msg model=
    case msg of

        UpdateName str ->
            ({ model | name = str }, Cmd.none)

        UpdateIngredients str ->
            ({ model | ingredients = str }, Cmd.none)

        ToggleFavorite ->
            ({ model 
                | favorite = 
                    if model.favorite then
                        False
                    else 
                        True
            }, Cmd.none)
            
        Add str ->
            ({ model | ingredients = "salami" }, Cmd.none)
        
        OnLocationChange location ->
            let 
                newRoute = 
                    parseLocation location
            in 
                ({ model | newRoute = newRoute }, Cmd.none)


-- VIEW


view : Recipe -> Html Msg
view recipe =
    section []
        [ h5 [] [ text "Recipe List" ]
        , span [] [a [href "#"][text "Home  "]]
        , span [] [a [href "#/New"][text "New  "]]
        , span [] [a [href "#/Login"][text "Login"]]
        , div [] [text (recipe.name ++ " " ++ toString recipe.newRoute)]
        , viewPage recipe.newRoute
        ]


viewPage : Route -> Html Msg
viewPage route = 
    case route of 
        Home -> 
            div [][ text "These are your recipes" ]
        New -> 
            div []
                [ input [ type_ "text", placeholder "Name", onInput UpdateName ] []
                , input [ type_ "text", placeholder "Ingredients", onInput UpdateIngredients ] []
                , input [ type_ "checkbox", onClick ToggleFavorite ] []
                ]
        Login ->
            div [][ text "login here" ]
        Import -> 
            div [][ text "import"]
        NotFound ->
            div [][ text "not found"]

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

-- SUBSCRIPTIONS


subscriptions : Recipe -> Sub Msg
subscriptions model =
    Sub.none