import Html exposing (Html, main', h1, p, text)
import Random
import Random.Roman as RandomR
import Roman exposing(Roman)


randomRoman : Roman
randomRoman =
  Random.generate RandomR.roman (Random.initialSeed 1234) |> fst

main : Html
main =
  main' []
  [ h1 [] [ text "Rolling Random Romans" ]
  , p [] [ randomRoman |> Roman.name |> text ]
  ]
