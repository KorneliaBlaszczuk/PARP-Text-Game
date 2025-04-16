module Game.Actions.LocationActions
  ( handleLocationAction
  , goodEnding
  , badEnding
  ) where

import Game.State
import Game.Locations
import Game.Actions.CoreActions (Game)
import Control.Monad (when, unless)
import Control.Monad.State
import Control.Monad.IO.Class (liftIO)
import System.Exit
import System.Random

handleLocationAction :: Location -> String -> Game ()
handleLocationAction loc cmd = case (loc, cmd) of
  (Start, "rozpocznij_gre") -> do
    liftIO $ putStrLn "\nRozpoczynasz swoją przygodę..."
    modify (\s -> s { location = TarasPKiN })

  (TarasPKiN, "zajrzyj_do_kieszeni") -> do
    hasChecked <- gets hasCheckedPockets
    if not hasChecked
      then do
        modify (\s -> s { hasCheckedPockets = True })
        modify (addMoney 20)
        modify (addNote 1)
        liftIO $ putStrLn "Znalazłeś 20 zł i pierwszą notatkę w kieszeni!"
      else liftIO $ putStrLn "Już sprawdzałeś kieszenie."

  (TarasPKiN, "rozejrzyj_sie") ->
    liftIO $ putStrLn "Widzisz panoramę Warszawy. W oddali widać Wisłę i Stadion Narodowy."

  (TarasPKiN, "zejdz_po_schodach") -> do
    liftIO $ putStrLn "Schodzisz powoli schodami, trzymając się poręczy..."
    modify (\s -> s { location = SchodyPKiN })

  (SchodyPKiN, "podnies_pieniadze") -> do
    hasPicked <- gets hasPickedUpItems
    if not hasPicked
      then do
        amount <- liftIO $ randomRIO (5, 15)
        modify (\s -> s { hasPickedUpItems = True })
        modify (addMoney amount)
        liftIO $ putStrLn $ "Znalazłeś " ++ show amount ++ " zł na schodach!"
      else liftIO $ putStrLn "Nie ma tu już nic więcej."

  (SchodyPKiN, "idz_dalej") -> do
    liftIO $ putStrLn "Schodzisz dalej w dół..."
    modify (\s -> s { location = HolPKiN })

  (HolPKiN, "porozmawiaj_z_portierem") ->
    liftIO $ putStrLn "Portier patrzy na ciebie zmęczonym wzrokiem: 'Proszę się nie zatrzymywać, przejść dalej'"

  (HolPKiN, "wyjdz_na_zewnatrz") -> do
    liftIO $ putStrLn "Wychodzisz na świeże powietrze..."
    modify (\s -> s { knowsAboutHalaKoszyki = True })
    modify (\s -> s { location = PrzedPKiN })

  (PrzedPKiN, "idz_w_strone_parku") -> do
    liftIO $ putStrLn "Idziesz w kierunku parku..."
    modify (\s -> s { knowsAboutPark = True })
    modify (\s -> s { location = Park })

  (PrzedPKiN, "idz_w_strone_taksowki") -> do
    money <- gets money
    if money >= 20
      then do
        liftIO $ putStrLn "Wsiadasz do taksówki..."
        modify (\s -> s { location = Taksowka })
      else liftIO $ putStrLn "Nie stać cię na taksówkę (potrzebujesz 20 zł)"

  (Park, "obejrzyj_fontanne") -> do
    hasSeen <- gets hasSeenFountain
    if not hasSeen
      then do
        amount <- liftIO $ randomRIO (2, 10)
        modify (\s -> s { hasSeenFountain = True })
        modify (addMoney amount)
        liftIO $ putStrLn $ "Znalazłeś " ++ show amount ++ " zł w fontannie!"
      else liftIO $ putStrLn "Fontanna wygląda tak samo jak przedtem."

  (Taksowka, "pojedz_do_hali_koszyki") -> do
    liftIO $ putStrLn "Kierowca wiezie cię do Hali Koszyki..."
    modify (subtractMoney 20)
    modify (\s -> s { location = HalaKoszyki })

  (HalaKoszyki, "podejdz_do_baru") -> do
    hasApproached <- gets hasApproachedBar
    if not hasApproached
      then do
        modify (\s -> s { hasApproachedBar = True })
        modify (addNote 2)
        liftIO $ putStrLn "Barman wręcza ci drugą część notatki!"
      else liftIO $ putStrLn "Barman zajmuje się innymi klientami"

  (GGPW, "otworz_sale_glowna") -> do
    hasKey <- gets hasKey
    if hasKey
      then do
        liftIO $ putStrLn "Używasz klucza aby otworzyć salę..."
        modify (\s -> s { location = GlownaSala })
      else liftIO $ putStrLn "Nie masz klucza do sali!"

  (GlownaSala, "podejdz_do_profesora") -> do
    notes <- gets notes
    if length notes >= 4
      then goodEnding
      else badEnding

  _ -> liftIO $ putStrLn "Nie można wykonać tej akcji w tej lokalizacji."

goodEnding :: Game ()
goodEnding = do
  counter <- gets interactionCounter
  let grade = 3.0 + 0.5 * fromIntegral counter
  liftIO $ do
    putStrLn "\n=== DOBRE ZAKOŃCZENIE ==="
    putStrLn $ "Otrzymujesz ocenę: " ++ show grade ++ "!"
  liftIO exitSuccess

badEnding :: Game ()
badEnding = do
  liftIO $ putStrLn "\n=== ZŁE ZAKOŃCZENIE ==="
  liftIO exitSuccess

addMoney :: Int -> GameState -> GameState
addMoney amount s = s { money = money s + amount }

subtractMoney :: Int -> GameState -> GameState
subtractMoney amount s = s { money = money s - amount }

addNote :: Int -> GameState -> GameState
addNote noteId s = s { notes = noteId : notes s }