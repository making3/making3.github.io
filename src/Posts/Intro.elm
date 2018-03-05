module Posts.Intro exposing (..)

import Model exposing (BlogPost)


post : BlogPost
post =
    { title = "Blog Introduction"
    , description = "Why I'm making a blog..."
    , content = getContent
    }


getContent =
    """
  Test
"""
