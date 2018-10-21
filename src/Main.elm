module Main exposing (main)

import About as About exposing (view)
import BlogPost exposing (..)
import Browser exposing (Document, application)
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (class, href, src, target)
import Html.Events exposing (onClick)
import List as List exposing (map)
import Markdown exposing (toHtml)
import Model exposing (..)
import Url
import Url.Parser exposing ((</>), Parser, int, map, oneOf, s, string)


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
      , posts = []

      -- , route = Home
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
                    let
                        _ =
                            Debug.log "asdf" url
                    in
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }, Cmd.none )



-- ShowHomePage ->
--     ( { model | route = HomePage }, Cmd.none )
--
-- ShowAboutPage ->
--     ( { model | route = AboutPage }, Cmd.none )
--
-- ShowBlogPost post ->
--     ( { model | route = Post post }, Cmd.none )


view : Model -> Document Msg
view model =
    { title = "Test"
    , body =
        [ section [ class "hero is-primary is-medium" ]
            [ div [ class "hero-head" ]
                [ nav [ class "navbar" ]
                    [ div [ class "container" ]
                        [ div [ class "navbar-brand" ]
                            [ a [ class "navbar-item", href "/home" ] [ text "matth" ]
                            ]
                        , div [ class "navbar-menu" ]
                            [ div [ class "navbar-end" ]
                                [ a [ class "navbar-item", href "/home" ] [ text "Home" ]
                                , a [ class "navbar-item", href "/about" ] [ text "About" ]
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
            [ h1 [ class "title blog-title", href "/home" ]
                [ text model.title ]
            , viewBody model
            ]
        ]


viewBody : Model -> Html Msg
viewBody model =
    let
        _ =
            Debug.log "key" model.key
    in
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
            , b [] [ text (Url.toString model.url) ]

            -- , div [ class "column is-three-quarters" ]
            --     [ routeTo model ]
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
    div [] (listBlogPosts model.posts)


listBlogPosts : List BlogPost -> List (Html Msg)
listBlogPosts blogPosts =
    List.map
        (\post ->
            a [ class "blog-post-item", href ("/posts/" ++ post.name) ]
                [ p [ class "title is-6" ] [ text post.title ]
                , p [ class "subtitle is-6" ] [ text post.description ]
                ]
        )
        getBlogPosts


viewBlogPost : BlogPost -> Html Msg
viewBlogPost post =
    div []
        [ h1 [ class "title" ] [ text post.title ]
        , div [ class "level" ] [ Markdown.toHtml [ class "content" ] post.content ]
        ]


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map Home (s "home")
        , map About (s "about")
        , map Blog (s "blog" </> string)
        ]



-- routeTo : Model -> Html Msg
-- routeTo model =
--     case model.route of
--         Post blogPost ->
--             viewBlogPost blogPost
--
--         AboutPage ->
--             About.view
--
--         _ ->
--             viewHome model
-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
