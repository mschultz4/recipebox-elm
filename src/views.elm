module Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Models exposing (..)


view : Recipe -> Html Msg
view recipe =
    section []
        [ div [ class "container" ]
            [ navBar
            , div [] [ text (recipe.name ++ " " ++ toString recipe.newRoute) ]
            , viewPage recipe.newRoute
            ]
        ]


viewPage : Route -> Html Msg
viewPage route =
    case route of
        Home ->
            div [] [ text "These are your recipes" ]

        New ->
            div []
                [ input [ type_ "text", placeholder "Name", onInput UpdateName ] []
                , input [ type_ "text", placeholder "Ingredients", onInput UpdateIngredients ] []
                , input [ type_ "checkbox", onClick ToggleFavorite ] []
                ]

        Login ->
            div [] [ text "login here" ]

        Import ->
            div [] [ text "import" ]

        NotFound ->
            div [] [ text "not found" ]


navBar : Html Msg
navBar =
    nav [ class "navbar navbar-toggleable-md navbar-light bg-faded" ]
        [ button
            [ type_ "button"
            , class "navbar-toggler navbar-toggler-right"
            , attribute "data-toggle" "collapse"
            , attribute "data-target" "#navbar-content"
            , attribute "aria-controls" "navbar-content"
            , attribute "aria-expanded" "false"
            , attribute "aria-label" "Toggle navigation"
            ]
            [ span [ class "navbar-toggler-icon" ] []
            ]
        , a [ class "navbar-brand", href "#" ] [ text "Brands" ]
        , div [ class "collapse navbar-collapse", id "navbar-content" ]
            [ ul [ class "navbar-nav mr-auto" ]
                [ li [ class "nav-item active" ]
                    [ a [ href "#", class "nav-link" ]
                        [ text "Home  "
                        , span [ class "sr-only" ] [ text "(current)" ]
                        ]
                    ]
                , li [ class "nav-item" ] [ a [ href "#/New", class "nav-link" ] [ text "New  " ] ]
                , li [ class "nav-item" ] [ a [ href "#/Login", class "nav-link" ] [ text "Login" ] ]
                ]
            , Html.form [ class "form-inline my-2 my-lg-0" ]
                [ input [ type_ "text", class "form-control mr-sm-2", placeholder "Search" ] []
                , button [ type_ "submit", class "btn btn-outline-success my-2 my-sm-0" ] [ text "Search" ]
                ]
            ]
        ]
