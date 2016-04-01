module Random.Odds where

import Random exposing(Generator)

percent : Generator Int
percent =
  Random.int 0 100

rollOdds : Int -> a -> a -> Generator a
rollOdds odds success failure =
  Random.map (oddsToValue success failure odds) percent

oddsToValue : a -> a -> Int -> Int -> a
oddsToValue success failure odds rolledValue =
  case odds >= rolledValue of
    True -> success
    False -> failure
