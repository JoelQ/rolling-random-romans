module Random.Roman where

import Random exposing (Generator, andThen)
import Random.Extra as RandomE
import Random.Maybe as RandomM
import Random.Odds exposing(rollOdds)
import Random.Family exposing (socialStatus, family)

import Roman exposing (Roman, Family, Gender(..))

roman : Generator Roman
roman =
  socialStatus
  `andThen` family
  `andThen` names
    |> Random.map2 (\g (pn, f, cn, an) -> Roman g pn f cn an) gender

gender : Generator Gender
gender = rollOdds 50 Female Male

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
