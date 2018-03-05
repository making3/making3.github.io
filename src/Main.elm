module Main exposing (main)

import Html exposing (..)
import Html.Attributes exposing (class, src, href, target)
import Html.Events exposing (onClick)
import List as List exposing (map)
import Markdown exposing (toHtml)
import Model exposing (..)
import BlogPost exposing (..)
import About as About exposing (view)


main =
    Html.beginnerProgram
        { model = model
        , update = update
        , view = view
        }



-- MODEL


model =
    { title = "Matt King's Software Blog"
    , about = "Full stack software developer"
    , picture = "https://secure.gravatar.com/avatar/1e84d7b396211e9c7bbd888dc51249a4?s=188"
    , posts = []
    , route = HomePage
    }



-- UPDATE


update : Msg -> Model -> Model
update msg model =
    case msg of
        ShowHomePage ->
            { model | route = HomePage }

        ShowAboutPage ->
            { model | route = AboutPage }

        ShowBlogPost post ->
            { model | route = Post post }


view : Model -> Html Msg
view model =
    body []
        [ section [ class "hero is-primary is-medium" ]
            [ div [ class "hero-head" ]
                [ nav [ class "navbar" ]
                    [ div [ class "container" ]
                        [ div [ class "navbar-brand" ]
                            [ a [ class "navbar-item", onClick ShowHomePage ] [ text "matth" ]
                            ]
                        , div [ class "navbar-menu" ]
                            [ div [ class "navbar-end" ]
                                [ a [ class "navbar-item", onClick ShowHomePage ] [ text "Home" ]
                                , a [ class "navbar-item", onClick ShowAboutPage ] [ text "About" ]
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        , viewContent model
        ]


viewContent : Model -> Html Msg
viewContent model =
    body []
        [ div [ class "container" ]
            [ h1 [ class "title blog-title", onClick ShowHomePage ]
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
                , (viewMediaLinks model)
                ]
            , div [ class "column is-three-quarters" ]
                [ route model.route ]
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
        ]


viewHome : Model -> Html Msg
viewHome model =
    div [] (listBlogPosts model.posts)


listBlogPosts : List BlogPost -> List (Html Msg)
listBlogPosts blogPosts =
    List.map
        (\l ->
            a [ class "blog-post-item", onClick (ShowBlogPost l) ]
                [ p [ class "title is-6" ] [ text l.title ]
                , p [ class "subtitle is-6" ] [ text l.description ]
                ]
        )
        getBlogPosts


viewBlogPost : BlogPost -> Html Msg
viewBlogPost post =
    div []
        [ h1 [ class "title" ] [ text post.title ]
        , div [ class "level" ] [ Markdown.toHtml [ class "content" ] post.content ]
        ]


route : Route -> Html Msg
route route =
    case route of
        Post blogPost ->
            viewBlogPost blogPost

        AboutPage ->
            About.view

        _ ->
            viewHome model
