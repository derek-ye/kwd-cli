{-# LANGUAGE OverloadedStrings #-}

import Test.HUnit
import qualified Data.Map as M
import Lib

testOneOfEachWord :: Test
testOneOfEachWord = TestCase
    (assertEqual "Test failed"
        (wordcountMapFromList $ normalizeInputStr "My favorite color is blue!")
        (M.fromList [("my", 1), ("favorite", 1), ("color", 1), ("is", 1), ("blue", 1)]))
testSingleWord :: Test
testSingleWord = TestCase
    (assertEqual "Test failed"
        (wordcountMapFromList $ normalizeInputStr "scared")
        (M.fromList [("scared", 1)]))
testDuplicates :: Test
testDuplicates = TestCase
    (assertEqual "Test failed"
        (wordcountMapFromList $ normalizeInputStr "orange orange blue aqua blue green red teal")
        (M.fromList [("orange", 2), ("blue", 2), ("green", 1), ("red", 1), ("teal", 1), ("aqua", 1)]))
testCapitalizedWordsShouldBeLowercased :: Test
testCapitalizedWordsShouldBeLowercased = TestCase
    (assertEqual "Test failed"
        (wordcountMapFromList $ normalizeInputStr "Orange orange bLuE Aqua blue grEEn REd teAL")
        (M.fromList [("orange", 2), ("blue", 2), ("green", 1), ("red", 1), ("teal", 1), ("aqua", 1)]))
testNonAlphaCharsShouldBeRemoved :: Test
testNonAlphaCharsShouldBeRemoved = TestCase
    (assertEqual "Test failed"
          (wordcountMapFromList $ normalizeInputStr "Orange!@ orange @#blue aqu)(a b!^lue green+_ r*ed t!eal")
          (M.fromList [("orange", 2), ("blue", 2), ("green", 1), ("red", 1), ("teal", 1), ("aqua", 1)]))

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
