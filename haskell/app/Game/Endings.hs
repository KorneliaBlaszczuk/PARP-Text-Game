module Game.Endings where

import Game.State
import Game.Core (Game)  -- Dodaj ten import
import Control.Monad.State
import System.Exit

goodEnding :: Game ()
goodEnding = do
  counter <- gets interactionCounter
  let grade = 3.0 + 0.5 * fromIntegral counter

  liftIO $ putStrLn "\n=== DOBRE ZAKOŃCZENIE ==="
  liftIO $ putStrLn "Profesor przegląda twoją pracę i kiwa głową z aprobatą."
  liftIO $ putStrLn $ "Otrzymujesz ocenę: " ++ show grade ++ "!"
  liftIO $ putStrLn "Gratulacje! Udało ci się ukończyć projekt."

  liftIO exitSuccess

badEnding :: Game ()
badEnding = do
  notesCount <- gets (length . notes)

  liftIO $ putStrLn "\n=== ZŁE ZAKOŃCZENIE ==="
  liftIO $ putStrLn "Profesor kręci głową widząc twoją niekompletną pracę."
  liftIO $ putStrLn $ "Miałeś tylko " ++ show notesCount ++ "/4 notatek."
  liftIO $ putStrLn "Niestety, nie zaliczasz przedmiotu."

  liftIO exitSuccess