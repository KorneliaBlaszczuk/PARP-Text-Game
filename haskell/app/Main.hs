module Main where

import Game.Core
import Game.State
import Game.Actions
import System.IO
import System.Exit

main :: IO ()
main = do
    putStrLn "Witaj w grze!"
    putStrLn "Aby wykonać działanie, wpisz nazwę akcji (np. 'zajrzyj_do_kieszeni')"
    putStrLn "Aby sprawdzić stan notatek, wpisz 'sprawdz(stan_notatek)'"
    putStrLn "Aby zakończyć grę, wpisz 'quit'"
    putStrLn ""

    evalStateT gameLoop initialState