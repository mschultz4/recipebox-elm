module Main exposing (..)

import Navigation
import Views exposing (..)
import Types exposing (..)
import State exposing (..)
import Router exposing (parseLocation)


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
