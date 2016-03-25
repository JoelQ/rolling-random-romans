module Roman where
import String

type alias Roman =
  { praenomen : String
  , nomen : String
  , cognomen : Maybe String
  , agnomen : Maybe String
  }

name : Roman -> String
name roman =
  let cognomen' = Maybe.withDefault "" roman.cognomen
      agnomen' = Maybe.withDefault "" roman.agnomen
  in
     String.join " " [roman.praenomen, roman.nomen, cognomen', agnomen']
