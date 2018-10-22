module Main exposing (main)

import About as About exposing (view)
import BlogPost exposing (..)
import Browser exposing (Document, application)
import Browser.Navigation as Nav
import Dict
import Html exposing (..)
import Html.Attributes exposing (class, href, src, target)
import Html.Events exposing (onClick)
import List as List exposing (map)
import Markdown exposing (toHtml)
import Model exposing (..)
import Route exposing (Route(..), fromUrl)
import Url
import Url.Parser exposing ((</>), Parser, int, map, oneOf, parse, s, string, top)


main =
    Browser.application
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- MODEL


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { title = "Matth's Software Blog"
      , about = "Full stack software developer"
      , picture = "https://secure.gravatar.com/avatar/1e84d7b396211e9c7bbd888dc51249a4?s=188"
      , posts = blogPosts
      , route = url |> fromUrl
      , url = url
      , key = key
      }
    , Cmd.none
    )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url, route = url |> fromUrl }, Cmd.none )


view : Model -> Document Msg
view model =
    { title = "Matth's Blog"
    , body =
        [ section [ class "hero is-primary is-medium" ]
            [ div [ class "hero-head" ]
                [ nav [ class "navbar" ]
                    [ div [ class "container" ]
                        [ div [ class "navbar-brand" ]
                            [ a [ class "navbar-item", Route.href Home ] [ text "matth" ]
                            ]
                        , div [ class "navbar-menu" ]
                            [ div [ class "navbar-end" ]
                                [ a [ class "navbar-item", Route.href Home ] [ text "Home" ]
                                , a [ class "navbar-item", Route.href About ] [ text "About" ]
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        , viewContent model
        ]
    }


viewContent : Model -> Html Msg
viewContent model =
    div []
        [ div [ class "container" ]
            [ h1 [ class "title blog-title", Route.href Home ]
                [ text model.title ]
            , viewBody model
            ]
        ]


viewBody : Model -> Html Msg
viewBody model =
    div [ class "container" ]
        [ div [ class "columns" ]
            [ div
                [ class "column is-one-quarter" ]
                [ div [ class "level" ]
                    [ img [ class "sidebar-picture", src model.picture ] [] ]
                , div [ class "level sidebar-name" ] [ text "Matthew King" ]
                , div [ class "level content is-small sidebar-about" ] [ text model.about ]
                , viewMediaLinks model
                ]
            , div [ class "column is-three-quarters" ]
                [ routeTo model ]
            ]
        ]


viewMediaLinks : Model -> Html Msg
viewMediaLinks model =
    div [ class "level-left" ]
        [ a [ target "_blank", href "https://github.com/making3" ]
            [ img [ class "media-icon", src "images/github.png" ] []
            ]
        , a [ target "_blank", href "https://twitter.com/making_3" ]
            [ img [ class "media-icon", src "images/twitter.png" ] []
            ]
        , a [ target "_blank", href "https://www.linkedin.com/in/matthew-king-2b884766" ]
            [ img [ class "media-icon", src "images/linkedin.png" ] []
            ]
        ]


viewHome : Model -> Html Msg
viewHome model =
    div [] (viewBlogPosts model.posts)


viewBlogPosts : Dict.Dict String BlogPost -> List (Html Msg)
viewBlogPosts blogPosts =
    blogPosts
        |> Dict.map
            (\name post ->
                a [ class "blog-post-item", Route.href (Blog name) ]
                    [ p [ class "title is-6" ] [ text post.title ]
                    , p [ class "subtitle is-6" ] [ text post.description ]
                    ]
            )
        |> Dict.values


viewBlogPost : String -> Html Msg
viewBlogPost stringPost =
    let
        post =
            toBlogPost stringPost
    in
    div []
        [ h1 [ class "title" ] [ text post.title ]
        , div [ class "level" ] [ Markdown.toHtml [ class "content" ] post.content ]
        ]


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map Home top
        , map About (s "about")
        , map Blog (s "posts" </> string)
        ]


routeTo : Model -> Html Msg
routeTo model =
    case model.route of
        Blog blogPost ->
            viewBlogPost blogPost

        About ->
            About.view

        _ ->
            viewHome model



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
