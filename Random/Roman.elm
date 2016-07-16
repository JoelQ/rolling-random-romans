module Random.Roman exposing (..)

import Random exposing (Generator, andThen)
import Random.Extra as RandomE
import Random.Odds exposing (rollOdds)
import Random.Family exposing (socialStatus, family)
import Roman exposing (Roman, Gender(..))
import Family exposing (Family)


roman : Generator Roman
roman =
    socialStatus
        `andThen` family
        |> RandomE.flatMap2 romanFromGenderAndFamily gender


romanFromGenderAndFamily : Gender -> Family -> Generator Roman
romanFromGenderAndFamily gender' family =
    let
        nickNames' =
            (familyCognomen family) `andThen` (nickNames gender')

        praenomen' =
            familyPraenomen family gender'
    in
        Random.map2 (\pn ( cn, an ) -> Roman gender' pn family cn an) praenomen' nickNames'


gender : Generator Gender
gender =
    rollOdds 50 Female Male


genericPraenomen : Gender -> Generator (Maybe String)
genericPraenomen gender' =
    case gender' of
        Female ->
            RandomE.constant Nothing

        Male ->
            RandomE.sample [ "Publius", "Appius", "Tiberius" ]


genericCognomen : Generator (Maybe String)
genericCognomen =
    RandomE.sample [ "Gallus", "Bibulus", "Albinus" ]


familyCognomen : Family -> Generator (Maybe String)
familyCognomen family =
    let
        randomCognomen =
            RandomE.sample family.cognomina

        replaceNothingWithGeneric cognomen' =
            case cognomen' of
                Just _ ->
                    RandomE.constant cognomen'

                Nothing ->
                    genericCognomen
    in
        randomCognomen `andThen` replaceNothingWithGeneric


favoredPraenomen : Family -> Gender -> Generator (Maybe String)
favoredPraenomen family gender' =
    let
        favored =
            RandomE.sample family.favoredPraenomen

        defaultGeneric praenomen' =
            case ( gender', praenomen' ) of
                ( Female, _ ) ->
                    RandomE.constant Nothing

                ( Male, Nothing ) ->
                    genericPraenomen gender'

                ( Male, Just _ ) ->
                    RandomE.constant praenomen'
    in
        favored `andThen` defaultGeneric


familyPraenomen : Family -> Gender -> Generator (Maybe String)
familyPraenomen family gender' =
    let
        favoredPraenomen' =
            favoredPraenomen family gender'

        genericPraenomen' =
            genericPraenomen gender'
    in
        RandomE.flatMap2 (rollOdds 80) favoredPraenomen' genericPraenomen'


agnomen : Generator (Maybe String)
agnomen =
    RandomE.sample [ "Pius", "Felix", "Africanus" ]
        |> Random.map (Maybe.withDefault "Pius")
        |> RandomE.maybe (RandomE.oneIn 2)


nickNames : Gender -> Maybe String -> Generator ( Maybe String, Maybe String )
nickNames gender cognomen =
    case ( gender, cognomen ) of
        ( Female, _ ) ->
            RandomE.constant ( Nothing, Nothing )

        ( Male, Nothing ) ->
            RandomE.constant ( Nothing, Nothing )

        ( Male, Just _ ) ->
            Random.map (\agnomen' -> ( cognomen, agnomen' )) agnomen
