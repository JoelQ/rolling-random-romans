module Random.Roman where

import Random exposing (Generator, andThen)
import Random.Extra as RandomE
import Random.Maybe as RandomM
import Roman exposing (Roman)

roman : Generator Roman
roman =
  let nickNames' = cognomen `andThen` nickNames
      roman' pn n (cn, an) = Roman pn n cn an
  in
     Random.map3 roman' praenomen nomen nickNames'

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

nickNames : Maybe String -> Generator (Maybe String, Maybe String)
nickNames cognomen =
  case cognomen of
    Just _ -> Random.map (\agnomen' -> (cognomen, agnomen')) agnomen
    Nothing -> RandomE.constant (Nothing, Nothing)
