module Roman where
import Html exposing (Html, span, text, div, button, p, a)
import Html.Attributes exposing(property, class, href)
import Html.Events exposing (onClick)
import Json.Encode
import String

import Family exposing(Family)
import FamilyDetail exposing(view)

-- MODEL 
type Gender = Female | Male

type alias Roman =
  { gender : Gender
  , praenomen : Maybe String
  , family : Family
  , cognomen : Maybe String
  , agnomen : Maybe String
  }

name : Roman -> String
name roman =
  let cognomen' = Maybe.withDefault "" roman.cognomen
      agnomen' = Maybe.withDefault "" roman.agnomen
      praenomen' = Maybe.withDefault "" roman.praenomen
      nomen' = genderedNomen roman.gender roman.family.nomen
  in
     String.join " " [praenomen', nomen', cognomen', agnomen']

genderedNomen : Gender -> String -> String
genderedNomen gender nomen =
  case gender of
    Female -> nomen
    Male -> (String.dropRight 1 nomen) ++ "us"

-- VIEW

view : Signal.Address () -> Roman -> Html
view address roman =
  div [class "wrapper"]
  [ div [class "random-roman"]
    [ div [class "name"]
      [ span [property "innerHTML" (Json.Encode.string <| genderSymbol roman)] []
      , span [] [ text (name roman) ]
      ]
    , div [class "button-container"] [ button [ onClick address () ] [ text "Roll a new random Roman!" ] ]
    , div [class "about" ]
      [ p []
        [ text "Rolling Random Romans is a simple project built by "
        , joelTwitterLink
        , text " to play with Elm's random generation."
        ]
      , p []
        [ text "A Roman is composed of a
          random gender, social status, family, praenomen, cognomen, and
          agnomen.  Some of these are independent while others are depend on
          the value of a previous random roll."
        ]
      , p []
        [ text "Check out the source on "
        , gitHubLink
        ]
      ]
    ]
  , FamilyDetail.view(roman.family)
  ]

joelTwitterLink : Html
joelTwitterLink =
  a [ href "https://twitter.com/joelquen"
    , property "innerHTML" (Json.Encode.string "Jo&euml;l Quenneville")
    ] []

gitHubLink : Html
gitHubLink =
  a [ href "https://github.com/JoelQ/rolling-random-romans"] [ text "GitHub" ]

genderSymbol : Roman -> String
genderSymbol roman =
  case roman.gender of
    Female -> "&female;"
    Male -> "&male;"
