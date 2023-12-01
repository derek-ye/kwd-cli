module Lib
  -- ( isWordInStringWithKeywords,
  --   isWordInString,
  (  normalizeInputStr,
    wordcountMapFromList,
    splitTextOnCriteria,
    printAllWordcounts,
    printFoundKeywordCounts,
    filterKeywords,
    printNonWordcounts
  )
where

import qualified Data.Map as M
import Data.Text (Text, empty, pack, split, toLower)
import Text.Printf
import Data.List
import qualified Data.Text as T
import Data.Maybe (fromMaybe)

-- hard-coded keywords to search for
keywords :: [Text]
keywords = map pack ["blue", "green", "yellow", "orange", "red", "purple"]

wordcountMapFromList :: [Text] -> M.Map Text Int
wordcountMapFromList wordlist =  wordcountMapFromList' wordlist M.empty

wordcountMapFromList' :: [Text] -> M.Map Text Int -> M.Map Text Int
wordcountMapFromList' [] accMap = accMap
wordcountMapFromList' (currWord : xs) accMap
  -- {'apple': 1}
  -- if map contain word increment count
  | M.member currWord accMap = wordcountMapFromList' xs (M.insert currWord newCount accMap)
  -- otherwise set count to 1
  | otherwise = wordcountMapFromList' xs (M.insert currWord 1 accMap)
  where 
    oldCount = fromMaybe 0 (M.lookup currWord accMap) -- Extract value or default to 0 if key not found
    newCount = oldCount + 1

splitTextOnCriteria :: Text -> [Text]
splitTextOnCriteria t = filter (not . T.null) $ split (\c -> c `elem` [' ', ',', '.', '!', '?']) t

-- split text, strip symbols
normalizeInputStr :: String -> [Text]
normalizeInputStr inputStr = map toLower $ splitTextOnCriteria $ pack inputStr

-- printing functions
--  print in the format
--  Found keywords:
--  purple: 1
--  green: 2
--  ...
printFoundKeywordCounts :: M.Map Text Int -> IO ()
printFoundKeywordCounts m = putStr formattedKwCountStr 
  where
    keywordCountMap = filterKeywords m
    keywordCountArr = map formatWordCount $ M.toList keywordCountMap
    formattedKwCountStr = "Found keywords:\n" ++ intercalate "" keywordCountArr   ++ "\n"

printAllWordcounts :: M.Map Text Int -> IO ()
printAllWordcounts m = putStr formattedKwCountStr 
  where
    wordCountArr = map formatWordCount $ M.toList m
    formattedKwCountStr = "All word counts:\n" ++ intercalate "" wordCountArr ++ "\n"

printNonWordcounts :: M.Map Text Int -> IO ()
printNonWordcounts m = putStr formattedKwCountStr 
  where
    nonKeywordMap = filterNonKeywords m
    formattedKwCountStr = "Non-keyword count:" ++ show (M.size nonKeywordMap) ++ "\n"

-- function to format individual word, count values
formatWordCount :: (Show a, Show b) => (a, b) -> String
formatWordCount (k, v) = printf "%s: %s\n" (show k) (show v)

-- util functions
filterKeywords :: M.Map Text Int -> M.Map Text Int
filterKeywords = M.filterWithKey (\key _ -> isKeyword key)

filterNonKeywords :: M.Map Text Int -> M.Map Text Int
filterNonKeywords = M.filterWithKey (\key _ -> not $ isKeyword key) 
    
isKeyword :: Text -> Bool
isKeyword word = word `elem` keywords