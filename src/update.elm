module Update exposing (..)

import Navigation
import Models exposing (..)

-- UPDATE



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


-- SUBSCRIPTIONS


subscriptions : Recipe -> Sub Msg
subscriptions model =
    Sub.none