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

searchDeanOffice :: Game ()
searchCorridors :: Game ()
searchRooms :: Game ()
searchStairs :: Game ()

handleLocationAction :: Location -> String -> Game ()
handleLocationAction loc cmd = case (loc, cmd) of

  -- Ekran startowy gry

  (Start, "rozpocznij_gre") -> do
    liftIO $ putStrLn "\nRozpoczynasz swoją przygodę..."
    modify (\s -> s { location = TarasPKiN })
    loc <- gets location
    liftIO $ printLocationInfo loc

  -- Taras PKiN

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

  -- Schody PKiN

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

  -- Hol PKiN

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

  -- Szatnia PKiN

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

  -- Przed PKiN

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
    wilczaInfo <- gets knowsAboutWilcza
    if wilczaInfo
      then do
        liftIO $ putStrLn "Postanawiasz pójść na Wilczą 30 spacerując, aby móc podziwiać budzącą się Warszawę."
        modify (\s -> s { location = Wilcza30 })
        loc <- gets location
        liftIO $ printLocationInfo loc
      else liftIO $ putStrLn "Nie można wykonać tej akcji w tej lokalizacji."

  -- Park

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
    wilczaInfo <- gets knowsAboutWilcza
    if not wilczaInfo
      then do
        modify (\s -> s { knowsAboutWilcza = True })
        liftIO $ putStrLn "Witasz się z nieznajomym."
        liftIO $ putStrLn "'Dzień dobry! Co u Pana słychać?' - pyta się ciebie nieznajomy z entuzjazmem"
        liftIO $ putStrLn "Równo entuzjastycznie odpowiadasz, że 'dobrze'... nawet jeśli pytanie nie brzmiało 'jak się czujesz', ale kto by się przejmował."
        liftIO $ putStrLn "Zaczynasz rozmowę z nieznajomym, aż... tracisz czucie czasu. Ile rozmawialiście? Nie wiesz."
        liftIO $ putStrLn "'Ja muszę proszę Pana jeszcze na autobus zdążyć, ale miło się z Panem rozmawiało!' - nieznajomy żegna się z tobą: znowu entuzjastycznie!"
        liftIO $ putStrLn "'I niech Pan pamięta o Wilczej 30! Warto tam zajrzeć!'"
        liftIO $ putStrLn "??? Może o czymś wspomniałeś podczas rozmowy, co by skutkowały w takiej prośbie, ale tego nie pamiętasz"
        liftIO $ putStrLn "Masz wrażenie, że coś wyniosłeś z tej konwersacji, aczkolwiek nie wiesz do końca co."
        modify (\s -> s { interactionCounter = interactionCounter s + 1 })
      else do
        greet <- gets hasGreetedNoOne
        liftIO $ putStrLn "Witasz się z nieznajomym. Entuzjastycznie machasz do niego."
        if not greet
          then do
            modify (\s -> s { hasGreetedNoOne = True })
          else liftIO $ putStrLn "Czy wszystko dobrze?"

  -- w Prologu są dwie interakcje z gadaniem

  -- do komentarza: druga interakcja występowała w Prologu kiedy przynajmniej raz gadaliśmy z nieznajomym i spróbowaliśmy jeszcze raz
  -- zamysł był taki, że za drugim podejściem do rozmowy witasz się w zasadzie z osobą, która odeszła po rozmowie i której już nie ma

  (Park, "idz_przed_pkin") -> do
    liftIO $ putStrLn "Wracasz przed PKiN"
    modify (\s -> s { location = PrzedPKiN })
    loc <- gets location
    liftIO $ printLocationInfo loc

  -- Taksowka

  (Taksowka, "pojedz_do_hali_koszyki") -> do
    liftIO $ putStrLn "Kierowca wiezie cię do Hali Koszyki..."
    modify (subtractMoney 20)
    modify (\s -> s { location = HalaKoszyki })
    loc <- gets location
    liftIO $ printLocationInfo loc

  (Taksowka, "porozmawiaj") -> do
    liftIO $ putStrLn "Kierowca mówi: 'Ciężka noc, co? Wyglądasz jakoś tak wczorajszo. Zdecydowanie wczoraj poimprezowałeś.'"

  (Taksowka, "pojedz_na_wilcza_30") -> do
    wilczaInfo <- gets knowsAboutWilcza
    if wilczaInfo
      then do
        liftIO $ putStrLn "Jedziesz na Wilczą 30."
        modify (subtractMoney 20)
        modify (\s -> s { location = Wilcza30 })
        loc <- gets location
        liftIO $ printLocationInfo loc
      else liftIO $ putStrLn "Nie można wykonać tej akcji w tej lokalizacji."

  -- Wilcza 30

  (Wilcza30, "zapukaj_do_drzwi") -> do
    liftIO $ putStrLn "Otwiera ci nieznana osoba. 'Czekałem na ciebie.'"
    modify (\s -> s { location = DomWilcza })
    loc <- gets location
    liftIO $ printLocationInfo loc

  (Wilcza30, "rozejrzyj_sie") -> do
    liftIO $ putStrLn "Wilcza 30. Stara kamienica z odrapanym numerem nad wejściem."
    liftIO $ putStrLn "Drzwi noszą ślady zużycia, jakby ktoś niedawno próbował je sforsować."
    liftIO $ putStrLn "W środku czuć wilgoć, kurz i zapach tanich papierosów."
    liftIO $ putStrLn "Na skrzynkach pocztowych nazwiska lokatorów, ale jedno miejsce jest puste."

  (Wilcza30, "idz_do_hali_koszyki") -> do
    liftIO $ putStrLn "Opuszczasz Wilczą 30 i idziesz w strone Hali Koszyki."
    modify (\s -> s { location = HalaKoszyki })
    loc <- gets location
    liftIO $ printLocationInfo loc

  -- Wilcza 30 - środek domu

  (DomWilcza, "wykup_notatke") -> do
    wilczaNote <- gets hasBoughtNoteOnWilcza
    money <- gets money
    if wilczaNote
      then liftIO $ putStrLn "Osoba nie ma nic więcej do sprzedania tobie. Po co mówiła tobie że coś ma?"
      else do
        if money >= 10
          then do
            liftIO $ putStrLn "Ciekawość wzieła górę i wykupiłeś ten kawałek papieru."
            modify (\s -> s { hasBoughtNoteOnWilcza = True })
            modify (subtractMoney 10)
            modify (addNote 3)
            modify (\s -> s { location = Wilcza30 })
            loc <- gets location
            liftIO $ printLocationInfo loc
          else liftIO $ putStrLn "Kwota, o którą prosi cię mężczyzna jest zdecydowanie za wysoka. Może jeszcze tu wrócę..."

  (DomWilcza, "opusc_dom") -> do
    liftIO $ putStrLn "Postanowiłeś opuścić dom mężczyzny. Co jeszcze cię czeka?"
    modify (\s -> s { location = Wilcza30 })
    loc <- gets location
    liftIO $ printLocationInfo loc

  -- Hala Koszyki

  (HalaKoszyki, "podejdz_do_baru") -> do
    hasApproached <- gets hasApproachedBar
    if not hasApproached
      then do
        modify (\s -> s { hasApproachedBar = True })
        modify (addNote 2)
        liftIO $ putStrLn "Barman rozpoznaje cię i mówi, że wczoraj zostawiłeś coś ważnego."
        liftIO $ putStrLn "Barman wręcza ci drugą część notatki!"
      else liftIO $ putStrLn "Barman zajmuje się innymi klientami"

  (HalaKoszyki, "porozmawiaj_z_gosciem") -> do
    liftIO $ putStrLn "Tajemniczy rozmówca wspomina o dziwnym incydencie, którego był świadkiem - ktoś potrącił cię szybko wychodząc."

  (HalaKoszyki, "wyjdz_w_strone_chinczyka") -> do
    liftIO $ putStrLn "Idziesz do chińskiej restauracji."
    modify (\s -> s { location = Chinczyk })
    loc <- gets location
    liftIO $ printLocationInfo loc

  -- Chińczyk

  (Chinczyk, "porozmawiaj_z_wlascicielem") -> do
    talkStatus <- gets hasTalked
    if not talkStatus
      then do
        liftIO $ putStrLn "Właściciel pamięta cię! Wspomina, że wczoraj zostawiłeś coś przy stoliku."
        liftIO $ putStrLn "Wskaże ci go jedynie, jeśli kupisz coś (10 zł), przecież za darmo nie możesz siedzieć w lokalu!"
        modify (\s -> s {hasTalked = True})
      else do
        liftIO $ putStrLn "Podchodzisz do właściciela jeszcze raz. Dalej cie pamięta."
        eitiStatus <- gets knowsAboutEiti
        if eitiStatus
          then liftIO $ putStrLn "Nic tobie nie wskazuje. Zaczynasz się zastanawiać co właściwie chcesz od właściciela."
          else liftIO $ putStrLn "Przypomina tobie o czymś przy stoliku. Jak coś kupisz (10 zł), to wskaże tobie ten tajemniczy przedmiot."

  (Chinczyk, "kup_cos") -> do
    talkStatus <- gets hasTalked
    if not talkStatus
      then liftIO $ putStrLn "Najpierw porozmawiaj z właścicielem."
      else do
        eitiStatus <- gets knowsAboutEiti
        if eitiStatus
          then liftIO $ putStrLn "Właściciel nie ma tobie nic ciekawego do sprzedania... no w sumie oprócz jedzenia."
          else do
            money <- gets money
            if money >= 10
              then do
                modify (subtractMoney 10)
                modify (\s -> s { knowsAboutEiti = True })
                liftIO $ putStrLn "Znajdujesz tajemniczą wiadomość „EITI” napisaną na odwrocie serwetki."
              else liftIO $ putStrLn "Nie masz tyle forsy! Musisz mieć 10 zł, aby kupić coś."

  (Chinczyk, "idz_do_gg_pw") -> do
    liftIO $ putStrLn "Idziesz do Gmachu Głównego PW."
    modify (\s -> s { location = GGPW })
    modify (\s -> s { hasPickedUpItems = False })
    loc <- gets location
    liftIO $ printLocationInfo loc

  (Chinczyk, "idz_na_weiti") -> do
    liftIO $ putStrLn "Idziesz na wydział EITI."
    modify (\s -> s { hasPickedUpItems = False })
    modify (\s -> s { location = EITI })
    loc <- gets location
    liftIO $ printLocationInfo loc

  -- EiTI

  (EITI, "zajrzyj_do_laboratorium") -> do
    itemStatus <- gets hasPickedUpItems
    if not itemStatus
      then do
        liftIO $ putStrLn "Wchodzisz do laboratorium i widzisz profesorów."
        liftIO $ putStrLn "Witasz się i powoli wchodzisz do środka. Studentów tu jeszcze nie ma, ale zapewne będą tu niedługo jakieś zajęcia."
        liftIO $ putStrLn "'Szuka Pan czegoś?' - pyta profesor. Odpowiadasz że tak, coś zostawiłeś (dobrze wiesz że to nieprawda)"
        liftIO $ putStrLn "Chociaż... ha, ciekawe. Widzisz kawałek notatki. Bierzesz ją - może się tobie przydać."
        modify (\s -> s { hasPickedUpItems = True })
        modify (addNote 4)
      else liftIO $ putStrLn "Wchodzisz do laboratorium i... nie, nie wchodzisz do laboratorium."

  (EITI, "zajrzyj_do_szatni") -> do
    cloakroomStatus <- gets hasCheckedCloakroom
    if not cloakroomStatus
      then do
        liftIO $ putStrLn "Podchodzisz, a Pan z szatni wyjmuje już numerek, i chce go tobie wręczyć. Nie bierzesz numerka, ale rozglądasz się wokół"
        liftIO $ putStrLn "'Czy w czymś Panu pomóc???' - zapytany odpowiadasz, że po prostu patrzysz czy czegoś nie zapomniałeś"
        liftIO $ putStrLn "'Coś... ostatnio wydawał się Pan jakiś rozkojarzony, o ile mnie pamięć nie myli...'"
        liftIO $ putStrLn "'hmmmm...' - Pan rozgląda się chwilę, patrzy pod swoje biurko, i mówi:"
        liftIO $ putStrLn "'Chyba to może być Pana. Niech Pan sprawdzi - leży tu od jakiegoś czasu.'"
        liftIO $ putStrLn "Dostajesz ładnie uciętą ściągę. Spoglądasz na zawartość, i rzeczywiście: coś kojarzysz. Może to się przydać..."
        modify (\s -> s { interactionCounter = interactionCounter s + 1 })
        modify (\s -> s { hasCheckedCloakroom = True })
      else liftIO $ putStrLn "Patrzysz jeszcze raz na szatnię, i nic nietypowego nie zauważasz. Prędko odchodzisz"

  (EITI, "idz_do_gg_pw") -> do
    liftIO $ putStrLn "Idziesz do Gmachu Głównego PW."
    modify (\s -> s { location = GGPW })
    modify (\s -> s { hasPickedUpItems = False })
    loc <- gets location
    liftIO $ printLocationInfo loc

  -- Gmach główny PW

  (GGPW, "pogadaj_z_kims") -> do
    return ()

  (GGPW, "sprawdz_tablice_ogloszen") -> do
    liftIO $ putStrLn "Na tablicy ogłoszeń widzisz informację o terminie oddania pracy. Oprócz tego, widzisz nowo powieszoną kartkę z napisem 'Zgubiono klucz do sali ...'"
    keyKnowledge <- gets knowsAboutMissingKey
    if not keyKnowledge
      then do
        liftIO $ putStrLn "Więc chodzi o klucz... no tak."
        modify (\s -> s { knowsAboutMissingKey = True })
      else do
        liftIO $ putStrLn "Wiesz o tym..."
        keyStatus <- gets hasKey
        if keyStatus
          then liftIO $ putStrLn "Patrzysz na klucz leżący w twojej dłoni."
          else return ()

  (GGPW, "sprawdz_portiernie") -> do
    liftIO $ putStrLn "Podchodzisz do pustej portierni. Zauważasz kubek z kawą, taśmę, i kilka innych przedmiotów."
    keyPartOne <- gets hasFirstPartOfBrokenKey
    keyPartTwo <- gets hasSecondPartOfBrokenKey
    if keyPartOne && keyPartTwo
      then do
        liftIO $ putStrLn "Masz dwie części klucza, które mniej więcej pasują do siebie. Bierzesz z biurka taśmę, i łączysz umiejętnie dwie części klucza."
        liftIO $ putStrLn "Hmmm. Ciekawe do czego ten klucz pasuje."
        modify (\s -> s { hasSecretRoomKey = True })
      else liftIO $ putStrLn "Odchodzisz."

  (GGPW, "przeszukaj_teren") -> do
    handleSearchArea

  (GGPW, "otworz_sale_glowna") -> do
    hasKey <- gets hasKey
    if hasKey
      then do
        liftIO $ putStrLn "Używasz klucza aby otworzyć salę..."
        modify (\s -> s { location = GlownaSala })
        loc <- gets location
        liftIO $ printLocationInfo loc
      else liftIO $ putStrLn "Nie masz klucza do sali!"

  -- Sala główna

  (GlownaSala, "sprawdz_kieszenie") -> do
    return ()

  (GlownaSala, "wyjdz_z_sali") -> do
    return ()

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

