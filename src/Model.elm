module Model exposing (BlogPost, Model, Msg(..), Route(..))

import Browser
import Browser.Navigation as Nav
import Html exposing (Html)
import Url


type alias Model =
    { title : String
    , about : String
    , picture : String
    , posts : List BlogPost

    -- , route : Route
    , key : Nav.Key
    , url : Url.Url
    }


type alias BlogPost =
    { name : String
    , title : String
    , description : String
    , content : String
    }


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


type Route
    = Home
    | About
    | Blog String
