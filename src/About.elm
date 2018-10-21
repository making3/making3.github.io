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


Hi! I'm Matthew King. I'm a software developer currently working for [iWT Health](https://www.iwthealth.com/) for a variety of backend services.
  My _cool_ Github name came from my university, which I ended up creating my Stack Overflow and Github profiles from (for no real reason),
  which I stuck with somewhat. Since then, I've been _nicknamed_ matth due to a past colleague shortening my name as Matth instead of Matt (from Matthew), so I've embraced it the "joke" of it.

I started my journey as a co-op student at iWT Health back in 2009 and have been fascinated by working
  on the layer of software that runs behind the front of the business. I started writing C# services and backends (with tiny front-ends),
  which eventually lead to Node.js as a integration-services layer. Although I still work with Node.js, I've been exploring functional programming,
  inspired by a fellow co-worker, [absynce](https://absynce.github.io/), which brought Erlang, Elixir, and Elm to my attention.

As for a personal note, I don't have the best range of hobbies, but mostly includes gaming / walking / running / binging on Netflix. Otherwise, my Wife and I recently moved from the
  midwest to the bay area to pursue her career, and we've been exploring all sorts of places in California!

## Contact / Social Stuff


- [Twitter](https://twitter.com/making_3)
- [GitHub](https://github.com/making3)
- <mailto:making3dev@gmail.com>
- [Stack Overflow](https://stackoverflow.com/users/724591/matth?tab=profile)

## Acknowledgements

- [Jared Smith (absynce)](https://absynce.github.io/)
- [Alex Owens](http://www.aowens.me/)
- Josh Miller (first mentor) - For guiding me with programming early as a co-op student.

"""
