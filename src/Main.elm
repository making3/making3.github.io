module Main exposing (main)

import Html exposing (..)


main =
    viewBlogPost


viewBlogPost =
    body []
        [ h1 [] [ text "Making3's blog of randomness" ]
        , text "Here's what I learned while exploring Elm..."
        ]
