module Main (main) where

import Lib
import Data.Text (Text, pack, unpack)
import qualified Data.Text.IO as TIO
import System.Environment (getArgs)

main :: IO ()
main = do
  -- TIO.putStr $ isWordInStringWithKeywords $ pack "My favorite color is blue!\n" -- should be found
  -- TIO.putStr $ isWordInStringWithKeywords $ pack "My favorite color is teal!\n" -- should be not found
  -- TIO.putStr $ isWordInStringWithKeywords $ pack "scared\n" -- should be not found
  -- TIO.putStr $ isWordInStringWithKeywords $ pack "SpOoKy sCaRy sKeLeToNs\n" -- should be found
  -- TIO.putStr $ isWordInStringWithKeywords $ pack "Jack the pumpkinking.\n" -- should be not found
  -- TIO.putStr $ isWordInStringWithKeywords $ pack "Carve a pumpkin.\n" -- should be found
  -- putStrLn $ show $ splitTextOnCriteria $ pack "My favorite color is teal!"
  -- putStrLn $ show $ countWordsMapFromList $ splitTextOnCriteria $ pack "My favorite color is teal!"
  -- putStrLn $ show $ countWordsMapFromList $ splitTextOnCriteria $ pack "orange orange blue aqua blue green red teal"
  args <- getArgs
  case args of 
    [keywordStr] -> do
      printAllWordcounts $ wordcountMapFromList $ normalizeInputStr keywordStr
      printFoundKeywordCounts $ wordcountMapFromList $ normalizeInputStr keywordStr
      printNonWordcounts $ wordcountMapFromList $ normalizeInputStr keywordStr 
    _ -> do
      putStrLn "Please provide a string with all the keywords"