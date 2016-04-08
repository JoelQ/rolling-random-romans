import Html exposing (Html, main', h1, text)
import Random
import Random.Roman as RandomR
import Roman exposing(Roman)

type alias Model = (Roman, Random.Seed)

initialModel : Model
initialModel =
  randomRoman (Random.initialSeed jsSeed)

-- UPDATE

update : Model -> Model
update (_, seed) =
  randomRoman seed


randomRoman : Random.Seed -> Model
randomRoman seed =
  Random.generate RandomR.roman seed

-- VIEW

view : Signal.Address () -> Roman -> Html
view address roman =
  main' []
  [ h1 [] [ text "Rolling Random Romans" ]
  , Roman.view address roman
  ]


port jsSeed : Int

inbox : Signal.Mailbox ()
inbox = Signal.mailbox ()

models : Signal Model
models =
  Signal.foldp (\_ model -> update model) initialModel inbox.signal

main : Signal Html
main =
  Signal.map (fst >> (view inbox.address)) models
