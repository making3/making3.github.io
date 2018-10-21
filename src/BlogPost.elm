module BlogPost exposing (getBlogPosts)

import Model exposing (BlogPost)
import Posts.Intro as Intro exposing (post)


getBlogPosts : List BlogPost
getBlogPosts =
    [ Intro.post
    ]
