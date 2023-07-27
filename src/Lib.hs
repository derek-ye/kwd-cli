module Lib
  ( someFunc,
    isWordInStringWithKeywords,
    isWordInString,
  )
where

import Data.List

someFunc :: IO ()
someFunc = putStrLn "someFunc"

isWordInStringWithKeywords :: String -> String
isWordInStringWithKeywords = isWordInString ["blue", "green", "yellow", "orange", "red", "purple"]

isWordInString :: [String] -> String -> String
isWordInString [] _ = "No keywords provided"
isWordInString _ "" = "No keywords found :("
isWordInString keywords inputStr =
  let containsWord = any (`isInfixOf` inputStr) keywords
   in if containsWord
        then "Keyword found!"
        else "No keywords found"