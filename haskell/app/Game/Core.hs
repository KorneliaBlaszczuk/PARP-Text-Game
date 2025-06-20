module Game.Core
  ( startGame,
  Game
  ) where

import Game.State
import Game.Locations
import Game.Actions.CoreActions
import Game.Actions.LocationActions
import Control.Monad.State
import System.IO
import Control.Monad (void)

startGame :: IO ()
startGame = do
  putStrLn "DEBUG: Rozpoczynanie gry..."
  void $ execStateT gameLoop initialState

gameLoop :: Game ()
gameLoop = do
  loc <- gets location
  -- liftIO clearScreen
  -- liftIO $ printLocationInfo loc
  printAvailableActions

  liftIO $ putStr "\n> "
  liftIO $ hFlush stdout
  input <- liftIO getLine

  handleBasicAction input
  handleLocationAction loc input
  gameLoop


clearScreen :: IO ()
clearScreen = putStr "\ESC[2J"