module Main exposing (main)

import Html exposing (Html, body, section, div, text, h1, p, img, label, a)
import Html.Attributes exposing (class, src, href, target)
import Html.Events exposing (onClick)
import List exposing (map)


main =
    Html.beginnerProgram
        { model = model
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { title : String
    , picture : String
    , posts : List BlogPost
    , route : Route
    }


type alias BlogPost =
    { title : String
    , description : String
    }


model =
    { title = "making3's Software Blog"
    , picture = "https://secure.gravatar.com/avatar/1e84d7b396211e9c7bbd888dc51249a4?s=188"
    , posts = []
    , route = HomePage
    }



-- UPDATE


type Msg
    = ShowHomePage
    | ShowBlogPost BlogPost


type Route
    = HomePage
    | Post BlogPost


update : Msg -> Model -> Model
update msg model =
    case msg of
        ShowHomePage ->
            { model | route = HomePage }

        ShowBlogPost post ->
            { model | route = Post post }


view : Model -> Html Msg
view model =
    body []
        [ div [ class "section" ]
            [ div [ class "container" ]
                [ h1 [ class "title blog-title", onClick ShowHomePage ]
                    [ text model.title ]
                , div [ class "columns" ]
                    [ div
                        [ class "column is-one-quarter" ]
                        [ div [ class "level" ]
                            [ img [ class "profile-me", src model.picture ] [] ]
                        , div [ class "level" ]
                            [ text "Matthew King" ]
                        , (viewMediaLinks model)
                        ]
                    , div [ class "column is-three-quarters" ]
                        [ route model.route ]
                    ]
                ]
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
    map
        (\l ->
            a [ class "blog-post-item", onClick (ShowBlogPost l) ]
                [ p [ class "title is-6" ] [ text l.title ]
                , p [ class "subtitle is-6" ] [ text l.description ]
                ]
        )
        getBlogPosts


getBlogPosts : List BlogPost
getBlogPosts =
    [ softwareSchool, whatIMadeWithElmPost ]


viewBlogPost : BlogPost -> Html Msg
viewBlogPost post =
    div []
        [ h1 [ class "title" ] [ text post.title ]
        , p [] [ text post.description ]
        ]


softwareSchool : BlogPost
softwareSchool =
    { title = "Matt King's Software School"
    , description = "What I learned in software school is..."
    }


whatIMadeWithElmPost : BlogPost
whatIMadeWithElmPost =
    { title = "What I made with Elm"
    , description = "Here's the blog I made in Elm:..."
    }


route : Route -> Html Msg
route route =
    case route of
        Post blogPost ->
            viewBlogPost blogPost

        _ ->
            viewHome model
