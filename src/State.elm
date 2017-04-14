module State exposing (..)

import Types exposing (..)
import Debug exposing (log)
import Router exposing (..)
import Commands exposing (getRecipes, httpErrorString)


-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateTitle str ->
            ( { model | newTitle = str }, Cmd.none )

        UpdateNotes str ->
            ( { model | newNotes = str }, Cmd.none )

        UpdateNewIngredient str ->
            let
                ing =
                    model.newIngredient
            in
                ( { model | newIngredient = { ing | ingredient = str } }, Cmd.none )

        UpdateNewInstruction str ->
            let
                ins =
                    model.newInstruction
            in
                ( { model | newInstruction = { ins | instruction = str } }, Cmd.none )

        ToggleFavorite ->
            ( { model
                | newFavorite =
                    if model.newFavorite then
                        False
                    else
                        True
              }
            , Cmd.none
            )

        AddIngredient ->
            ( { model
                | newIngredients =
                    List.append model.newIngredients [ model.newIngredient ]
                , newIngredient = { ingredient = "", sequence = 0 }
              }
            , Cmd.none
            )

        AddInstruction ->
            ( { model
                | newInstructions =
                    List.append model.newInstructions [ model.newInstruction ]
                , newInstruction = { instruction = "", sequence = 0 }
              }
            , Cmd.none
            )

        OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | newRoute = newRoute }, Cmd.none )

        SaveRecipe ->
            let
                oldModel =
                    model
            in
                ( { model
                    | recipes = List.append model.recipes [ createNewRecipe oldModel ]
                    , newIngredient = { ingredient = "", sequence = 0 }
                    , newInstruction = { instruction = "", sequence = 0 }
                    , newTitle = ""
                    , newIngredients = []
                    , newInstructions = []
                    , newNotes = ""
                    , newFavorite = False
                  }
                , Commands.postRecipe (createNewRecipe oldModel)
                )

        GetRecipes ->
            ( model, getRecipes )

        GetRecipeResponse (Ok recipesList) ->
            ( { model | recipes = recipesList.recipes }
            , Cmd.none
            )

        GetRecipeResponse (Err error) ->
            ( model |> log (httpErrorString error)
            , Cmd.none
            )

        PostRecipeResponse (Ok string) ->
            ( model |> log (string)
            , Cmd.none
            )

        PostRecipeResponse (Err error) ->
            ( model |> log (httpErrorString error)
            , Cmd.none
            )


createNewRecipe : Model -> Recipe
createNewRecipe model =
    { title = model.newTitle
    , ingredients = model.newIngredients
    , instructions = model.newInstructions
    , notes = model.newNotes
    , favorite = model.newFavorite
    }



-- AddIngredient : Ingredient -> Ingredient -> Ingredient
-- AddIngredient ing =
--     { ingredient | ingredient = ing.ingredient, sequence = ing.sequence }
-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions recipe =
    Sub.none
