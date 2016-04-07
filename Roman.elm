module Roman where
import Html exposing (Html, span, p, text, div, img, small, h2)
import Html.Attributes exposing(property, src, class)
import Json.Encode
import String

import Family exposing(Family)

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
  , div [class "family-detail"]
    [ h2 [] [ text ("Famous member of gens " ++ roman.family.nomen ) ]
    , div [ class "image-with-attribution" ]
      [ img [ src roman.family.image.url ] []
      , p [] [ small[] [ text roman.family.image.attributionText ]]
      ]
    , p [ class "description" ] [ text roman.family.image.description ]
    ]
  ]

genderSymbol : Roman -> String
genderSymbol roman =
  case roman.gender of
    Female -> "&female;"
    Male -> "&male;"
