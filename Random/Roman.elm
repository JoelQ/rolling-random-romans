module Random.Roman where

import Random exposing (Generator, andThen)
import Random.Extra as RandomE
import Random.Maybe as RandomM
import Random.Odds exposing(rollOdds)

import Roman exposing (Roman, Family, SocialStatus(..))

roman : Generator Roman
roman =
  socialStatus
  `andThen` family
  `andThen` names
    |> Random.map (\(pn, f, cn, an) -> Roman pn f cn an)

genericPraenomen : Generator String
genericPraenomen =
  RandomE.selectWithDefault "Publius" ["Publius", "Appius", "Tiberius"]

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

favoredPraenomen : Family -> Generator String
favoredPraenomen family =
  let favored = RandomE.select family.favoredPraenomen
      defaultGeneric praenomen =
        case praenomen of
          Just praenomen' -> RandomE.constant praenomen'
          Nothing -> genericPraenomen
  in
     favored `andThen` defaultGeneric

familyPraenomen : Family -> Generator String
familyPraenomen family =
  let favoredPraenomen' = favoredPraenomen family
  in
     RandomE.flatMap2 (rollOdds 80) favoredPraenomen' genericPraenomen

agnomen : Generator (Maybe String)
agnomen =
  RandomE.selectWithDefault "Pius" ["Pius", "Felix", "Africanus"]
    |> RandomM.maybe

nickNames : Maybe String -> Generator (Maybe String, Maybe String)
nickNames cognomen =
  case cognomen of
    Just _ -> Random.map (\agnomen' -> (cognomen, agnomen')) agnomen
    Nothing -> RandomE.constant (Nothing, Nothing)

names : Family -> Generator (String, Family, Maybe String, Maybe String)
names family =
  let nickNames' = (familyCognomen family) `andThen` nickNames
      praenomen' = familyPraenomen family
  in
     Random.map2 (\pn (cn, an) -> (pn, family, cn, an)) praenomen' nickNames'

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
  [ Family Patrician "Julius" ["Caesar", "Iulus"] ["Lucius", "Gaius", "Sextus"]
  , Family Patrician "Fabius" ["Maximus", "Licinus"] ["Caeso", "Quintus", "Marcus"]
  , Family Patrician "Junius" ["Brutus", "Silanus"] ["Marcus", "Decimus", "Lucius"]
  , Family Patrician "Aemelius" ["Paulus", "Lepidus"] ["Lucius", "Marcus", "Quintus"]
  ]

defaultPatricianFamily : Family
defaultPatricianFamily =
  Family Patrician "Julius" ["Caesar", "Iulus"] ["Lucius", "Gaius", "Sextus"]

plebianFamilies : List Family
plebianFamilies =
  [ Family Plebian "Octavius" ["Rufus"] ["Gnaeus", "Gaius", "Marcus"]
  , Family Plebian "Marius" [] ["Gaius", "Lucius", "Sextus"]
  , Family Plebian "Livius" ["Drusus"] ["Gaius", "Lucius", "Titus"]
  , Family Plebian "Domitius" ["Calvinus", "Ahenobarbus"] ["Gnaeus", "Marcus", "Lucius"]
  ]

defaultPlebianFamily : Family
defaultPlebianFamily =
  Family Plebian "Octavius" ["Rufus"] []
