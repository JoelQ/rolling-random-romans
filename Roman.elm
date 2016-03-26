module Roman where
import String

type alias Roman =
  { praenomen : String
  , nomen : String
  , cognomen : Maybe String
  }

name : Roman -> String
name roman =
  let cognomen' = Maybe.withDefault "" roman.cognomen
  in
     String.join " " [roman.praenomen, roman.nomen, cognomen']
