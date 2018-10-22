module Model exposing (BlogPost, Model, Msg(..))

import Browser
import Browser.Navigation as Nav
import Dict
import Html exposing (Html)
import Route exposing (Route(..))
import Url


type alias Model =
    { title : String
    , about : String
    , picture : String
    , posts : Dict.Dict String BlogPost
    , route : Route
    , key : Nav.Key
    , url : Url.Url
    }


type alias BlogPost =
    { title : String
    , description : String
    , content : String
    }


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url