handleSearchArea :: Game ()
handleSearchArea = do
  keyStatus <- gets knowsAboutMissingKey
  if not keyStatus
    then do
      liftIO $ putStrLn "Przeszukujesz teren dookoła kompletnie bez pomysłu. Nic nie znajdujesz."
    else do
      liftIO $ putStrLn "Przeszukujesz teren... musisz jakoś otworzyć te drzwi do sali głównej."
      liftIO $ putStrLn "Chodzisz dookoła z myślą że coś znajdziesz, ale bez skutku... Może trzeba do tego podejść na spokojnie?"
      liftIO $ putStrLn "Co robisz? Wybierz [1] Idź do dziekanatu [2] Przeszukaj korytarze [3] Sprawdź różne sale, [4] Sprawdź klatkę schodową [5] Skończ szukać"
      input <- liftIO getLine
      case input of
        "1" -> searchDeanOffice >> handleSearchArea
        "2" -> searchCorridors >> handleSearchArea
        "3" -> searchRooms >> handleSearchArea
        "4" -> searchStairs >> handleSearchArea
        "5" -> do
          modify (\s -> s { location = GGPW })
          loc <- gets location
          liftIO $ printLocationInfo loc
        _   -> do
          liftIO (putStrLn "Nieprawidłowy wybór.")
          handleSearchArea

