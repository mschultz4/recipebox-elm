module Update exposing (..)

import Models exposing (..)
import Http exposing (..)
import Json.Decode as Decode
import Debug exposing (log)
import Dict


-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateTitle str ->
            ( { model | newTitle = str }, Cmd.none )

        UpdateIngredients str ->
            ( { model | newIngredient = str }, Cmd.none )

        UpdateInstructions str ->
            ( { model | newInstruction = str }, Cmd.none )

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
                , newIngredient = ""
              }
            , Cmd.none
            )

        AddInstruction ->
            ( { model
                | newInstructions =
                    List.append model.newInstructions [ model.newInstruction ]
                , newInstruction = ""
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
                    , newIngredient = ""
                    , newInstruction = ""
                    , newTitle = ""
                    , newIngredients = [ "" ]
                    , newInstructions = [ "" ]
                    , newNotes = ""
                    , newFavorite = False
                  }
                , Cmd.none
                )

        Send ->
            ( model, getStuff )

        PostResponse (Ok dict) ->
            ( model |> log (toString dict)
            , Cmd.none
            )

        PostResponse (Err error) ->
            ( model |> log (httpErrorString error)
            , Cmd.none
            )



-- getStuff : Http.Request (Dict.Dict String a)


getStuff =
    Http.send PostResponse (Http.get "http://localhost:8080/api" (Decode.dict Decode.string))


createNewRecipe : Model -> Recipe
createNewRecipe model =
    { title = model.newTitle
    , ingredients = model.newIngredients
    , instructions = model.newInstructions
    , notes = model.newNotes
    , favorite = model.newFavorite
    }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions recipe =
    Sub.none


httpErrorString : Http.Error -> String
httpErrorString error =
    case error of
        BadUrl text ->
            "Bad Url: " ++ text

        Timeout ->
            "Http Timeout"

        NetworkError ->
            "Network Error"

        BadStatus response ->
            "Bad Http Status: " ++ toString response.status.code

        BadPayload message response ->
            "Bad Http Payload: "
                ++ toString message
                ++ " ("
                ++ toString response.status.code
                ++ ")"
