module Roman where
import String

type SocialStatus = Patrician | Plebian

type alias Family =
  { socialStatus : SocialStatus
  , nomen : String
  }

type alias Roman =
  { praenomen : String
  , family : Family
  , cognomen : Maybe String
  , agnomen : Maybe String
  }

name : Roman -> String
name roman =
  let cognomen' = Maybe.withDefault "" roman.cognomen
      agnomen' = Maybe.withDefault "" roman.agnomen
      nomen' = roman.family.nomen
  in
     String.join " " [roman.praenomen, nomen', cognomen', agnomen']
