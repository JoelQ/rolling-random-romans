module Random.Family where

import Random exposing (Generator, andThen)
import Random.Extra as RandomE
import Random.Odds exposing(rollOdds)

import Family exposing
  ( Family
  , SocialStatus(..)
  , defaultPlebianFamily
  , defaultPatricianFamily
  , plebianFamilies
  , patricianFamilies
  )

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
