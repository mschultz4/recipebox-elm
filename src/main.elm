module Main exposing (..)

import Navigation
import Views exposing (..)
import Models exposing (..)
import Update exposing (..)


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    ( emptyModel (parseLocation location)
    , Cmd.none
    )
