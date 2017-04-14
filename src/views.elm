module Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Types exposing (..)


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
                , displayRecipes model.recipes
                ]

        New ->
            newRecipeFormContainer model

        Login ->
            div []
                [ text "login here"
                , button
                    [ onClick GetRecipes
                    , class "btn btn-primary"
                    ]
                    [ text "Get Recipes" ]
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
                , placeholder "Enter the Title"
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
                    , value model.newIngredient.ingredient
                    , placeholder "Enter an ingredient"
                    , onInput UpdateNewIngredient
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
                    , value model.newInstruction.instruction
                    , onInput UpdateNewInstruction
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
        , div [ class "form-group" ]
            [ label [ for "favorite" ] [ text "Favorite" ]
            , input
                [ name "favorite"
                , class "form-control"
                , checked model.newFavorite
                , type_ "checkbox"
                , onClick ToggleFavorite
                ]
                []
            ]
        , div [ class "form-group" ]
            [ label [ for "notes" ] [ text "Notes" ]
            , textarea
                [ name "favorite"
                , class "form-control"
                , value model.newNotes
                , onInput UpdateNotes
                ]
                []
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
            , dd [] [ displayIngredients model.newIngredients ]
            , dt [] [ text "Instructions" ]
            , dd [] [ displayInstructions model.newInstructions ]
            , dt [] [ text "Favorite" ]
            , dd [] [ text (toString model.newFavorite) ]
            , dt [] [ text "Notes" ]
            , dd [] [ text model.newNotes ]
            ]
        ]


displayIngredients : List Ingredient -> Html Msg
displayIngredients list =
    list
        |> List.map (\item -> li [] [ text item.ingredient ])
        |> ol []


displayInstructions : List Instruction -> Html Msg
displayInstructions list =
    list
        |> List.map (\item -> li [] [ text item.instruction ])
        |> ol []


displayRecipe : Recipe -> Html Msg
displayRecipe recipe =
    ul []
        [ li [] [ text recipe.title ]
        , li [] [ text recipe.notes ]
        , li [] [ displayInstructions recipe.instructions ]
        , li [] [ displayIngredients recipe.ingredients ]
        ]


displayRecipes : List Recipe -> Html Msg
displayRecipes recipes =
    recipes
        |> List.map (\item -> li [] [ displayRecipe item ])
        |> ol []
