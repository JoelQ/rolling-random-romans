module Random.Family where

import Random exposing (Generator, andThen)
import Random.Extra as RandomE
import Random.Odds exposing(rollOdds)

import Roman exposing (Family, SocialStatus(..))

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