searchDeanOffice = do
  liftIO $ putStrLn "Dziekanat wydaje się być zamknięty. Spod drzwi wystaje kawałek jakiegoś przedmiotu"
  liftIO $ putStrLn "Wybierz [1] Spróbuj otworzyć drzwi do dziekanatu [2] Podnieś przedmiot [3] Wróć do miejsca startowego"
  input <- liftIO getLine
  case input of
    "1" -> do
      liftIO $ putStrLn "Drzwi dalej się nie otwierają. Próbujesz na siłę, ale bez skutku. Jedyne co wywołujesz, to dziwne spojrzenie od przechodzącej Pani magister."
      searchDeanOffice
    "2" -> do
      keyPartOne <- gets hasFirstPartOfBrokenKey
      if keyPartOne
        then liftIO $ putStrLn "Pod drzwiami jest jeszcze kawałek kartki. Zostawiasz go."
        else do
          liftIO $ putStrLn "Schylasz się po przedmiot, i wysuwasz go spod drzwi. Dobra informacja: jest to klucz!"
          liftIO $ putStrLn "Gorsza informacja: część tego klucza wydaje się wyłamana. Może się przyda, kto wie"
          keyPartTwo <- gets hasSecondPartOfBrokenKey
          if keyPartTwo
            then liftIO $ putStrLn "Gdyby tylko dało się go jakoś naprawić..."
            else return ()
          modify (\s -> s { hasFirstPartOfBrokenKey = True })
      searchDeanOffice
    "3" -> return ()
    _ -> do
      liftIO (putStrLn "Nieprawidłowy wybór.")
      searchDeanOffice

