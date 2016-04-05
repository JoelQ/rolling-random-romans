module Family where

type SocialStatus = Patrician | Plebian

type alias Family =
  { socialStatus : SocialStatus
  , nomen : String
  , cognomina : List String
  , favoredPraenomen : List String
  }

julia : Family
julia =
  Family
    Patrician
    "Julia"
    ["Caesar", "Iulus"]
    ["Lucius", "Gaius", "Sextus"]

fabia : Family
fabia =
  Family
    Patrician
    "Fabia"
    ["Maximus", "Licinus"]
    ["Caeso", "Quintus", "Marcus"]

junia : Family
junia =
  Family
    Patrician
    "Junia"
    ["Brutus", "Silanus"]
    ["Marcus", "Decimus", "Lucius"]

aemelia : Family
aemelia =
  Family
    Patrician
    "Aemelia"
    ["Paulus", "Lepidus"]
    ["Lucius", "Marcus", "Quintus"]

patricianFamilies : List Family
patricianFamilies =
  [ julia, fabia, junia, aemelia]

defaultPatricianFamily : Family
defaultPatricianFamily = julia

octavia : Family
octavia =
  Family
    Plebian
    "Octavia"
    ["Rufus"]
    ["Gnaeus", "Gaius", "Marcus"]

maria : Family
maria =
  Family
    Plebian
    "Maria"
    []
    ["Gaius", "Lucius", "Sextus"]

livia : Family
livia =
  Family
    Plebian
    "Livia"
    ["Drusus"]
    ["Gaius", "Lucius", "Titus"]

domitia : Family
domitia =
  Family
    Plebian
    "Domitia"
    ["Calvinus", "Ahenobarbus"]
    ["Gnaeus", "Marcus", "Lucius"]

plebianFamilies : List Family
plebianFamilies =
  [ octavia, maria, livia, domitia ]

defaultPlebianFamily : Family
defaultPlebianFamily = octavia
