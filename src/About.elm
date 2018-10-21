module About exposing (getAbout, view)

import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Markdown exposing (toHtml)
import Model exposing (Msg)


view : Html Msg
view =
    div [ class "level" ]
        [ Markdown.toHtml [ class "content" ] getAbout
        ]


getAbout : String
getAbout =
    """

## Who am I?


Hi! I'm Matthew King. I'm a software developer currently working for <a href="https://www.iwthealth.com/" target="_blank">iWT Health</a> for a variety of backend services.
  My _cool_ Github name came from my university, which I ended up creating my Stack Overflow and Github profiles from (for no real reason),
  which I stuck with somewhat. Since then, I've been _nicknamed_ matth due to a past colleague shortening my name as Matth instead of Matt (from Matthew), so I've embraced it the "joke" of it.

I started my journey as a co-op student at iWT Health back in 2009 and have been fascinated by working
  on the layer of software that runs behind the front of the business. I started writing C# services and backends (with tiny front-ends),
  which eventually lead to Node.js as a integration-services layer. Although I still work with Node.js, I've been exploring functional programming,
  inspired by a fellow co-worker, <a href="https://absynce.github.io/" target="_blank">absynce</a>, which brought Erlang, Elixir, and Elm to my attention.

As for a personal note, I don't have the best range of hobbies, but mostly includes gaming / walking / running / binging on Netflix. Otherwise, my Wife and I recently moved from the
  midwest to the bay area to pursue her career, and we've been exploring all sorts of places in California!

## Contact / Social Stuff


- <a href="https://twitter.com/making_3" target="_blank">Twitter</a>
- <a href="https://github.com/making3" target="_blank">GitHub</a>
- <mailto:making3dev@gmail.com>
- <a href="https://stackoverflow.com/users/724591/matth?tab=profile" target="_blank">Stack Overflow</a>

## Acknowledgements

- <a href="https://absynce.github.io/" target="_blank">Jared Smith (absynce)</a>
- <a href="http://www.aowens.me/" target="_blank">Alex Owens</a>
- Josh Miller (first mentor) - For guiding me with programming early as a co-op student.

"""
