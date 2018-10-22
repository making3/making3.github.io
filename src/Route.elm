module Route exposing (Route(..), fromUrl, href)

import Html exposing (Attribute)
import Html.Attributes as Attr
import Url exposing (Url)
import Url.Parser exposing ((</>), Parser, int, map, oneOf, parse, s, string, top)


type Route
    = Home
    | About
    | Blog String
    | NotFound



-- PUBLIC


href : Route -> Attribute msg
href targetRoute =
    Attr.href (routeToString targetRoute)


fromUrl : Url -> Route
fromUrl url =
    -- The RealWorld spec treats the fragment like a path.
    -- This makes it *literally* the path, so we can proceed
    -- with parsing as if it had been a normal path all along.
    let
        maybeRoute =
            { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
                |> parse parser
    in
    case maybeRoute of
        Nothing ->
            NotFound

        Just route ->
            route



-- INTERNAL


routeToString : Route -> String
routeToString page =
    let
        pieces =
            case page of
                Home ->
                    []

                About ->
                    [ "about" ]

                Blog post ->
                    [ "posts", post ]

                NotFound ->
                    [ "not-found" ]
    in
    "#/" ++ String.join "/" pieces


parser : Parser (Route -> a) a
parser =
    oneOf
        [ map Home top
        , map About (s "about")
        , map Blog (s "posts" </> string)
        ]
