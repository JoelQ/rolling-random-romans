module Random.Roman where

import Random exposing (Generator, andThen)
import Random.Extra as RandomE
import Random.Maybe as RandomM
import Random.Odds exposing(rollOdds)

import Roman exposing (Roman, Family, SocialStatus(..))

roman : Generator Roman
roman =
  let nickNames' = cognomen `andThen` nickNames
      family' = socialStatus `andThen` family
      roman' pn f (cn, an) = Roman pn f cn an
  in
     Random.map3 roman' praenomen family' nickNames'

praenomen : Generator String
praenomen =
  RandomE.selectWithDefault "Marcus" ["Marcus", "Quintus", "Gaius"]

cognomen : Generator (Maybe String)
cognomen =
  RandomE.selectWithDefault "Metellus" ["Metellus", "Caesar", "Brutus"]
    |> RandomM.maybe

agnomen : Generator (Maybe String)
agnomen =
  RandomE.selectWithDefault "Pius" ["Pius", "Felix", "Africanus"]
    |> RandomM.maybe

nickNames : Maybe String -> Generator (Maybe String, Maybe String)
nickNames cognomen =
  case cognomen of
    Just _ -> Random.map (\agnomen' -> (cognomen, agnomen')) agnomen
    Nothing -> RandomE.constant (Nothing, Nothing)

socialStatus : Generator SocialStatus
socialStatus =
  rollOdds 70 Plebian Patrician

family : SocialStatus -> Generator Family
family status =
  case status of
    Patrician -> patrician
    Plebian -> plebian

patrician : Generator Family
patrician =
  RandomE.selectWithDefault defaultPatricianFamily patricianFamilies

plebian : Generator Family
plebian =
  RandomE.selectWithDefault defaultPlebianFamily plebianFamilies

patricianFamilies : List Family
patricianFamilies =
  [ Family Patrician "Julius"
  , Family Patrician "Fabius"
  , Family Patrician "Junius"
  , Family Patrician "Aemelius"
  ]

defaultPatricianFamily : Family
defaultPatricianFamily =
  Family Patrician "Julius"

plebianFamilies : List Family
plebianFamilies =
  [ Family Plebian "Octavius"
  , Family Plebian "Marius"
  , Family Plebian "Livius"
  , Family Plebian "Domitius"
  ]

defaultPlebianFamily : Family
defaultPlebianFamily =
  Family Plebian "Octavius"
