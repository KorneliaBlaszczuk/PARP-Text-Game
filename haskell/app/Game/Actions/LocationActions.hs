module Game.Actions.LocationActions
  ( handleLocationAction
  , goodEnding
  , badEnding
  ) where

import Game.State
import Game.Locations
import Game.Actions.CoreActions (Game)
import Control.Monad.State
import System.IO
import System.Exit
import System.Random

handleLocationAction :: Location -> String -> Game ()
handleLocationAction loc cmd = case (loc, cmd) of
  (Start, "rozpocznij_gre") -> do
    liftIO $ putStrLn "\nRozpoczynasz swoją przygodę..."
    modify (\s -> s { location = TarasPKiN })
    loc <- gets location
    liftIO $ printLocationInfo loc

  (TarasPKiN, "zajrzyj_do_kieszeni") -> do
    hasChecked <- gets hasCheckedPockets
    if not hasChecked
      then do
        modify (\s -> s { hasCheckedPockets = True })
        modify (addMoney 20)
        modify (addNote 1)
        liftIO $ putStrLn "Sięgasz do kieszeni i znajdujesz 20 zł oraz notatkę."
      else liftIO $ putStrLn "Już zajrzałeś do kieszeni, nic tam więcej nie ma."

  (TarasPKiN, "rozejrzyj_sie") ->
    liftIO $ putStrLn "Widzisz panoramę miasta. Słońce wschodzi nad Warszawą."

  (TarasPKiN, "podejdz_do_krawedzi") -> do
    liftIO $ putStrLn "Podchodzisz do krawędzi i odczuwasz lekki zawrót głowy."

  (TarasPKiN, "zejdz_po_schodach") -> do
    liftIO $ putStrLn "Schodzisz schodami PKiN."
    modify (\s -> s { location = SchodyPKiN })
    loc <- gets location
    liftIO $ printLocationInfo loc

  (TarasPKiN, "uzyj_windy") -> do
    liftIO $ putStrLn "Zjeżdzasz windą prosto na dół do holu PKiN."
    modify (\s -> s { location = HolPKiN })
    loc <- gets location
    liftIO $ printLocationInfo loc

  (SchodyPKiN, "podnies_pieniadze") -> do
    hasPicked <- gets hasPickedUpItems
    if not hasPicked
      then do
        amount <- liftIO $ randomRIO (5, 15)
        modify (\s -> s { hasPickedUpItems = True })
        modify (addMoney amount)
        liftIO $ putStrLn $ "Znalazłeś " ++ show amount ++ " zł na schodach!"
      else liftIO $ putStrLn "Nic tutaj już nie ma."

  (SchodyPKiN, "idz_dalej") -> do
    liftIO $ putStrLn "Schodzisz schodami do holu PKiN."
    modify (\s -> s { location = HolPKiN })
    loc <- gets location
    liftIO $ printLocationInfo loc

  (HolPKiN, "porozmawiaj_z_portierem") ->
    liftIO $ putStrLn "Portier patrzy na ciebie podejrzliwie, ale nic nie mówi."

  (HolPKiN, "wyjdz_na_zewnatrz") -> do
    liftIO $ putStrLn "Wychodzisz na zewnątrz, przed PKiN."
    liftIO $ putStrLn "Wychodząc zaczepia cię dziwny chłopak, który mówi: 'O hej brachu, pamiętasz co się działo wczoraj w Hali Koszyki?'"
    modify (\s -> s { knowsAboutHalaKoszyki = True })
    modify (\s -> s { location = PrzedPKiN })
    loc <- gets location
    liftIO $ printLocationInfo loc

  (HolPKiN, "udaj_sie_do_szatni") -> do
    liftIO $ putStrLn "Idziesz do szatni."
    modify (\s -> s { location = SzatniaPKiN })
    loc <- gets location
    liftIO $ printLocationInfo loc

  (SzatniaPKiN, "wyjdz_na_zewnatrz") -> do
    liftIO $ putStrLn "Wychodzisz z PKiN."
    liftIO $ putStrLn "Wychodząc zaczepia cię dziwny chłopak, który mówi: 'O hej brachu, pamiętasz co się działo wczoraj w Hali Koszyki?'"
    modify (\s -> s { knowsAboutHalaKoszyki = True })
    modify (\s -> s { location = PrzedPKiN })
    loc <- gets location
    liftIO $ printLocationInfo loc

  (SzatniaPKiN, "przeszukaj_kieszenie") -> do
    liftIO $ putStrLn "Warto było przeszukać kieszenie jeszce raz. Znajdujesz numerek."
    modify (\s -> s { hasNumber = True })

  (SzatniaPKiN, "przeszukaj_plaszcz") -> do
    state <- get
    if hasNumber state
      then do
        liftIO $ putStrLn "Znajdujesz ulotkę z ofertą Happy Hours z baru w Hali Koszyki."
      else liftIO $ putStrLn "Nie masz numerka, więc nie wiesz, który płaszcz należy do ciebie."

  (PrzedPKiN, "idz_w_strone_parku") -> do
    state <- get
    if wasAtPark state
      then
        liftIO $ putStrLn "Odwiedziłeś już park, nie masz ochoty znowu tam wracać..."
    else do
        liftIO $ putStrLn "Idziesz w stronę parku."
        modify (\s -> s { wasAtPark = True })
        modify (\s -> s { location = Park })
        loc <- gets location
        liftIO $ printLocationInfo loc

  (PrzedPKiN, "idz_w_strone_taksowki") -> do
    money <- gets money
    if money >= 20
      then do
        liftIO $ putStrLn "Wsiadasz do taksówki."
        modify (\s -> s { location = Taksowka })
        loc <- gets location
        liftIO $ printLocationInfo loc
      else liftIO $ putStrLn "Nie masz wystarczającej ilości pieniędzy, aby skorzystać z taksówki."

  (PrzedPKiN, "spojrz_na_ulotke") -> do
    liftIO $ putStrLn "Znajdujesz ulotkę z baru w Hali Koszyki z reklamą Happy Hours. Może warto się dam udać?"

  (PrzedPKiN, "idz_do_hali_koszyki") -> do
    liftIO $ putStrLn "Postanawiasz pójść do Hali Koszyki spacerując, aby móc podziwiać budzącą się Warszawę."
    modify (\s -> s { location = HalaKoszyki })
    loc <- gets location
    liftIO $ printLocationInfo loc

  (PrzedPKiN, "idz_na_wilcza_30") -> do
    liftIO $ putStrLn "Postanawiasz pójść na Wilczą 30 spacerując, aby móc podziwiać budzącą się Warszawę."
    modify (\s -> s { location = Wilcza30 })
    loc <- gets location
    liftIO $ printLocationInfo loc

  (Park, "usiadz_na_lawce") -> do
    liftIO $ putStrLn "Siadasz na zimnej, metalowej ławce. Chłód poranka powoli przenika przez materiał twojego ubrania."
    liftIO $ putStrLn "Przymykasz oczy na chwilę i wsłuchujesz się w dźwięki miasta. Czujesz chwilowy spokój. Może nawet zbyt wielki."
    liftIO $ putStrLn "Jakby świat na moment się zatrzymał, pozwalając ci złapać oddech przed kolejnym krokiem."

  (Park, "karm_golebie") -> do
    money <- gets money
    if money >= 5
      then do
        liftIO $ putStrLn "Kupujesz nasiona i karmisz gołębie. Jeden z nich wygląda znajomo... To ten, który dziabnął cię na tarasie!"
        modify (subtractMoney 5)
    else liftIO $ putStrLn "Nie masz wystarczająco pieniędzy, aby kupić chleb dla gołębi."

  (Park, "obejrzyj_fontanne") -> do
    hasSeen <- gets hasSeenFountain
    if not hasSeen
      then do
        amount <- liftIO $ randomRIO (2, 10)
        modify (\s -> s { hasSeenFountain = True })
        modify (addMoney amount)
        liftIO $ putStrLn $ "Znalazłeś " ++ show amount ++ " zł w fontannie!"
      else liftIO $ putStrLn "Fontanna wygląda tak samo jak przedtem."

  (Park, "porozmawiaj_z_nieznajomym") -> do
    modify (\s -> s { knowsAboutWilcza = True })
    liftIO $ putStrLn "Witasz się z nieznajomym."
    liftIO $ putStrLn "'Dzień dobry! Co u Pana słychać?' - pyta się ciebie nieznajomy z entuzjazmem"
    liftIO $ putStrLn "Równo entuzjastycznie odpowiadasz, że 'dobrze'... nawet jeśli pytanie nie brzmiało 'jak się czujesz', ale kto by się przejmował."
    liftIO $ putStrLn "Zaczynasz rozmowę z nieznajomym, aż... tracisz czucie czasu. Ile rozmawialiście? Nie wiesz."
    liftIO $ putStrLn "'Ja muszę proszę Pana jeszcze na autobus zdążyć, ale miło się z Panem rozmawiało!' - nieznajomy żegna się z tobą: znowu entuzjastycznie!"
    liftIO $ putStrLn "'I niech Pan pamięta o Wilczej 30! Warto tam zajrzeć!'"
    liftIO $ putStrLn "??? Może o czymś wspomniałeś podczas rozmowy, co by skutkowały w takiej prośbie, ale tego nie pamiętasz"
    liftIO $ putStrLn "Masz wrażenie, że coś wyniosłeś z tej konwersacji, aczkolwiek nie wiesz do końca co."
    modify (\s -> s { conversationCounter = conversationCounter s + 1 })

  -- w Prologu są dwie interakcje z gadaniem

  (Park, "idz_przed_pkin") -> do
    liftIO $ putStrLn "Wracasz przed PKiN"
    modify (\s -> s { location = PrzedPKiN })
    loc <- gets location
    liftIO $ printLocationInfo loc


  (Taksowka, "pojedz_do_hali_koszyki") -> do
    liftIO $ putStrLn "Kierowca wiezie cię do Hali Koszyki..."
    modify (subtractMoney 20)
    modify (\s -> s { location = HalaKoszyki })
    loc <- gets location
    liftIO $ printLocationInfo loc

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
        loc <- gets location
        liftIO $ printLocationInfo loc
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

printLocationInfo :: Location -> IO ()
printLocationInfo loc = do
  putStrLn $ "\n== " ++ show loc ++ " =="
  putStrLn $ locationDescription loc
