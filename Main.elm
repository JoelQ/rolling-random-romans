import Html exposing (Html, main', h1, p, text)
import Random
import Random.Roman as RandomR
import Roman exposing(Roman)


randomRoman : Roman
randomRoman =
  Random.generate RandomR.roman (Random.initialSeed jsSeed) |> fst

port jsSeed : Int

main : Html
main =
  main' []
  [ h1 [] [ text "Rolling Random Romans" ]
  , p [] [ randomRoman |> Roman.name |> text ]
  ]
