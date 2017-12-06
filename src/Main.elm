module Main exposing (main)

import Html exposing (..)
import Html.Events exposing (onClick)


main =
    Html.beginnerProgram
        { model = home
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { title : String
    , content : String
    }


model =
    Nothing



-- UPDATE


home =
    { title = "Matt King's blog of software shenanigans"
    , content = "What I learned in software school is..."
    }


whatIMadeWithElmPost =
    { title = "What I made with Elm"
    , content = "Here's the blog I made in Elm:..."
    }


type Msg
    = ShowHomePage
    | ShowWhatIMadeWithElmPost


update msg model =
    case msg of
        ShowHomePage ->
            home

        ShowWhatIMadeWithElmPost ->
            whatIMadeWithElmPost



-- VIEW


view model =
    body []
        [ h1 [] [ text model.title ]
        , text model.content
        , div []
            [ button [ onClick ShowHomePage ] [ text "Home" ]
            , button [ onClick ShowWhatIMadeWithElmPost ] [ text "What I made with Elm" ]
            ]
        ]
