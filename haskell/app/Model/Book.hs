module Model.Book where

import Modules.UtilModule (splitBy)

data Book = Book
  { num :: Int,
    name :: String,
    author :: String,
    genre :: String,
    link :: String
  }
  deriving (Eq)

instance Show Book where
  show (Book num n a g l) = show num ++ ";" ++ n ++ ";" ++ a ++ ";" ++ g ++ ";" ++ l

instance Read Book where
  readsPrec _ str = [(strToBook str, "")]

bookToNumName :: Book -> String
bookToNumName b = show (num b) ++ " - " ++ name b ++ "\n"

strToBook :: String -> Book
strToBook userStr = do
  let attList = splitBy ';' userStr

  let num = read (head attList) :: Int
  let n = attList !! 1
  let a = attList !! 2
  let g = attList !! 3
  let l = read (attList !! 4)
  Book num n a g l

formatBook :: Book -> String
formatBook b = show (num b) ++ " - " ++ name b ++ " - " ++ author b ++ " (" ++ genre b ++ ")"
