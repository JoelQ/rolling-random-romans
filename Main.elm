import Html exposing (Html, main', h1, p, text, button)
import Html.Events exposing(onClick)
import Random
import Random.Roman as RandomR
import Roman exposing(Roman)

type alias Model = (Roman, Random.Seed)

initialModel : Model
initialModel =
  randomRoman (Random.initialSeed jsSeed)

randomRoman : Random.Seed -> Model
randomRoman seed =
  Random.generate RandomR.roman seed

update : Model -> Model
update (_, seed) =
  randomRoman seed

view : Signal.Address () -> Model -> Html
view address (roman, _) =
  main' []
  [ p [] [ roman |> Roman.name |> text ]
  , button [ onClick address () ] [ text "Roll another random Roman!" ]
  ]


port jsSeed : Int

inbox : Signal.Mailbox ()
inbox = Signal.mailbox ()

models : Signal Model
models =
  Signal.foldp (\_ model -> update model) initialModel inbox.signal

main : Signal Html
main =
  Signal.map (view inbox.address) models

