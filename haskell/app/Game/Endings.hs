module Game.Endings where

import Game.State
import Game.Core (Game)  -- Dodaj ten import
import Control.Monad.State
import System.Exit

goodEnding :: Game ()
goodEnding = do
  counter <- gets interactionCounter
  let grade = 3.0 + 0.5 * fromIntegral counter

  putStrLn "\n=== DOBRE ZAKOŃCZENIE ==="
  putStrLn "Profesor przegląda twoją pracę i kiwa głową z aprobatą."
  putStrLn $ "Otrzymujesz ocenę: " ++ show grade ++ "!"
  putStrLn "Gratulacje! Udało ci się ukończyć projekt."

  liftIO exitSuccess

badEnding :: Game ()
badEnding = do
  notesCount <- gets (length . notes)

  putStrLn "\n=== ZŁE ZAKOŃCZENIE ==="
  putStrLn "Profesor kręci głową widząc twoją niekompletną pracę."
  putStrLn $ "Miałeś tylko " ++ show notesCount ++ "/4 notatek."
  putStrLn "Niestety, nie zaliczasz przedmiotu."

  liftIO exitSuccess