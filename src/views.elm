module Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Models exposing (..)


view : Model -> Html Msg
view model =
    section []
        [ div [ class "container" ]
            [ navBar
            , viewPage model.newRoute model
            ]
        ]


viewPage : Route -> Model -> Html Msg
viewPage route model =
    case route of
        Home ->
            div []
                [ text "These are your recipes"
                , input [ type_ "checkbox", onClick ToggleFavorite ] []
                ]

        New ->
            newRecipeFormContainer model

        Login ->
            div []
                [ text "login here"
                , button
                    [ onClick Send
                    , class "btn btn-primary"
                    ]
                    [ text "send" ]
                ]

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


newRecipeFormContainer : Model -> Html Msg
newRecipeFormContainer model =
    div [ class "container" ]
        [ div [ class "row" ]
            [ div [ class "col-7" ]
                [ newRecipeForm model ]
            , div
                [ class "col-5" ]
                [ recipeDisplay model ]
            ]
        ]


newRecipeForm : Model -> Html Msg
newRecipeForm model =
    Html.form []
        [ div [ class "form-group" ]
            [ label [ for "recipe-title" ] [ text "Title" ]
            , input
                [ name "recipe-title"
                , class "form-control"
                , type_ "text"
                , value model.newTitle
                , placeholder "Title"
                , onInput UpdateTitle
                , placeholder "Title"
                ]
                []
            ]
        , div [ class "form-group" ]
            [ label [ for "ingredients" ] [ text "Ingredients" ]
            , div [ class "input-group" ]
                [ input
                    [ name "ingredients"
                    , class "form-control"
                    , type_ "text"
                    , value model.newIngredient
                    , placeholder "Enter an ingredient"
                    , onInput UpdateIngredients
                    ]
                    []
                , span [ class "input-group-btn" ]
                    [ button
                        [ class "btn btn-secondary"
                        , type_ "button"
                        , onClick AddIngredient
                        ]
                        [ text "Add" ]
                    ]
                ]
            ]
        , div [ class "form-group" ]
            [ label [ for "instructions" ] [ text "Instructions" ]
            , div [ class "input-group" ]
                [ input
                    [ name "instructions"
                    , class "form-control"
                    , type_ "text"
                    , placeholder "Enter an instruction"
                    , value model.newInstruction
                    , onInput UpdateInstructions
                    ]
                    []
                , span [ class "input-group-btn" ]
                    [ button
                        [ class "btn btn-secondary"
                        , type_ "button"
                        , onClick AddInstruction
                        ]
                        [ text "Add" ]
                    ]
                ]
            ]
        , button
            [ class "btn btn-primary btn-block"
            , type_ "button"
            , onClick SaveRecipe
            ]
            [ text "Save" ]
        ]


recipeDisplay : Model -> Html Msg
recipeDisplay model =
    div []
        [ h4 [] [ text model.newTitle ]
        , dl []
            [ dt [] [ text "Ingredients" ]
            , dd [] [ listDisplay model.newIngredients ]
            , dt [] [ text "Instructions" ]
            , dd [] [ listDisplay model.newInstructions ]
            ]
        ]


listDisplay : List String -> Html Msg
listDisplay list =
    list
        |> List.map (\item -> li [] [ text item ])
        |> ol []
