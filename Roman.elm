module Roman where
import Html exposing (Html, span, text, div, button, p, a, dl, dt, dd)
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
    , div [class "about" ] [ summary , variableList , sourceCode ]
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

summary : Html
summary =
  p []
  [ text "Rolling Random Romans is a simple project built by "
  , joelTwitterLink
  , text " to play with Elm's random generation."
  ]

variableList : Html
variableList =
  p []
  [ text "A Roman is composed of the following random attributes:"
  , dl []
    [ dt [] [ text "Gender" ]
    , dd [] [ text "Independent variable" ]
    , dt [] [ text "Social Status" ]
    , dd [] [ text "Patrician or Plebian, independent variable" ]
    , dt [] [ text "Family" ]
    , dd [] [ text "Historical family, depends on social status" ]
    , dt [] [ text "Praenomen" ]
    , dd [] [ text "A personal name. Weighted towards family preference.
      Women don't get one." ]
    , dt [] [ text "Cognomen" ]
    , dd [] [ text "A nickname, can be hereditary denoting a branch of a
      family. Depends on family. Women don't get one." ]
    , dt [] [ text "Agnomen" ]
    , dd [] [ text "A second nickname or honorific. Only present if
      cognomen is present. Women don't get one." ]
    ]
  ]

sourceCode : Html
sourceCode =
  p []
  [ text "Check out the source on "
  , gitHubLink
  ]

genderSymbol : Roman -> String
genderSymbol roman =
  case roman.gender of
    Female -> "&female;"
    Male -> "&male;"
