module BlogPost exposing (blogPosts, toBlogPost)

import Dict
import Model exposing (BlogPost)
import Posts.Intro as Intro exposing (post)


toBlogPost : String -> BlogPost
toBlogPost url =
    let
        maybePost =
            Dict.get url blogPosts
    in
    case maybePost of
        Just post ->
            post

        _ ->
            notFound url


blogPosts : Dict.Dict String BlogPost
blogPosts =
    Dict.fromList
        [ ( "intro", Intro.post )
        ]


notFound : String -> BlogPost
notFound url =
    { title = "Not found"
    , description = ""
    , content = "Blog post " ++ url ++ " not found"
    }
