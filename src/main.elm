module Main exposing (..)

import Navigation
import Views exposing (..)
import Models exposing (..)
import Update exposing (..)


main : Program Never Recipe Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : Navigation.Location -> ( Recipe, Cmd Msg )
init location =
    ( newRecipe (parseLocation location)
    , Cmd.none
    )
