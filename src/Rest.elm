module Rest exposing (..)

import Types exposing (..)
import Http exposing (..)
import Json.Decode as Decode
import Json.Encode as Encode exposing (..)


getStuff : Cmd Msg
getStuff =
    Http.send PostResponse (Http.get "http://localhost:8080/api" (Decode.dict Decode.string))


postRecipe : Recipe -> Cmd Msg
postRecipe recipe =
    Http.send RecipePostResponse (Http.post "/api/saverecipe" (Http.jsonBody (recipeEncoder recipe)) Decode.string)


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


recipeEncoder : Recipe -> Encode.Value
recipeEncoder recipe =
    let
        attributes =
            [ ( "title", Encode.string recipe.title )
            , ( "favorite", Encode.bool recipe.favorite )
            ]
    in
        Encode.object attributes
