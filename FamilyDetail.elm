module FamilyDetail where

import Html exposing(Html, div, h2, img, p, small, text)
import Html.Attributes exposing(class, src)

import Family exposing(Family)

view : Family -> Html
view family =
  div [class "family-detail"]
  [ h2 [] [ text ("Famous member of gens " ++ family.nomen ) ]
  , div [ class "image-with-attribution" ]
    [ img [ src family.image.url ] []
    , p [] [ small[] [ text family.image.attributionText ]]
    ]
  , p [ class "description" ] [ text family.image.description ]
  ]
