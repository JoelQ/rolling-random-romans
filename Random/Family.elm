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
  [ Family Patrician "Julia" ["Caesar", "Iulus"] ["Lucius", "Gaius", "Sextus"]
  , Family Patrician "Fabia" ["Maximus", "Licinus"] ["Caeso", "Quintus", "Marcus"]
  , Family Patrician "Fabia" ["Brutus", "Silanus"] ["Marcus", "Decimus", "Lucius"]
  , Family Patrician "Aemelia" ["Paulus", "Lepidus"] ["Lucius", "Marcus", "Quintus"]
  ]

defaultPatricianFamily : Family
defaultPatricianFamily =
  Family Patrician "Julia" ["Caesar", "Iulus"] ["Lucius", "Gaius", "Sextus"]

plebianFamilies : List Family
plebianFamilies =
  [ Family Plebian "Octavia" ["Rufus"] ["Gnaeus", "Gaius", "Marcus"]
  , Family Plebian "Maria" [] ["Gaius", "Lucius", "Sextus"]
  , Family Plebian "Livia" ["Drusus"] ["Gaius", "Lucius", "Titus"]
  , Family Plebian "Domitia" ["Calvinus", "Ahenobarbus"] ["Gnaeus", "Marcus", "Lucius"]
  ]

defaultPlebianFamily : Family
defaultPlebianFamily =
  Family Plebian "Octavia" ["Rufus"] ["Gnaeus", "Gaius", "Marcus"]
