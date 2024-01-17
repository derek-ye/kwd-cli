{-# LANGUAGE OverloadedStrings #-}

import Test.HUnit
import qualified Data.Map as M
import Lib

testOneOfEachWord :: Test
testOneOfEachWord = TestCase
    (assertEqual "Test failed"
        (M.fromList [("my", 1), ("favorite", 1), ("color", 1), ("is", 1), ("blue", 1)])
        (wordcountMapFromList $ normalizeInputStr "My favorite color is blue!"))
testSingleWord :: Test
testSingleWord = TestCase
    (assertEqual "Test failed"
        (M.fromList [("scared", 1)])
        (wordcountMapFromList $ normalizeInputStr "scared"))
testDuplicates :: Test
testDuplicates = TestCase
    (assertEqual "Test failed"
      (M.fromList [("orange", 2), ("blue", 2), ("green", 1), ("red", 1), ("teal", 1), ("aqua", 1)])
        (wordcountMapFromList $ normalizeInputStr "orange orange blue aqua blue green red teal"))
testCapitalizedWordsShouldBeLowercased :: Test
testCapitalizedWordsShouldBeLowercased = TestCase
    (assertEqual "Test failed"
      (M.fromList [("orange", 2), ("blue", 2), ("green", 1), ("red", 1), ("teal", 1), ("aqua", 1)])
        (wordcountMapFromList $ normalizeInputStr "Orange orange bLuE Aqua blue grEEn REd teAL"))
testNonAlphaCharsShouldBeRemoved :: Test
testNonAlphaCharsShouldBeRemoved = TestCase
    (assertEqual "Test failed"
        (M.fromList [("orange", 2), ("blue", 2), ("green", 1), ("red", 1), ("teal", 1), ("aqua", 1)])
          (wordcountMapFromList $ normalizeInputStr "Orange!@ orange @#blue aqu)(a b!^lue green+_ r*ed t!eal"))

tests :: Test
tests = TestList [ TestLabel "testOneOfEachWord" testOneOfEachWord
  , TestLabel "testSingleWord" testSingleWord
  , TestLabel "testDuplicates" testDuplicates
  , TestLabel "testCapitalizedWordsShouldBeLowercased" testCapitalizedWordsShouldBeLowercased
  , TestLabel "testNonAlphaCharsShouldBeRemoved" testNonAlphaCharsShouldBeRemoved
  ]

main :: IO ()
main = do
    counts <- runTestTT tests
    print counts
