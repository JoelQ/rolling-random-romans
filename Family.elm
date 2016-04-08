module Family where

type SocialStatus = Patrician | Plebian

type alias Image =
  { url : String
  , attributionText : String
  , description : String
  }

type alias Family =
  { socialStatus : SocialStatus
  , nomen : String
  , cognomina : List String
  , favoredPraenomen : List String
  , image : Image
  }

julia : Family
julia =
  Family
    Patrician
    "Julia"
    ["Caesar", "Iulus"]
    ["Lucius", "Gaius", "Sextus"]
    (Image
      "https://upload.wikimedia.org/wikipedia/commons/b/b5/Gaius_Iulius_Caesar_Vatican.jpeg"
      "Public domain via Wikimedia Commons"
      "Gaius Julius Caesar, conqueror of Gaul, Dictator of Rome, and arguably
      the most famous Roman of all time"
    )

fabia : Family
fabia =
  Family
    Patrician
    "Fabia"
    ["Maximus", "Licinus"]
    ["Caeso", "Quintus", "Marcus"]
    (Image
      "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/N26FabiusCunctator.jpg/238px-N26FabiusCunctator.jpg"
      "Public domain via Wikimedia Commons"
      "Quintus Fabius Maximus Cunctator, Dictator of Rome famous for wearing
      down Hannibal with delaying tactics."
    )

junia : Family
junia =
  Family
    Patrician
    "Junia"
    ["Brutus", "Silanus"]
    ["Marcus", "Decimus", "Lucius"]
    (Image
      "https://upload.wikimedia.org/wikipedia/commons/thumb/7/75/Ppr-brutus.JPG/398px-Ppr-brutus.JPG"
      "Public domain via Wikimedia Commons"
      "Marcus Junius Brutus, the most famous of Caesars assasins. His portrayal
      as a traitorous friend or noble patriot had inspired controversy ever
      since."
    )

aemilia : Family
aemilia =
  Family
    Patrician
    "Aemilia"
    ["Paulus", "Lepidus"]
    ["Lucius", "Marcus", "Quintus"]
    (Image
      "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d4/The_Triumph_of_Aemilius_Paulus_%28detail%29.jpg/640px-The_Triumph_of_Aemilius_Paulus_%28detail%29.jpg"
      "Public domain via Wikimedia Commons"
      "Lucius Aemilius Paulus Macedonicus, two-time Consul and conqueror of
        Macedonia (hence the agnomen)."
    )

patricianFamilies : List Family
patricianFamilies =
  [ julia, fabia, junia, aemilia]

defaultPatricianFamily : Family
defaultPatricianFamily = julia

octavia : Family
octavia =
  Family
    Plebian
    "Octavia"
    ["Rufus"]
    ["Gnaeus", "Gaius", "Marcus"]
    (Image
      "https://upload.wikimedia.org/wikipedia/commons/thumb/6/68/Cameo_August_BM_Gem3577.jpg/360px-Cameo_August_BM_Gem3577.jpg"
      "Public domain via Wikimedia Commons"
      "Gaius Octavius Thurinus (a.k.a Augustus Caesar), adopted son of Julius
      Caesar, defeator of Antony and Cleopatra, first emperor of Rome"
    )

maria : Family
maria =
  Family
    Plebian
    "Maria"
    []
    ["Gaius", "Lucius", "Sextus"]
    (Image
      "https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/John_Vanderlyn_-_Caius_Marius_Amid_the_Ruins_of_Carthage_-_Google_Art_Project.jpg/373px-John_Vanderlyn_-_Caius_Marius_Amid_the_Ruins_of_Carthage_-_Google_Art_Project.jpg"
      "Public domain via Wikimedia Commons"
      "Gaius Marius, 7 time consul, victorious general, and reformer of the
      Roman armies."
    )

livia : Family
livia =
  Family
    Plebian
    "Livia"
    ["Drusus"]
    ["Gaius", "Lucius", "Titus"]
    (Image
      "https://upload.wikimedia.org/wikipedia/commons/9/93/Livia_statue.jpg"
      "CC-BY-SA-3.0, via Wikimedia Commons"
      "Livia Drusilla, first empress of Rome"
    )

domitia : Family
domitia =
  Family
    Plebian
    "Domitia"
    ["Calvinus", "Ahenobarbus"]
    ["Gnaeus", "Marcus", "Lucius"]
    (Image
      "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Nero_Palatino_Inv618.jpg/358px-Nero_Palatino_Inv618.jpg"
      "Public domain via Wikimedia Commons"
      "Lucius Domitius Ahenobarbus (a.k.a Nero), 5th Roman emperor."
    )

plebianFamilies : List Family
plebianFamilies =
  [ octavia, maria, livia, domitia ]

defaultPlebianFamily : Family
defaultPlebianFamily = octavia
