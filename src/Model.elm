module Model exposing (..)

import Html exposing (Html)


type alias Model =
    { title : String
    , about : String
    , picture : String
    , posts : List BlogPost
    , route : Route
    }


type alias BlogPost =
    { title : String
    , description : String
    , content : String
    }


type Msg
    = ShowHomePage
    | ShowAboutPage
    | ShowBlogPost BlogPost


type Route
    = HomePage
    | AboutPage
    | Post BlogPost
