module Commands exposing (..)

import Types exposing (..)
import Http exposing (..)
import Json.Decode as Decode exposing (..)
import Json.Encode as Encode exposing (..)


getRecipes : Cmd Msg
getRecipes =
    Http.send GetRecipeResponse (Http.get "/api/recipes" recipesDecoder)


postRecipe : Recipe -> Cmd Msg
postRecipe recipe =
    Http.send PostRecipeResponse (Http.post "/api/saverecipe" (Http.jsonBody (recipeEncoder recipe)) Decode.string)


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
            , ( "ingredients", Encode.list (List.map ingredientEncoder recipe.ingredients) )
            , ( "instructions", Encode.list (List.map instructionEncoder recipe.instructions) )
            , ( "notes", Encode.string recipe.notes )
            ]
    in
        Encode.object attributes


ingredientEncoder : Ingredient -> Encode.Value
ingredientEncoder ingredient =
    let
        attributes =
            [ ( "ingredient", Encode.string ingredient.ingredient )
            , ( "sequence", Encode.int ingredient.sequence )
            ]
    in
        Encode.object attributes


instructionEncoder : Instruction -> Encode.Value
instructionEncoder instruction =
    let
        attributes =
            [ ( "instruction", Encode.string instruction.instruction )
            , ( "sequence", Encode.int instruction.sequence )
            ]
    in
        Encode.object attributes


recipesDecoder : Decoder Recipes
recipesDecoder =
    map Recipes
        (field "recipes" (Decode.list recipeDecoder))


recipeDecoder : Decoder Recipe
recipeDecoder =
    map5 Recipe
        (field "title" Decode.string)
        (field "ingredients" (Decode.list ingredientDecoder))
        (field "instructions" (Decode.list instructionDecoder))
        (field "notes" Decode.string)
        (field "favorite" Decode.bool)


ingredientDecoder : Decoder Ingredient
ingredientDecoder =
    map2 Ingredient
        (field "ingredient" Decode.string)
        (field "sequence" Decode.int)


instructionDecoder : Decoder Instruction
instructionDecoder =
    map2 Instruction
        (field "instruction" Decode.string)
        (field "sequence" Decode.int)



-- recipeDecoder : Value -> List Recipe
