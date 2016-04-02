module Random.Roman where

import Random exposing (Generator, andThen)
import Random.Extra as RandomE
import Random.Maybe as RandomM
import Random.Odds exposing(rollOdds)

import Roman exposing (Roman, Family, SocialStatus(..))

roman : Generator Roman
roman =
  let family' = socialStatus `andThen` family
      names' = family' `andThen` names
      roman' pn (f, cn, an) = Roman pn f cn an
  in
     Random.map2 roman' praenomen names'

praenomen : Generator String
praenomen =
  RandomE.selectWithDefault "Marcus" ["Marcus", "Quintus", "Gaius"]

genericCognomen : Generator (Maybe String)
genericCognomen =
  RandomE.selectWithDefault "Gallus" ["Gallus", "Bibulus", "Albinus"]
    |> RandomM.maybe

familyCognomen : Family -> Generator (Maybe String)
familyCognomen family =
  let cognomen' = RandomE.select family.cognomina
      replaceNothingWithGeneric cgnm =
        case cgnm of
          Just c -> RandomE.constant (Just c)
          Nothing -> genericCognomen
  in
     cognomen' `andThen` replaceNothingWithGeneric

agnomen : Generator (Maybe String)
agnomen =
  RandomE.selectWithDefault "Pius" ["Pius", "Felix", "Africanus"]
    |> RandomM.maybe

nickNames : Maybe String -> Generator (Maybe String, Maybe String)
nickNames cognomen =
  case cognomen of
    Just _ -> Random.map (\agnomen' -> (cognomen, agnomen')) agnomen
    Nothing -> RandomE.constant (Nothing, Nothing)

names : Family -> Generator (Family, Maybe String, Maybe String)
names family =
  let nickNames' = (familyCognomen family) `andThen` nickNames
  in
     Random.map (\(cn, an) -> (family, cn, an)) nickNames'

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
  [ Family Patrician "Julius" ["Caesar", "Iulus"]
  , Family Patrician "Fabius" ["Maximus", "Licinus"]
  , Family Patrician "Junius" ["Brutus", "Silanus"]
  , Family Patrician "Aemelius" ["Paulus", "Lepidus"]
  ]

defaultPatricianFamily : Family
defaultPatricianFamily =
  Family Patrician "Julius" ["Caesar", "Iulus"]

plebianFamilies : List Family
plebianFamilies =
  [ Family Plebian "Octavius" ["Rufus"]
  , Family Plebian "Marius" []
  , Family Plebian "Livius" ["Drusus"]
  , Family Plebian "Domitius" ["Calvinus", "Ahenobarbus"]
  ]

defaultPlebianFamily : Family
defaultPlebianFamily =
  Family Plebian "Octavius" ["Rufus"]
