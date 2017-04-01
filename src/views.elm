module Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Models exposing (..)


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