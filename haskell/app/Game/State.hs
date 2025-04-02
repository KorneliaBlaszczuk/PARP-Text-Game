module Game.State
  ( GameState(..)
  , initialState
  , Location(..)
  ) where

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