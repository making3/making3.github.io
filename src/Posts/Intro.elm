module Posts.Intro exposing (getContent, post)

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
