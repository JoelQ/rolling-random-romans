module Main exposing (..)

import Html exposing (Html, main', h1, text)
import Html.App
import Random
import Random.Roman as RandomR
import Roman exposing (Roman, Msg(..))


type alias Model =
    Roman


initialModel : Model
initialModel =
    Roman.default



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Generate ->
            ( model, randomRoman )

        Generated roman ->
            ( roman, Cmd.none )


randomRoman : Cmd Msg
randomRoman =
    Random.generate Generated RandomR.roman



-- VIEW


view : Roman -> Html Msg
view roman =
    main' []
        [ h1 [] [ text "Rolling Random Romans" ]
        , Roman.view roman
        ]


main : Platform.Program Never
main =
    Html.App.program
        { init = ( initialModel, Cmd.none )
        , view = view
        , update = update
        , subscriptions = (\m -> Sub.none)
        }
