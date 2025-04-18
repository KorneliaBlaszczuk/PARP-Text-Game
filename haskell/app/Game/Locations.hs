module Game.Locations
  ( locationDescription
  ) where

import Game.State (Location(..))

locationDescription :: Location -> String

locationDescription loc = case loc of
  Start -> "Wpisz 'rozpocznij_gre' aby rozpocząć swoją przygodę."
  TarasPKiN -> "Budzisz się na tarasie PKiN. Okropnie boli cię głowa, szczególnie, kiedy na twoje powieki padają pierwsze promienie nowego dnia.\nNagle czujesz dziabnięcie. To gołąb, który zdecydowanie nie jest zadowolony z twojej obecności na jego terytorium. Co zrobić?"
  SchodyPKiN -> "Schodząc w dół robisz krótką przerwę, strasznie boli Cię głowa. Patrząc w dół zauważasz leżące na podłodze pieniądze."
  HolPKiN -> "Głowa nadal boli cię nieubłaganie. Wokół cicho, tylko portier siedzi za ladą. Może warto go zapytać o wczoraj?"
  SzatniaPKiN -> "Wygląda na to, że kilka osób zapomniało wziąć płaszcz wychodząc. Może być trudno zgadnąć, który jest mój."
  PrzedPKiN -> "Jesteś przed PKiN. Widok na miasto jest zapierający, możesz ruszyć w różne strony."
  Park -> "Wchodzisz do Parku Świętokrzyskiego. Powietrze jest rześkie, a pierwsze promienie słońca oświetlają puste alejki. W oddali słyszysz szum miasta, ale tutaj panuje dziwny spokój."
  Taksowka -> "Wsiadłeś do taksówki. Kierowca czeka na dalsze instrukcje."
  Wilcza30 -> "Stoisz przed drzwiami mieszkania na Wilczej 30."
  DomWilcza -> "Wchodzisz do środka, w pokoju unosi się zapach papierosów i starego drewna. Mężczyzna wskazuje na krzesło, każąc ci usiąść."
  HalaKoszyki -> "Hala Koszyki tętni życiem nawet o tej godzinie. Zapach kawy i świeżego pieczywa unosi się w powietrzu, a ludzie śmieją się przy stolikach."
  Chinczyk -> "Lokal jest niewielki, ale przytulny. Na ścianach wiszą chińskie lampiony, a w tle cicho gra azjatycka muzyka."
  EITI -> "Jesteś na Wydziale EITI. Laboratoria i studenci dookoła."
  GGPW -> "Jesteś w Gmachu Głównym Politechniki Warszawskiej. Wszędzie pełno studentów i nauczycieli."
  GlownaSala -> "Jesteś w głównej sali. Czas na końcową decyzję i oddanie pracy semestralnej."
  -- _ -> "Nieznana lokalizacja."
