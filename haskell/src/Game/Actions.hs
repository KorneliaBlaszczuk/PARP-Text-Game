module Game.Actions where

import Game.State
import Game.Locations
import Game.Core
import Control.Monad.State
import System.Random
import System.IO
import Data.List (intercalate)
import qualified Data.Map as Map

-- Mapa dostępnych akcji dla każdej lokalizacji
locationActions :: Map.Map Location [String]
locationActions = Map.fromList [
  (TarasPKiN, ["zajrzyj_do_kieszeni", "rozejrzyj_sie", "podejdz_do_krawedzi", "zejdz_po_schodach", "uzyj_windy"]),
  (SchodyPKiN, ["podnies_pieniadze", "idz_dalej"]),
  (HolPKiN, ["porozmawiaj_z_portierem", "wyjdz_na_zewnatrz", "udaj_sie_do_szatni"]),
  (SzatniaPKiN, ["wyjdz_na_zewnatrz", "przeszukaj_kieszenie", "przeszukaj_plaszcz"]),
  (PrzedPKiN, ["idz_w_strone_parku", "idz_w_strone_taksowki", "spojrz_na_ulotke", "idz_do_hali_koszyki", "idz_na_wilcza_30"]),
  (Park, ["usiadz_na_lawce", "karm_golebie", "obejrzyj_fontanne", "porozmawiaj_z_nieznajomym", "idz_przed_pkin"]),
  (Taksowka, ["porozmawiaj", "pojedz_do_hali_koszyki", "pojedz_na_wilcza_30"]),
  (Wilcza30, ["zapukaj_do_drzwi", "rozejrzyj_sie", "idz_do_hali_koszyki"]),
  (DomWilcza, ["wykup_notatke", "opusc_dom"]),
  (HalaKoszyki, ["podejdz_do_baru", "porozmawiaj_z_gosciem", "wyjdz_w_strone_chinczyka"]),
  (Chinczyk, ["porozmawiaj_z_wlascicielem", "kup_cos", "idz_do_gg_pw", "idz_na_weiti"]),
  (EITI, ["zajrzyj_do_laboratorium", "zajrzyj_do_szatni", "idz_do_gg_pw"]),
  (GGPW, ["pogadaj_z_kims", "sprawdz_tablice_ogloszen", "sprawdz_portiernie", "przeszukaj_teren", "otworz_sale_glowna"]),
  (GlownaSala, ["sprawdz_kieszenie", "wyjdz_z_sali", "podejdz_do_profesora"])
  ]

-- Główna funkcja obsługi akcji
handleAction :: String -> Game ()
handleAction action = do
  loc <- gets location
  case (loc, action) of
    -- Taras PKiN
    (TarasPKiN, "zajrzyj_do_kieszeni") -> do
      hasChecked <- gets hasCheckedPockets
      if not hasChecked
        then do
          modify (\s -> s { hasCheckedPockets = True })
          modify (addMoney 20)
          modify (addNote 1)
          putStrLn "Znalazłeś 20 zł i pierwszą notatkę w kieszeni!"
        else putStrLn "Już sprawdzałeś kieszenie."

    (TarasPKiN, "rozejrzyj_sie") ->
      putStrLn "Widzisz panoramę Warszawy. W oddali widać Wisłę i Stadion Narodowy."

    (TarasPKiN, "zejdz_po_schodach") -> do
      putStrLn "Schodzisz powoli schodami, trzymając się poręczy..."
      modify (changeLocation SchodyPKiN)
      gets (locationDescription . location) >>= putStrLn

    -- Schody PKiN
    (SchodyPKiN, "podnies_pieniadze") -> do
      hasPicked <- gets hasPickedUpItems
      if not hasPicked
        then do
          amount <- liftIO $ randomRIO (5, 15)
          modify (\s -> s { hasPickedUpItems = True })
          modify (addMoney amount)
          putStrLn $ "Znalazłeś " ++ show amount ++ " zł na schodach!"
        else putStrLn "Nie ma tu już nic więcej."

    (SchodyPKiN, "idz_dalej") -> do
      putStrLn "Schodzisz dalej w dół..."
      modify (changeLocation HolPKiN)
      gets (locationDescription . location) >>= putStrLn

    -- Hol PKiN
    (HolPKiN, "porozmawiaj_z_portierem") -> do
      putStrLn "Portier patrzy na ciebie zmęczonym wzrokiem:"
      putStrLn "'Proszę się nie zatrzymywać, przejść dalej'"

    (HolPKiN, "wyjdz_na_zewnatrz") -> do
      putStrLn "Wychodzisz na świeże powietrze..."
      modify (\s -> s { knowsAboutHalaKoszyki = True })
      modify (changeLocation PrzedPKiN)
      gets (locationDescription . location) >>= putStrLn

    -- Przed PKiN
    (PrzedPKiN, "idz_w_strone_parku") -> do
      putStrLn "Idziesz w kierunku parku..."
      modify (\s -> s { knowsAboutPark = True })
      modify (changeLocation Park)
      gets (locationDescription . location) >>= putStrLn

    (PrzedPKiN, "idz_w_strone_taksowki") -> do
      money <- gets money
      if money >= 20
        then do
          putStrLn "Wsiadasz do taksówki..."
          modify (changeLocation Taksowka)
          gets (locationDescription . location) >>= putStrLn
        else putStrLn "Nie stać cię na taksówkę (potrzebujesz 20 zł)"

    -- Park
    (Park, "obejrzyj_fontanne") -> do
      hasSeen <- gets hasSeenFountain
      if not hasSeen
        then do
          amount <- liftIO $ randomRIO (2, 10)
          modify (\s -> s { hasSeenFountain = True })
          modify (addMoney amount)
          putStrLn $ "Znalazłeś " ++ show amount ++ " zł w fontannie!"
        else putStrLn "Fontanna wygląda tak samo jak przedtem."

    -- Taksówka
    (Taksowka, "pojedz_do_hali_koszyki") -> do
      putStrLn "Kierowca wiezie cię do Hali Koszyki..."
      modify (subtractMoney 20)
      modify (changeLocation HalaKoszyki)
      gets (locationDescription . location) >>= putStrLn

    -- Hala Koszyki
    (HalaKoszyki, "podejdz_do_baru") -> do
      hasApproached <- gets hasApproachedBar
      if not hasApproached
        then do
          modify (\s -> s { hasApproachedBar = True })
          modify (addNote 2)
          putStrLn "Barman wręcza ci drugą część notatki!"
        else putStrLn "Barman zajmuje się innymi klientami"

    -- GGPW
    (GGPW, "otworz_sale_glowna") -> do
      hasKey <- gets hasKey
      if hasKey
        then do
          putStrLn "Używasz klucza aby otworzyć salę..."
          modify (changeLocation GlownaSala)
          gets (locationDescription . location) >>= putStrLn
        else putStrLn "Nie masz klucza do sali!"

    -- Główna Sala
    (GlownaSala, "podejdz_do_profesora") -> do
      notes <- gets notes
      if length notes >= 4
        then goodEnding
        else badEnding

    -- Domyślna akcja
    _ -> putStrLn "Nie rozumiem tej komendy"

-- Funkcje pomocnicze
printAvailableActions :: Game ()
printAvailableActions = do
  loc <- gets location
  case Map.lookup loc locationActions of
    Just actions -> do
      putStrLn "\nDostępne akcje:"
      mapM_ putStrLn actions
    Nothing -> putStrLn "\nBrak dostępnych akcji"
