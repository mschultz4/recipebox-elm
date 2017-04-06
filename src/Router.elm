module Router exposing (parseLocation, route)

import Types exposing (..)
import UrlParser exposing (..)
import Navigation exposing (Location)


route : UrlParser.Parser (Route -> a) a
route =
    UrlParser.oneOf
        [ UrlParser.map Home top
        , UrlParser.map New (UrlParser.s "New")
        , UrlParser.map Import (UrlParser.s "Import")
        , UrlParser.map Login (UrlParser.s "Login")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (UrlParser.parseHash route location) of
        Just route ->
            route

        Nothing ->
            NotFound
