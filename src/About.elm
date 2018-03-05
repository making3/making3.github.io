module About exposing (..)

import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Model exposing (Msg)
import Markdown exposing (toHtml)


view : Html Msg
view =
    div [ class "level" ]
        [ Markdown.toHtml [ class "content" ] getAbout
        ]


getAbout : String
getAbout =
    """
About Me!
"""
