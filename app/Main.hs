module Main (main) where

import Lib
import Data.Text (Text, pack, unpack)
import qualified Data.Text.IO as TIO
import System.Environment (getArgs)

main :: IO ()
main = do
 
  args <- getArgs
  case args of 
    [keywordStr] -> do
      printAllWordcounts $ wordcountMapFromList $ normalizeInputStr keywordStr
      printFoundKeywordCounts $ wordcountMapFromList $ normalizeInputStr keywordStr
      printNonWordcounts $ wordcountMapFromList $ normalizeInputStr keywordStr 
    _ -> do
      putStrLn "Please provide a string with all the keywords"