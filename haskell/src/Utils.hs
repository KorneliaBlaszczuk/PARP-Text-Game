module Utils where

import Game.States
import Game.Core
import Game.Locations
import Control.Monad.State
import System.IO
import Data.List (intercalate)

-- Funkcja czyszcząca ekran (działa na większości systemów)
clearScreen :: IO ()
clearScreen = do
    putStr "\ESC[2J"  -- ANSI escape code do czyszczenia ekranu
    hFlush stdout

-- Wyświetla aktualną lokalizację i jej opis
printLocationInfo :: Game ()
printLocationInfo = do
    currentLoc <- gets location
    liftIO $ putStrLn $ "\n== " ++ show currentLoc ++ " =="
    liftIO $ putStrLn $ locationDescription currentLoc

-- Formatuje listę przedmiotów w czytelny sposób
formatItems :: [String] -> String
formatItems [] = "Brak przedmiotów"
formatItems items = intercalate ", " items

-- Wyświetla stan ekwipunku
showInventory :: Game ()
showInventory = do
    money <- gets money
    notes <- gets notes
    hasKey <- gets hasKey
    putStrLn "\n=== EKWIPUNEK ==="
    putStrLn $ "Pieniądze: " ++ show money ++ " zł"
    putStrLn $ "Notatki: " ++ show (length notes) ++ "/4"
    putStrLn $ "Klucz: " ++ if hasKey then "Tak" else "Nie"

-- Funkcja pomocnicza do walidacji wejścia
validateInput :: [String] -> String -> Game Bool
validateInput validCommands input = do
    if input `elem` validCommands
        then return True
        else do
            putStrLn $ "Nieprawidłowa komenda. Dostępne opcje: " ++ intercalate ", " validCommands
            return False

-- Wyświetla dostępne akcje w aktualnej lokalizacji
printAvailableActions :: Game ()
printAvailableActions = do
    loc <- gets location
    case loc of
        TarasPKiN -> showActions ["zajrzyj_do_kieszeni", "rozejrzyj_sie", "zejdz_po_schodach"]
        SchodyPKiN -> showActions ["podnies_pieniadze", "idz_dalej"]
        HolPKiN -> showActions ["porozmawiaj_z_portierem", "wyjdz_na_zewnatrz"]
        -- ... inne lokalizacje
        _ -> putStrLn "Brak dostępnych akcji."
    where
        showActions actions = do
            putStrLn "\nDostępne akcje:"
            mapM_ (putStrLn . ("- " ++)) actions

-- Funkcja do debugowania - wyświetla cały stan gry
debugState :: Game ()
debugState = do
    state <- get
    liftIO $ do
        putStrLn "\n=== DEBUG ==="
        putStrLn $ "Lokalizacja: " ++ show (location state)
        putStrLn $ "Pieniądze: " ++ show (money state)
        putStrLn $ "Notatki: " ++ show (notes state)
        putStrLn $ "Posiada klucz: " ++ show (hasKey state)
        putStrLn $ "Licznik interakcji: " ++ show (interactionCounter state)
        putStrLn "============="

-- Animowane ładowanie/pauza
loadingAnimation :: String -> Int -> IO ()
loadingAnimation message seconds = do
    putStr message
    hFlush stdout
    mapM_ (\_ -> do
            threadDelay 250000
            putStr "."
            hFlush stdout) [1..seconds*4]
    putStrLn ""

-- Konwersja nazwy akcji do formy używanej w systemie
normalizeAction :: String -> String
normalizeAction = map toLower . filter (/= ' ')