searchCorridors = do
  liftIO $ putStrLn "Jest tutaj co sprawdzać. Ale od czego zacząć?"
  liftIO $ putStrLn "Co sprawdzisz? [1] Pójdź w lewo [2] Pójdź w prawo [3] Pójdź na wprost [4] Wróć do miejsca startowego"
  input <- liftIO getLine
  case input of
    "1" -> do
      liftIO $ putStrLn "Przechodzisz po lewym korytarzu i sprawdzasz każdy kąt."
      liftIO $ putStrLn "Nic ciekawego nie zauważasz. Wracasz do rozwidlenia."
      searchCorridors
    "2" -> do
      liftIO $ putStrLn "Sprawdzasz korytarz po prawej. Sprawdzasz dosłownie wszystko co się da."
      keyPartTwo <- gets hasSecondPartOfBrokenKey
      if keyPartTwo
        then do
          liftIO $ putStrLn "Nic nie zauważasz"
          searchCorridors
        else do
          liftIO $ putStrLn "Zauważasz dwuzłotówkę, oraz dziwny kawałek... czegoś. Patrzysz czy nikt nie idzie, i podnosisz oba przedmioty"
          modify (\s -> s {hasSecondPartOfBrokenKey = True})
          keyPartOne <- gets hasFirstPartOfBrokenKey
          if keyPartOne
            then liftIO $ putStrLn "Ten kawałek w sumie pasuje do wyłamanego klucza. Gdyby go jakoś naprawić..."
            else return ()
          modify (addMoney 2)
          searchCorridors
    "3" -> do
      liftIO $ putStrLn "Idziesz na wprost. Natrafiasz na ścianę."
      searchCorridors
    "4" -> return ()
    _ -> do
      liftIO (putStrLn "Nieprawidłowy wybór.")
      searchCorridors

