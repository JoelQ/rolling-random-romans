module Random.Roman where

import Random exposing (Generator, andThen)
import Random.Extra as RandomE
import Random.Maybe as RandomM
import Roman exposing (Roman)

roman : Generator Roman
roman =
  let agnomen' = cognomen `andThen` agnomenFromCognomen
  in
     Random.map4 Roman praenomen nomen cognomen agnomen'

praenomen : Generator String
praenomen =
  RandomE.selectWithDefault "Marcus" ["Marcus", "Quintus", "Gaius"]

nomen : Generator String
nomen =
  RandomE.selectWithDefault "Julius" ["Julius", "Fabius", "Junius"]

cognomen : Generator (Maybe String)
cognomen =
  RandomE.selectWithDefault "Metellus" ["Metellus", "Caesar", "Brutus"]
    |> RandomM.maybe

agnomen : Generator (Maybe String)
agnomen =
  RandomE.selectWithDefault "Pius" ["Pius", "Felix", "Africanus"]
    |> RandomM.maybe

agnomenFromCognomen : Maybe String -> Generator (Maybe String)
agnomenFromCognomen cognomen =
  case cognomen of
    Just _ -> agnomen
    Nothing -> RandomE.constant Nothing
