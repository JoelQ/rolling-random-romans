module Random.Roman where

import Random exposing (Generator, andThen)
import Random.Extra as RandomE
import Roman exposing (Roman)

roman : Generator Roman
roman =
  Random.map4 Roman praenomen nomen cognomen agnomen

praenomen : Generator String
praenomen =
  RandomE.selectWithDefault "Marcus" ["Marcus", "Quintus", "Gaius"]

nomen : Generator String
nomen =
  RandomE.selectWithDefault "Julius" ["Julius", "Fabius", "Junius"]

cognomen : Generator (Maybe String)
cognomen =
  let cognomina = ["Metellus", "Caesar", "Brutus"]
      cognomen' = RandomE.selectWithDefault "Metellus" cognomina
      boolToCognomen bool =
        case bool of
          True -> Random.map Just cognomen'
          False -> RandomE.constant Nothing
  in
     Random.bool `andThen` boolToCognomen

agnomen : Generator (Maybe String)
agnomen =
  let agnomen' = RandomE.selectWithDefault "Pius" ["Pius", "Africanus", "Felix"]
      boolToAgnomen bool =
        case bool of
          True -> Random.map Just agnomen'
          False -> RandomE.constant Nothing
  in
     Random.bool `andThen` boolToAgnomen
