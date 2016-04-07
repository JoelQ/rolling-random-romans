module Roman where
import Html exposing (Html, span, text, div)
import Html.Attributes exposing(property, class)
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

view : Roman -> Html
view roman =
  div []
  [ div [class "name"]
    [ span [property "innerHTML" (Json.Encode.string <| genderSymbol roman)] []
    , span [] [ text (name roman) ]
    ]
  , FamilyDetail.view(roman.family)
  ]

genderSymbol : Roman -> String
genderSymbol roman =
  case roman.gender of
    Female -> "&female;"
    Male -> "&male;"
