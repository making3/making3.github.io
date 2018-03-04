module Main exposing (main)

import Html exposing (Html, body, section, div, text, h1, p, img, label, a)
import Html.Attributes exposing (class, src)
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
    }


type alias BlogPost =
    { title : String
    , description : String
    }


model =
    { title = "making3's Software Blog"
    , picture = "https://secure.gravatar.com/avatar/1e84d7b396211e9c7bbd888dc51249a4?s=188"
    , posts = []
    }



-- UPDATE


type Msg
    = ShowHomePage
    | ShowWhatIMadeWithElmPost


update : Msg -> Model -> Model
update msg model =
    model



-- case msg of
--     ShowHomePage ->
--         home
--
--     ShowWhatIMadeWithElmPost ->
--         whatIMadeWithElmPost
-- VIEW
-- body []
--     [ h1 [] [ text model.title ]
--     , text model.description
--     , div []
--         [ button [ onClick ShowHomePage ] [ text "Home" ]
--         , button [ onClick ShowWhatIMadeWithElmPost ] [ text "What I made with Elm" ]
--         ]
--     ]


view : Model -> Html Msg
view model =
    body []
        [ div [ class "section" ]
            [ div [ class "container" ]
                [ h1 [ class "title" ]
                    [ text model.title ]
                , div [ class "columns" ]
                    [ div
                        [ class "column is-one-quarter" ]
                        [ div [ class "level" ]
                            [ img [ class "profile-me", src model.picture ] [] ]
                        , div [ class "level" ]
                            [ text "Matthew King" ]
                        ]
                    , div [ class "column is-three-quarters" ]
                        [ viewHome model ]
                    ]
                ]
            ]
        ]


viewHome : Model -> Html Msg
viewHome model =
    div [] (listBlogPosts model.posts)


listBlogPosts : List BlogPost -> List (Html Msg)
listBlogPosts blogPosts =
    map
        (\l ->
            a [ class "blog-post-item" ]
                [ p [ class "title is-6" ] [ text l.title ]
                , p [ class "subtitle is-6" ] [ text l.description ]
                ]
        )
        getBlogPosts


getBlogPosts : List BlogPost
getBlogPosts =
    [ softwareSchool, whatIMadeWithElmPost ]


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
