module Random.Roman where

import Random exposing (Generator, andThen)
import Random.Extra as RandomE
import Random.Maybe as RandomM
import Roman exposing (Roman)

roman : Generator Roman
roman =
  Random.map3 Roman praenomen nomen cognomen

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
