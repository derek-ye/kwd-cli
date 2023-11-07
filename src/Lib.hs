module Lib
  ( isWordInStringWithKeywords,
    isWordInString,
  )
where

import Data.List
import Data.Text (Text, empty, pack, split, toLower)

splitTextOnCriteria :: Text -> [Text]
splitTextOnCriteria t = split (\c -> c `elem` [' ', ',', '.', '!', '?']) t

isWordInStringWithKeywords :: Text -> Text
isWordInStringWithKeywords = isWordInString $ map pack ["blue", "green", "yellow", "orange", "red", "purple", "pumpkin", "scary"]

isWordInString :: [Text] -> Text -> Text
isWordInString [] _ = pack "No keywords provided"
isWordInString _ t | t == empty = pack "No keywords found :("
isWordInString keywords inputStr =
    let splitInput = map toLower $ splitTextOnCriteria inputStr
        containsWord = any (\word -> word `elem` keywords) splitInput
    in if containsWord
        then pack "Keyword found!\n"
        else pack "No keywords found\n"