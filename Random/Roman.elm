module Random.Roman where

import Random exposing (Generator, andThen)
import Random.Extra as RandomE
import Random.Maybe as RandomM
import Random.Odds exposing(rollOdds)
import Random.Family exposing (socialStatus, family)

import Roman exposing (Roman, Family, Gender(..))

roman : Generator Roman
roman =
  socialStatus `andThen` family
    |> RandomE.flatMap2 romanFromGenderAndFamily gender

romanFromGenderAndFamily : Gender -> Family -> Generator Roman
romanFromGenderAndFamily gender family =
  let nickNames' = (familyCognomen family) `andThen` (nickNames gender)
      praenomen' = familyPraenomen family
  in
     Random.map2 (\pn (cn, an) -> Roman gender pn family cn an) praenomen' nickNames'

gender : Generator Gender
gender = rollOdds 50 Female Male

genericPraenomen : Generator (Maybe String)
genericPraenomen =
  RandomE.selectWithDefault "Publius" ["Publius", "Appius", "Tiberius"]
    |> RandomM.maybe

genericCognomen : Generator (Maybe String)
genericCognomen =
  RandomE.selectWithDefault "Gallus" ["Gallus", "Bibulus", "Albinus"]
    |> RandomM.maybe

familyCognomen : Family -> Generator (Maybe String)
familyCognomen family =
  let randomCognomen = RandomE.select family.cognomina
      replaceNothingWithGeneric cognomen' =
        case cognomen' of
          Just _ -> RandomE.constant cognomen'
          Nothing -> genericCognomen
  in
     randomCognomen `andThen` replaceNothingWithGeneric

favoredPraenomen : Family -> Generator (Maybe String)
favoredPraenomen family =
  let favored = RandomE.select family.favoredPraenomen
      defaultGeneric praenomen' =
        case praenomen' of
          Just _ -> RandomE.constant praenomen'
          Nothing -> genericPraenomen
  in
     favored `andThen` defaultGeneric

familyPraenomen : Family -> Generator (Maybe String)
familyPraenomen family =
  let favoredPraenomen' = favoredPraenomen family
  in
     RandomE.flatMap2 (rollOdds 80) favoredPraenomen' genericPraenomen

agnomen : Generator (Maybe String)
agnomen =
  RandomE.selectWithDefault "Pius" ["Pius", "Felix", "Africanus"]
    |> RandomM.maybe

nickNames : Gender -> Maybe String -> Generator (Maybe String, Maybe String)
nickNames gender cognomen =
  case (gender, cognomen) of
    (Female, _) -> RandomE.constant (Nothing, Nothing)
    (Male, Nothing) -> RandomE.constant (Nothing, Nothing)
    (Male, Just _) -> Random.map (\agnomen' -> (cognomen, agnomen')) agnomen
