module Game.State where

import qualified Data.Map as Map
import Data.List (intercalate)

-- Typ danych reprezentujący lokalizacje w grze
data Location = Start
              | TarasPKiN
              | SchodyPKiN
              | HolPKiN
              | SzatniaPKiN
              | PrzedPKiN
              | Park
              | Taksowka
              | Wilcza30
              | DomWilcza
              | HalaKoszyki
              | Chinczyk
              | EITI
              | GGPW
              | GlownaSala
              deriving (Eq, Show, Enum, Bounded)

-- Główny typ stanu gry
data GameState = GameState
  { location :: Location
  , money :: Int
  , notes :: [Int]
  , hasNumber :: Bool
  , knowsAboutWilcza :: Bool
  , knowsAboutHalaKoszyki :: Bool
  , knowsAboutPark :: Bool
  , hasTalked :: Bool
  , knowsAboutEiti :: Bool
  , hasCheckedPockets :: Bool
  , hasPickedUpItems :: Bool
  , interactionCounter :: Int
  , knowsAboutMissingKey :: Bool
  , hasKey :: Bool
  , conversationCounter :: Int
  , hasFirstPartOfBrokenKey :: Bool
  , hasSecondPartOfBrokenKey :: Bool
  , hasSecretRoomKey :: Bool
  , hasCheckedCloakroom :: Bool
  , knowsAboutSemesterWork :: Bool
  , hasCheckedMainRoomPockets :: Bool
  , hasGreetedNoOne :: Bool
  , hasApproachedBar :: Bool
  , hasBoughtNoteOnWilcza :: Bool
  , hasSeenFountain :: Bool
  } deriving (Show)

-- Początkowy stan gry
initialState :: GameState
initialState = GameState
  { location = Start
  , money = 0
  , notes = []
  , hasNumber = False
  , knowsAboutWilcza = False
  , knowsAboutHalaKoszyki = False
  , knowsAboutPark = False
  , hasTalked = False
  , knowsAboutEiti = False
  , hasCheckedPockets = False
  , hasPickedUpItems = False
  , interactionCounter = 0
  , knowsAboutMissingKey = False
  , hasKey = False
  , conversationCounter = 0
  , hasFirstPartOfBrokenKey = False
  , hasSecondPartOfBrokenKey = False
  , hasSecretRoomKey = False
  , hasCheckedCloakroom = False
  , knowsAboutSemesterWork = False
  , hasCheckedMainRoomPockets = False
  , hasGreetedNoOne = False
  , hasApproachedBar = False
  , hasBoughtNoteOnWilcza = False
  , hasSeenFountain = False
  }

-- Funkcje pomocnicze do modyfikacji stanu

-- Dodaje pieniądze do stanu
addMoney :: Int -> GameState -> GameState
addMoney amount s = s { money = money s + amount }

-- Odejmuje pieniądze od stanu
subtractMoney :: Int -> GameState -> GameState
subtractMoney amount s = s { money = money s - amount }

-- Dodaje notatkę do stanu
addNote :: Int -> GameState -> GameState
addNote noteId s = s { notes = noteId : notes s }

-- Inkrementuje licznik interakcji
incrementInteractionCounter :: GameState -> GameState
incrementInteractionCounter s = s { interactionCounter = interactionCounter s + 1 }

-- Zmienia lokalizację
changeLocation :: Location -> GameState -> GameState
changeLocation newLoc s = s { location = newLoc }

-- Sprawdza czy gracz ma wszystkie notatki
hasAllNotes :: GameState -> Bool
hasAllNotes s = length (notes s) >= 4

-- Pokazuje stan notatek
showNotesStatus :: GameState -> String
showNotesStatus s =
  let numNotes = length (notes s)
      missing = 4 - numNotes
  in if numNotes == 0
     then "Nie masz jeszcze żadnych notatek."
     else "Masz " ++ show numNotes ++ "/4 notatek. " ++
          if missing > 0
          then "Brakuje jeszcze " ++ show missing ++ "."
          else "Masz już wszystkie notatki!"

-- Pokazuje stan portfela
showWalletStatus :: GameState -> String
showWalletStatus s = "Stan portfela: " ++ show (money s) ++ " zł"

-- Funkcja pomocnicza do debugowania - pokazuje cały stan
debugState :: GameState -> String
debugState s =
  intercalate "\n" $
    [ "--- Stan gry ---"
    , "Lokalizacja: " ++ show (location s)
    , showWalletStatus s
    , showNotesStatus s
    , "Posiada klucz: " ++ show (hasKey s)
    , "Posiada części klucza: " ++ show (hasFirstPartOfBrokenKey s) ++ ", " ++ show (hasSecondPartOfBrokenKey s)
    , "Licznik interakcji: " ++ show (interactionCounter s)
    , "--- Koniec stanu ---"
    ]