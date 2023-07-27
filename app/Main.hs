module Main (main) where

import Lib

main :: IO ()
main = do
  putStr $ isWordInStringWithKeywords "My favorite color is blue!\n"
  putStr $ isWordInStringWithKeywords "My favorite color is teal!\n"