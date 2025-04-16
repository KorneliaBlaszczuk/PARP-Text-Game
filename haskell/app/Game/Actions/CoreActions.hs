module Game.Actions.CoreActions
  ( Game
  , printAvailableActions
  , handleBasicAction
  ) where

import Game.State
import Game.Locations
import Control.Monad.State
import Control.Monad.IO.Class (liftIO)
import System.IO
import System.Exit
import Data.List (intercalate)

type Game = StateT GameState IO

printAvailableActions :: Game ()
printAvailableActions = do
  loc <- gets location
  case loc of
    Start -> showActions ["rozpocznij_gre"]
    TarasPKiN -> showActions ["zajrzyj_do_kieszeni", "rozejrzyj_sie", "zejdz_po_schodach"]
    SchodyPKiN -> showActions ["podnies_pieniadze", "idz_dalej"]
    HolPKiN -> showActions ["porozmawiaj_z_portierem", "wyjdz_na_zewnatrz"]
    SzatniaPKiN -> showActions ["wyjdz_na_zewnatrz", "przeszukaj_kieszenie", "przeszukaj_plaszcz"]
    PrzedPKiN -> showActions ["idz_w_strone_parku", "idz_w_strone_taksowki", "spojrz_na_ulotke"]
    Park -> showActions ["usiadz_na_lawce", "karm_golebie", "obejrzyj_fontanne", "porozmawiaj_z_nieznajomym", "idz_przed_pkin"]
    Taksowka -> showActions ["porozmawiaj", "pojedz_do_hali_koszyki", "pojedz_na_wilcza_30"]
    Wilcza30 -> showActions ["zapukaj_do_drzwi", "rozejrzyj_sie", "idz_do_hali_koszyki"]
    DomWilcza -> showActions ["wykup_notatke", "opusc_dom"]
    HalaKoszyki -> showActions ["podejdz_do_baru", "porozmawiaj_z_gosciem", "wyjdz_w_strone_chinczyka"]
    Chinczyk -> showActions ["porozmawiaj_z_wlascicielem", "kup_cos", "idz_do_gg_pw", "idz_na_weiti"]
    EITI -> showActions ["zajrzyj_do_laboratorium", "zajrzyj_do_szatni", "idz_do_gg_pw"]
    GGPW -> showActions ["pogadaj_z_kims", "sprawdz_tablice_ogloszen", "sprawdz_portiernie", "przeszukaj_teren", "otworz_sale_glowna"]
    GlownaSala -> showActions ["sprawdz_kieszenie", "wyjdz_z_sali", "podejdz_do_profesora"]
  where
    showActions actions = do
      liftIO $ putStrLn "\nDostępne akcje:"
      mapM_ (liftIO . putStrLn . ("- " ++)) actions

handleBasicAction :: String -> Game ()
handleBasicAction cmd = case cmd of
  "sprawdz(stan_notatek)" -> checkNotes
  "quit" -> liftIO exitSuccess
  _ -> return ()

checkNotes :: Game ()
checkNotes = do
  notes <- gets notes
  liftIO $ putStrLn $ "Masz " ++ show (length notes) ++ "/4 notatek"