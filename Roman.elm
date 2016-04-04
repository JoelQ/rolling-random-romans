module Roman where
import String

type SocialStatus = Patrician | Plebian
type Gender = Female | Male

type alias Family =
  { socialStatus : SocialStatus
  , nomen : String
  , cognomina : List String
  , favoredPraenomen : List String
  }

type alias Roman =
  { gender : Gender
  , praenomen : Maybe String
  , family : Family
  , cognomen : Maybe String
  , agnomen : Maybe String
  }

name : Roman -> String
name roman =
  let cognomen' = Maybe.withDefault "" roman.cognomen
      agnomen' = Maybe.withDefault "" roman.agnomen
      praenomen' = Maybe.withDefault "" roman.praenomen
      nomen' = genderedNomen roman.gender roman.family.nomen
  in
     String.join " " [praenomen', nomen', cognomen', agnomen']

genderedNomen : Gender -> String -> String
genderedNomen gender nomen =
  case gender of
    Female -> nomen
    Male -> (String.dropRight 1 nomen) ++ "us"