searchRooms = do
  liftIO $ putStrLn "Idziesz na pierwsze piętro, i wchodzisz do losowego korytarza. Za cel obierasz sobie losowe sale."
  liftIO $ putStrLn "Co robisz? [1] Wejdź do sali 121 [2] Wejdź do sali 113 [3] Wejdź do sali 133 [4] Wróć do miejsca startowego"
  input <- liftIO getLine
  case input of
    "1" -> do
      liftIO $ putStrLn "Próbujesz otworzyć salę 121."
      liftIO $ putStrLn "Sala jest zamknięta."
      secretKeyStatus <- gets hasSecretRoomKey
      if secretKeyStatus
        then liftIO $ putStrLn "Twój naprawiony klucz nie pasuje do zamka."
        else return ()
      keyStatus <- gets hasKey
      if keyStatus
        then liftIO $ putStrLn "Klucz który znalazłeś, nie pasuje do zamka."
        else return ()
      searchRooms
    "2" -> do
      liftIO $ putStrLn "Próbujesz otworzyć salę 113"
      liftIO $ putStrLn "Sala jest otwarta. Wchodzisz do środka: nikogo tutaj nie ma."
      liftIO $ putStrLn "Przeszukujesz salę, i wszystko wydaje się normalne. Podchodzisz do biurka nauczyciela, lecz wszystkie szafki są pozamykane."
      liftIO $ putStrLn "Nic nie znajdujesz."
      searchRooms
    "3" -> do
      liftIO $ putStrLn "Próbujesz otworzyć salę 133"
      liftIO $ putStrLn "Sala jest zamknięta. "
      keyStatus <- gets hasKey
      secretKeyStatus <- gets hasSecretRoomKey
      if keyStatus
        then liftIO $ putStrLn "Klucz który znalazłeś, nie pasuje do zamka. "
        else return ()
      if not secretKeyStatus
        then liftIO $ putStrLn "Odchodzisz od drzwi"
        else do
          liftIO $ putStrLn "Klucz który naprawiłeś, pasuje do zamka. Otwierasz drzwi do sali 133, i wchodzisz do środka."
          liftIO $ putStrLn "Wszystko wygląda normalnie. Zauważasz zostawione przez jakiegoś studenta notatki. Są z przedmiotu, który przecież kojarzysz."
          liftIO $ putStrLn "Szybko czytasz notatki. "
          itemStatus <- gets hasPickedUpItems
          lst <- gets notes
          if itemStatus
            then do
              liftIO $ putStrLn "Niczego więcej się nie dowiadujesz."
              return ()
            else do
              if length lst < 4
                then liftIO $ putStrLn "W sumie mało się dowiadujesz"
                else do
                  liftIO $ putStrLn "To może się przydać do twoich notatek! Bierzesz czystą kartkę z biurka nauczyciela, i przepisujesz najważniejsze rzeczy."
                  modify (\s -> s {interactionCounter = interactionCounter s + 1})
                  modify (\s -> s {hasPickedUpItems = True})
      searchRooms

    "4" -> return ()
    _ -> do
      liftIO (putStrLn "Nieprawidłowy wybór.")
      searchRooms

searchStairs = do
  liftIO $ putStrLn "Idziesz sprawdzić najbliższą klatkę schodową. Przechodzisz się po niej w górę, i wracasz. Nic nie zauważasz."
  keyStatus <- gets hasKey
  if keyStatus
    then liftIO $ putStrLn "Schylasz się po klucz i... nic nie podnosisz. Klucz trzymasz przecież w ręku. Niezręcznie..."
    else do
      liftIO $ putStrLn "Znajdujesz klucz! Wygląda dość staro, ale może będzie gdzieś pasować."
      modify (\s -> s {hasKey = True})
  liftIO $ putStrLn "Wracasz do punktu, z którego zacząłeś przeszukiwanie."
