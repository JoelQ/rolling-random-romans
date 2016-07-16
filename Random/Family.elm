module Random.Family exposing (..)

import Random exposing (Generator, andThen)
import Random.Extra as RandomE
import Random.Odds exposing (rollOdds)
import Family
    exposing
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
        Patrician ->
            patrician

        Plebian ->
            plebian


patrician : Generator Family
patrician =
    RandomE.sample patricianFamilies
        |> Random.map (Maybe.withDefault defaultPatricianFamily)


plebian : Generator Family
plebian =
    RandomE.sample plebianFamilies
        |> Random.map (Maybe.withDefault defaultPlebianFamily)
