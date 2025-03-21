% Początkowy stan gracza
:- dynamic lokalizacja/1.
:- dynamic stan/2.
:- dynamic dzialanie/2.
:- dynamic zajrzano_do_kieszeni/0.
:- dynamic podniesiono_przedmioty/0.
:- dynamic licznik_interakcji/1.
:- dynamic wie_o_brakujacym_kluczu/0.
:- dynamic posiada_klucz/0.
:- dynamic licznik_rozmow/1.
:- dynamic posiada_1_czesc_wylamanego_klucza/0.
:- dynamic posiada_2_czesc_wylamanego_klucza/0.
:- dynamic posiada_klucz_do_sekretnej_sali/0.
:- dynamic sprawdzil_szatnie/0.
:- dynamic wie_o_pracy_semestralnej/0.
:- dynamic sprawdzil_kieszenie_sala_glowna/0.
:- dynamic przywital_sie_z_nikim/0.
:- dynamic podszedl_do_baru/0.
:- dynamic kupil_notatke_na_wilczej/0.

lokalizacja(start).
stan(pieniadze, 0).
stan(notatki, []).
stan(numerek, nie).
stan(wilcza, nie).
stan(hala_koszyki, nie).
stan(park, nie).
stan(rozmowa, nie).
stan(eiti, nie).

% Definicja dostępnych akcji dla każdej lokalizacji
akcje(taras_pkin, [zajrzyj_do_kieszeni, rozejrzyj_sie, podejdz_do_krawedzi, zejdz_po_schodach, uzyj_windy]).
akcje(schody_pkin, [podnies_pieniadze, idz_dalej]).
akcje(hol_pkin, [porozmawiaj_z_portierem, wyjdz_na_zewnatrz, udaj_sie_do_szatni]).
akcje(szatnia_pkin, [wyjdz_na_zewnatrz, przeszukaj_kieszenie, przeszukaj_plaszcz]).
% akcje(przed_pkin, [idz_w_strone_parku, idz_w_strone_taksowki, spojrz_na_ulotke]).
akcje(przed_pkin, Akcje) :-
    findall(Akcja, dostępny_pkin(Akcja), Akcje).
akcje(park, [usiadz_na_lawce, karm_golebie, obejrzyj_fontanne, porozmawiaj_z_nieznajomym, idz_przed_pkin]).
% akcje(taksowka, [pojedz_do_hali_koszyki, pojedz_na_wilcza_30, porozmawiaj]).
akcje(taksowka, Akcje) :-
    findall(Akcja, dostepna_taksowka(Akcja), Akcje).
akcje(wilcza_30, [zapukaj_do_drzwi, rozejrzyj_sie, idz_do_hali_koszyki]).
akcje(dom_wilcza, [wykup_notatke, opusc_dom]).
akcje(hala_koszyki, [podejdz_do_baru, porozmawiaj_z_gosciem, wyjdz_w_strone_chinczyka]).
akcje(chinczyk, [porozmawiaj_z_wlascicielem, kup_cos, idz_do_gg_pw, idz_na_weiti]).
akcje(eiti, [zajrzyj_do_laboratorium, zajrzyj_do_szatni, idz_do_gg_pw]).
akcje(gg_pw, [pogadaj_z_kims, sprawdz_tablice_ogloszen, sprawdz_portiernie, przeszukaj_teren, otworz_sale_glowna]).
akcje(glowna_sala, [sprawdz_kieszenie, wyjdz_z_sali, podejdz_do_profesora]).

dostepna_taksowka(porozmawiaj).
dostepna_taksowka(pojedz_do_hali_koszyki) :- stan(hala_koszyki, tak).
dostepna_taksowka(pojedz_na_wilcza_30) :- stan(wilcza, tak).

dostępny_pkin(idz_w_strone_parku).
dostępny_pkin(idz_w_strone_taksowki).
dostępny_pkin(spojrz_na_ulotke).
dostępny_pkin(idz_do_hali_koszyki) :- stan(hala_koszyki, tak).
dostępny_pkin(idz_na_wilcza_30) :- stan(wilcza, tak).

% Funkcje do licznika interakcji

inicjuj_licznik() :-
    assertz(licznik_interakcji(0)).

inkrementuj_licznik() :-
    licznik_interakcji(Wartosc),
    NowaWartosc is Wartosc + 1,
    retract(licznik_interakcji(Wartosc)),
    assertz(licznik_interakcji(NowaWartosc)).

sprawdz_licznik() :-
    licznik_interakcji(Wartosc),
    write("Aktualna wartość licznika: "), write(Wartosc), nl.

czy_licznik_wiekszy_od(Liczba) :-
    licznik_interakcji(Wartosc),
    Wartosc > Liczba.

ustal_wartosc_licznika(NowaWartosc) :-
    licznik_interakcji(Wartosc),
    retract(licznik_interakcji(Wartosc)),
    assertz(licznik_interakcji(NowaWartosc)).

% Funkcje rozmowy w gmachu głównym

interakcja_ggpw() :-
    \+ licznik_rozmow(_),
    assertz(licznik_rozmow(0)),
    write("Zauważasz jakiegoś profesora, i podchodzisz do niego."), nl,
    (\+ wie_o_brakujacym_kluczu ->
        write("Mówisz do profesora dzień dobry. Profesor z uśmiechem wita się z tobą. Nic więcej nie mówisz."), nl
    ;
        write("Witasz się z profesorem. Pytasz go też, czy wie jak otworzyć salę główną."), nl,
        write("'Nie jest otwarta? Hm. Niech Pan sprawdzi może w portierni - tam powinni Panu pomóc.'"), nl
    ).

interakcja_ggpw() :-
    licznik_rozmow(X),
    X = 0,
    write("Zaczepiasz jakiegoś studenta. Student uśmiecha się do ciebie."), nl,
    write("'Hej, co tam?'"), nl,
    write("Patrzysz się ze zdziwieniem. Student przypomina tobie, że jest z tobą na roku. Nadal nic ci to nie mówi."), nl,
    (\+ wie_o_brakujacym_kluczu ->
        write("Nie wiedząc co powiedzieć, jak najszybciej znikasz z miejsca zdarzenia."), nl
    ;
        write("Nieważne. Pytasz go, czy wie jak dostać się do sali głównej."), nl,
        write("'Czytałeś może tablicę ogłoszeń? Napisali że klucza nie ma - zginął gdzieś. Ciekawe gdzie go zgubili...'"), nl,
        write("Nie pomogło tobie to za bardzo. Odchodzisz."), nl
    ),
    retract(licznik_rozmow(X)),
    assertz(licznik_rozmow(1)).

interakcja_ggpw() :-
    licznik_rozmow(X),
    X = 1,
    write("Próbujesz pogadać z Panią woźną."), nl,
    (\+ wie_o_brakujacym_kluczu ->
        write("W sumie uznajesz, że nie chcesz jej przeszkadzać. Odchodzisz."), nl
    ;
        write("Pytasz Panią, czy może wie na temat zamknięcia sali głównej."), nl,
        write("'Oj nie wiem, słyszałam tylko że zginął niedawno. Tak dokładnie nie szukaliśmy go jeszcze.'"), nl
    ),
    retract(licznik_rozmow(X)),
    assertz(licznik_rozmow(2)).


interakcja_ggpw() :-
    licznik_rozmow(X),
    X = 2,
    write("Podchodzisz do studentki. Witasz się. "),
    (\+ wie_o_brakujacym_kluczu ->
        write("Pytasz jak idzie w tym semestrze. Studentka krótko odpowiada że, idzie jej nieźle."), nl
    ;
        write("Pytasz, czy może wie dlaczego sala główna jest zamknięta."), nl,
        write("'Hm, też próbujesz oddać pracę semestralną, nie?'"), nl,
        stan(notatki, Lista),
        length(Lista, N),
        (N = 0 -> write("Zaraz... "); true),
        (N = 4 ->
            write("Odpowiadasz, że tak - na tym tobie teraz zależy"), nl,
            write("'Podobno klucz gdzieś się zgubił, i teraz profesor czeka w środku aż ktoś mu otworzy'"), nl,
            write("Żegnasz się, i powoli odwracasz się w stro-"), nl,
            write("'Tak jak coś, kolega mi mówił że zaczął odpytywać ostatnio.'"),
            write("'Podobno mówi coś w stylu 'no i jak twoja wiedza', i jak mu odpowiesz, to można wyższą ocenę dostać.'"), nl,
            write("Pytasz, czy może wie, z czego odpytywał."), nl,
            write("'Chyba wszystkich pytał o to samo...'"), nl,
            write("Przez kolejną minutę rozmawiasz, i słuchasz o pytaniach. To się może przydać!"), nl,
            inkrementuj_licznik() % interakcja : +0.5 do oceny końcowej
        ;
            write("Aha, faktycznie. Odchodzisz."), nl
        )
    ),
    retract(licznik_rozmow(X)),
    assertz(licznik_rozmow(3)).

interakcja_ggpw() :-
    licznik_rozmow(X),
    X = 3,
    (\+ wie_o_brakujacym_kluczu -> write("Nie chcesz już próbować.") ; write("Chciałbyś zagadać jeszcze raz, ale nie widzisz już nikogo, z kim rozmawiałeś.")),
    nl.

% Funkcje do przeszukiwania terenu w gmachu głównym

przeszukaj_miejsce(1) :-
    repeat,
    write("Dziekanat wydaje się być zamknięty. Spod drzwi wystaje kawałek jakiegoś przedmiotu"), nl,
    write("Wybierz [1] Spróbuj otworzyć drzwi do dziekanatu [2] Podnieś przedmiot [3] Wróć do miejsca startowego"), nl,
    read(Wybor),
    (Wybor = 1 ->
        shell('clear'),
        write("Drzwi dalej się nie otwierają. Próbujesz na siłę, ale bez skutku. Jedyne co wywołujesz, to dziwne spojrzenie od przechodzącej Pani magister."), nl, nl,
        fail
        ;
        true
    ),
    (Wybor = 2 ->
        shell('clear'),
        (\+ posiada_1_czesc_wylamanego_klucza ->
            write("Schylasz się po przedmiot, i wysuwasz go spod drzwi. Dobra informacja: jest to klucz!"), nl,
            write("Gorsza informacja: część tego klucza wydaje się wyłamana. Może się przyda, kto wie"), nl,
            (posiada_2_czesc_wylamanego_klucza -> write("Ten kawałek co podniosłeś wcześniej wydaje się dopełniać wyłamany klucz"), nl,
                write("Gdyby tylko dało się go jakoś naprawić..."); true),
            assertz(posiada_1_czesc_wylamanego_klucza),
            fail
            ;
            write("Pod drzwiami jest jeszcze kawałek kartki. Zostawiasz go."), nl
        )
        ;
        true
    ),
    (Wybor = 3 ->
        shell('clear'),
        dzialanie(gg_pw, przeszukaj_teren)
        ;
        fail
    ).

przeszukaj_miejsce(2) :-
    repeat,
    write("Jest tutaj co sprawdzać. Ale od czego zacząć?"), nl, nl,
    write("Co sprawdzisz? [1] Pójdź w lewo [2] Pójdź w prawo [3] Pójdź na wprost [4] Wróć do miejsca startowego"), nl,
    read(Wybor),
    (Wybor = 1 ->
        shell('clear'),
        write("Przechodzisz po lewym korytarzu i sprawdzasz każdy kąt."), nl,
        write("Nic ciekawego nie zauważasz. Wracasz do rozwidlenia."), nl,
        fail
        ;
        true
    ),
    (Wybor = 2 ->
        shell('clear'),
        write("Sprawdzasz korytarz po prawej. Sprawdzasz dosłownie wszystko co się da."), nl,
        (\+ posiada_2_czesc_wylamanego_klucza ->
            write("Zauważasz dwuzłotówkę, oraz dziwny kawałek... czegoś. Patrzysz czy nikt nie idzie, i podnosisz oba przedmioty"), nl,
            assertz(posiada_2_czesc_wylamanego_klucza),
            (posiada_1_czesc_wylamanego_klucza ->
            write("Ten kawałek w sumie pasuje do wyłamanego klucza. Gdyby go jakoś naprawić..."), nl; true),
            dodaj(2),
            fail
            ;
            write("Nic nie zauważasz"), nl
        )
        ; true
    ),
    (Wybor = 3 -> shell('clear'), write("Idziesz na wprost. Natrafiasz na ścianę."), nl,
        fail ; true),
    (Wybor = 4 ->
        shell('clear'),
        dzialanie(gg_pw, przeszukaj_teren)
        ;
        fail
    ).

przeszukaj_miejsce(3) :-
    repeat,
    write("Idziesz na pierwsze piętro, i wchodzisz do losowego korytarza. Za cel obierasz sobie losowe sale."), nl, nl,
    write("Co robisz? [1] Wejdź do sali 121 [2] Wejdź do sali 113 [3] Wejdź do sali 133 [4] Wróć do miejsca startowego"), nl,
    read(Wybor),
    (Wybor = 1 ->
        shell('clear'),
        write("Próbujesz otworzyć salę 121."), nl,
        write("Sala jest zamknięta."), nl,
        (posiada_klucz_do_sekretnej_sali -> write("Twój naprawiony klucz nie pasuje do zamka."); true),
        (posiada_klucz -> write("Klucz który znalazłeś, nie pasuje do zamka."), nl; true),
        fail ; true
    ),
    (Wybor = 2 ->
        shell('clear'),
        write("Próbujesz otworzyć salę 113"), nl,
        write("Sala jest otwarta. Wchodzisz do środka: nikogo tutaj nie ma."), nl,
        write("Przeszukujesz salę, i wszystko wydaje się normalne. Podchodzisz do biurka nauczyciela, lecz wszystkie szafki są pozamykane."), nl,
        write("Nic nie znajdujesz."), nl, fail ; true
    ),
    (Wybor = 3 ->
        shell('clear'),
        write("Próbujesz otworzyć salę 133"), nl,
        write("Sala jest zamknięta. "),
        (posiada_klucz -> write("Klucz który znalazłeś, nie pasuje do zamka. "); true),
        (posiada_klucz_do_sekretnej_sali ->
            write("Klucz który naprawiłeś, pasuje do zamka. Otwierasz drzwi do sali 133, i wchodzisz do środka."), nl,
            write("Wszystko wygląda normalnie. Zauważasz zostawione przez jakiegoś studenta notatki. Są z przedmiotu, który przecież kojarzysz."), nl,
            write("Szybko czytasz notatki. "),
            stan(notatki, Lista),
            length(Lista, N),
            (N < 4 ->
                write("W sumie mało się dowiadujesz"), nl;
                write("To może się przydać do twoich notatek! Bierzesz czystą kartkę z biurka nauczyciela, i przepisujesz najważniejsze rzeczy."),
                inkrementuj_licznik(), nl % interakcja : +0.5 do oceny końcowej
            ),
            true
            ;
            write("Odchodzisz od drzwi."), nl,
            true
        ),
        fail ; true
    ),
    (Wybor = 4 ->
        shell('clear'),
        dzialanie(gg_pw, przeszukaj_teren)
        ;
        fail
    ).

przeszukaj_miejsce(4) :-
    shell('clear'),
    write("Idziesz sprawdzić najbliższą klatkę schodową. Przechodzisz się po niej w górę, i wracasz. Nic nie zauważasz."), nl,
    podnies_klucz(),
    write("Wracasz do punktu, z którego zacząłeś przeszukiwanie."), nl,
    dzialanie(gg_pw, przeszukaj_teren).

przeszukaj_miejsce(5) :-
    true,
    wypisz_dostepne_akcje(gg_pw).

% Funkcje do klucza sali głównej

podnies_klucz() :-
    \+ posiada_klucz,
    write("Znajdujesz klucz! Wygląda dość staro, ale może będzie gdzieś pasować."), nl,
    assertz(posiada_klucz).

podnies_klucz() :-
    posiada_klucz,
    write("Schylasz się po klucz i... nic nie podnosisz. Klucz trzymasz przecież w ręku. Niezręcznie..."), nl.

czy_ma_klucz() :-
    posiada_klucz.

% Zmiana stanu pieniędzy
dodaj(Kwota) :-
    stan(pieniadze, ObecnePieniadze), % Pobieramy obecny stan pieniędzy
    NowyStan is ObecnePieniadze + Kwota, % Dodajemy x zł do obecnego stanu
    retract(stan(pieniadze, ObecnePieniadze)), % Usuwamy stary stan
    assertz(stan(pieniadze, NowyStan)), % Dodajemy nowy stan
    write("Twoje fundusze to: "), % Wyświetlamy komunikat
    write(NowyStan), % Wyświetlamy nowy stan portfela
    write(" zł"), nl.

odejmij(Kwota) :-
    stan(pieniadze, ObecnePieniadze), % Pobieramy obecny stan pieniędzy
    NowyStan is ObecnePieniadze - Kwota, % odejmujemy x zł od obecnego stanu
    retract(stan(pieniadze, ObecnePieniadze)), % Usuwamy stary stan
    assertz(stan(pieniadze, NowyStan)), % Dodajemy nowy stan
    write("Twoje fundusze to: "), % Wyświetlamy komunikat
    write(NowyStan), % Wyświetlamy nowy stan portfela
    write(" zł"), nl.

% Funkcja zmieniająca lokalizację i wypisująca dostępne akcje
zmien_lokalizacje(NowaLokalizacja) :-
    retract(lokalizacja(_)),
    assertz(lokalizacja(NowaLokalizacja)),
    opis(NowaLokalizacja),
    wypisz_dostepne_akcje(NowaLokalizacja).

wypisz_dostepne_akcje(Lokalizacja) :-
    akcje(Lokalizacja, Akcje),
    write("Dostępne akcje: "), nl,
    wypisz_akcje(Akcje).

% Uproszczone wywołanie akcji
dzialanie(Akcja) :-
    % shell('clear'),
    lokalizacja(Lokalizacja),
    dzialanie(Lokalizacja, Akcja).

wypisz_akcje([]).
wypisz_akcje([Akcja | Reszta]) :-
    write("- "), write(Akcja), nl,
    wypisz_akcje(Reszta).

% Funkcja wyświetlająca opis dla każdej lokalizacji
opis(taras_pkin) :-
    write("Budzisz się na tarasie PKiN. Okropnie boli cię głowa, szczególnie, kiedy na twoje powieki padają pierwsze promienie nowego dnia."), nl,
    write("Nagle czujesz dziabnięcie. To gołąb, który zdecydowanie nie jest zadowolony z twojej obecności na jego terytorium. Co zrobić?"), nl.

opis(schody_pkin) :-
    write("Schodząc w dół robisz krótka przerwę, strasznie boli Cię głowa. Patrząc w dół zauważasz leżące na podłodze 10 zł."), nl.

opis(hol_pkin) :-
    write("Głowa nadal boli cię nieubłaganie. Wokół cicho, tylko portier siedzi za ladą. Może warto go zapytać o wczoraj?"), nl.

opis(szatnia_pkin) :-
    write("Wygląda na to, że kilka osób zapomniało wziąć płaszcz wychodząc. Może być trudno zgadnąć, który jest mój."), nl.

opis(przed_pkin) :-
    write("Jesteś przed PKiN. Widok na miasto jest zapierający, możesz ruszyć w różne strony."), nl.

opis(park) :-
    write("Wchodzisz do Parku Świętokrzyskiego. Powietrze jest rześkie, a pierwsze promienie słońca oświetlają puste alejki. W oddali słyszysz szum miasta, ale tutaj panuje dziwny spokój. Na jednej z ławek siedzi mężczyzna owinięty w gruby płaszcz, z brodą gęstą jak historia tego miasta. Kiedy przechodzisz obok, unosi wzrok i uśmiecha się lekko. Obok widzisz budkę, gdzie możesz kupić nasiona dla gołębi (-5zł)."), nl.

opis(taksowka) :-
    write("Wsiadłeś do taksówki. Kierowca czeka na dalsze instrukcje."), nl.

opis(wilcza_30) :-
    write("Stoisz przed drzwiami mieszkania na Wilczej 30. "), nl.

opis(dom_wilcza) :-
    write("Wchodzisz do środka, w pokoju unosi się zapach papierosów i starego drewna. Mężczyzna wskazuje na krzesło, każąc ci usiąść."), nl,
    write("Nagle bierze jakąś kartkę ze stołu. Mówi: 'Potrzebujesz tego, ale za darmo ci tego nie oddam (-10 zł).'"), nl.

opis(hala_koszyki) :-
    write("Hala Koszyki tętni życiem nawet o tej godzinie. Zapach kawy i świeżego pieczywa unosi się w powietrzu, a ludzie śmieją się przy stolikach."), nl,
    write("Czujesz, że byłeś tu wczoraj, ale wciąż nie pamiętasz, co się stało."), nl.

opis(chinczyk) :-
    write("Lokal jest niewielki, ale przytulny."), nl,
    write("Na ścianach wiszą chińskie lampiony, a w tle cicho gra azjatycka muzyka. Właściciel patrzy na ciebie z zainteresowaniem, jakby cię już widział."), nl.

opis(eiti) :-
    write("Jesteś na Wydziale EITI. Laboratoria i studenci dookoła."), nl.

opis(gg_pw) :-
    write("Jesteś w Gmachu Głównym Politechniki Warszawskiej. Wszędzie pełno studentów i nauczycieli."), nl,
    write("Znajdujesz swoim wzrokiem salę główną. Czas zdaje się biec coraz szybciej."), nl.

opis(glowna_sala) :-
    write("Jesteś w głównej sali. Czas na końcową decyzję i oddanie pracy semestralnej."), nl.

% Opis początkowy gry
start :-
    inicjuj_licznik(),
    zmien_lokalizacje(taras_pkin).

% Akcje dostępne na tarasie PKiN
dzialanie(taras_pkin, zajrzyj_do_kieszeni) :-
    \+ zajrzano_do_kieszeni,
    assertz(zajrzano_do_kieszeni),
    write("Sięgasz do kieszeni i znajdujesz 20 zł oraz notatkę."), nl,
    dodaj(20),
    retract(stan(notatki, Lista)),
    assertz(stan(notatki, [1 | Lista])).

dzialanie(taras_pkin, zajrzyj_do_kieszeni) :-
    zajrzano_do_kieszeni,
    write("Już zajrzałeś do kieszeni, nic tam więcej nie ma.").

dzialanie(taras_pkin, rozejrzyj_sie) :-
    write("Widzisz panoramę miasta. Słońce wschodzi nad Warszawą."), nl.

dzialanie(taras_pkin, uzyj_windy) :-
    write("Zjeżdzasz windą prosto na dół do holu PKiN."), nl,
    zmien_lokalizacje(hol_pkin).

dzialanie(taras_pkin, podejdz_do_krawedzi) :-
    write("Podchodzisz do krawędzi i odczuwasz lekki zawrót głowy."), nl.

dzialanie(taras_pkin, zejdz_po_schodach) :-
    write("Schodzisz schodami PKiN."), nl,
    zmien_lokalizacje(schody_pkin).

% Akcje dostępne na schodach PKiN
dzialanie(schody_pkin, podnies_pieniadze) :-
    (\+ podniesiono_przedmioty -> dodaj(10), assert(podniesiono_przedmioty); write("Nic tutaj już nie ma."), nl).

dzialanie(schody_pkin, idz_dalej) :-
    write("Schodzisz schodami do holu PKiN."), nl,
    zmien_lokalizacje(hol_pkin).

% Akcje dostępne w holu PKiN
dzialanie(hol_pkin, porozmawiaj_z_portierem) :-
    write("Portier patrzy na ciebie podejrzliwie, ale nic nie mówi."), nl.

dzialanie(hol_pkin, wyjdz_na_zewnatrz) :-
    write("Wychodzisz na zewnątrz, przed PKiN."), nl,
    write("Wychodząc zaczepia cię dziwny chłopak, który mówi: 'O hej brachu, pamiętasz co się działo wczoraj w Hali Koszyki?'"), nl,
    retract(stan(hala_koszyki, nie)), % Usuwamy stary stan
    assertz(stan(hala_koszyki, tak)), % Ustawiamy nowy stan
    zmien_lokalizacje(przed_pkin).

dzialanie(hol_pkin, udaj_sie_do_szatni) :-
    write("Idziesz do szatni."), nl,
    zmien_lokalizacje(szatnia_pkin).

% Akcje dostępne w szatni PKiN
dzialanie(szatnia_pkin, wyjdz_na_zewnatrz) :-
    write("Wychodzisz z PKiN."), nl,
    write("Wychodząc zaczepia cię dziwny chłopak, który mówi: 'O hej brachu, pamiętasz co się działo wczoraj w Hali Koszyki?'"), nl,
    % retract(stan(hala_koszyki, nie)), % Usuwamy stary stan
    assertz(stan(hala_koszyki, tak)), % Ustawiamy nowy stan
    zmien_lokalizacje(przed_pkin).

dzialanie(szatnia_pkin, przeszukaj_kieszenie) :-
    write("Warto było przeszukać kieszenie jeszce raz. Znajdujesz numerek."), nl,
    retract(stan(numerek, nie)), % Usuwamy stary stan
    assertz(stan(numerek, tak)). % Ustawiamy nowy stan

dzialanie(szatnia_pkin, przeszukaj_plaszcz) :-
    stan(numerek, nie), % Jeśli numerek nie został znaleziony
    write("Nie masz numerka, więc nie wiesz, który płaszcz należy do ciebie."), nl.

dzialanie(szatnia_pkin, przeszukaj_plaszcz) :-
    stan(numerek, tak), % Jeśli numerek został znaleziony
    retract(stan(hala_koszyki, nie)), % Usuwamy stary stan
    assertz(stan(hala_koszyki, tak)), % Ustawiamy nowy stan
    write("Znajdujesz ulotkę z ofertą Happy Hours z baru w Hali Koszyki."), nl.

% Przed PKiN
dzialanie(przed_pkin, idz_w_strone_parku) :-
    stan(park, nie), % Sprawdzenie, czy nie było jeszcze gracza w parku
    write("Idziesz w stronę parku..."), nl,
    zmien_lokalizacje(park).

dzialanie(przed_pkin, idz_w_strone_parku) :-
    stan(park, tak), % Sprawdzenie, czy nie było jeszcze gracza w parku
    write("Odwiedziłeś już park, nie masz ochoty znowu tam wracać..."), nl.

dzialanie(przed_pkin, idz_w_strone_taksowki) :-
    stan(pieniadze, ObecnePieniadze),
    ObecnePieniadze >= 20,
    write("Wsiadasz do taksówki."), nl,
    zmien_lokalizacje(taksowka).

dzialanie(przed_pkin, idz_w_strone_taksowki) :-
    write("Nie masz wystarczającej ilości pieniędzy, aby skorzystać z taksówki."), nl.

dzialanie(przed_pkin, spojrz_na_ulotke) :-
    write("Znajdujesz ulotkę z baru w Hali Koszyki z reklamą Happy Hours. Może warto się dam udać?"), nl.

dzialanie(przed_pkin, idz_do_hali_koszyki) :-
    write("Postanawiasz pójść do Hali Koszyki spacerując, aby móc podziwiać budzącą się Warszawę."), nl,
    zmien_lokalizacje(hala_koszyki).

dzialanie(przed_pkin, idz_na_wilcza_30) :-
    write("Postanawiasz pójść na Wilczą 30 spacerując, aby móc podziwiać budzącą się Warszawę."), nl,
    zmien_lokalizacje(wilcza_30).

% Park
dzialanie(park, usiadz_na_lawce) :-
    write("Siadasz na zimnej, metalowej ławce. Chłód poranka powoli przenika przez materiał twojego ubrania. Przymykasz oczy na chwilę i wsłuchujesz się w dźwięki miasta. Czujesz chwilowy spokój. Może nawet zbyt wielki. Jakby świat na moment się zatrzymał, pozwalając ci złapać oddech przed kolejnym krokiem."), nl.

dzialanie(park, karm_golebie) :-
    stan(pieniadze, ObecnePieniadze),
    ObecnePieniadze >= 5, % Sprawdzamy, czy gracz ma pieniądze, aby kupić nasiona
    write("Kupujesz nasiona i karmisz gołębie. Jeden z nich wygląda znajomo... To ten, który dziabnął cię na tarasie!"), nl,
    odejmij(5). % Odejmujemy 5 zł

dzialanie(park, karm_golebie) :-
    write("Nie masz wystarczająco pieniędzy, aby kupić chleb dla gołębi."), nl.

dzialanie(park, obejrzyj_fontanne) :-
    write("Oglądasz fontanne. Patrzysz na spokojną taflę. Znajdujesz 5 zł."), nl,
    dodaj(5).

dzialanie(park, porozmawiaj_z_nieznajomym) :-
    stan(wilcza, nie),
    retract(stan(wilcza, nie)), % Usuwamy stary stan
    assertz(stan(wilcza, tak)), % Ustawiamy nowy stan
    write("Witasz się z nieznajomym."), nl,
    write("'Dzień dobry! Co u Pana słychać?' - pyta się ciebie nieznajomy z entuzjazmem"), nl,
    write("Równo entuzjastycznie odpowiadasz, że 'dobrze'... nawet jeśli pytanie nie brzmiało 'jak się czujesz', ale kto by się przejmował."), nl,
    write("Zaczynasz rozmowę z nieznajomym, aż... tracisz czucie czasu. Ile rozmawialiście? Nie wiesz."), nl,
    write("'Ja muszę proszę Pana jeszcze na autobus zdążyć, ale miło się z Panem rozmawiało!' - nieznajomy żegna się z tobą: znowu entuzjastycznie!"), nl, nl,
    write("'I niech Pan pamięta o Wilczej 30! Warto tam zajrzeć!'"), nl,
    write("??? Może o czymś wspomniałeś podczas rozmowy, co by skutkowały w takiej prośbie, ale tego nie pamiętasz"), nl,
    write("Masz wrażenie, że coś wyniosłeś z tej konwersacji, aczkolwiek nie wiesz do końca co."), nl,
    inkrementuj_licznik(). % interakcja - +0.5 do oceny końcowej

dzialanie(park, porozmawiaj_z_nieznajomym) :-
    write("Witasz się z nieznajomym. Entuzjastycznie machasz do niego."), nl,
    (\+ przywital_sie_z_nikim -> true, assertz(przywital_sie_z_nikim); write("Czy wszystko dobrze?"), nl).


dzialanie(park, idz_przed_pkin) :-
    write("Wracasz przed PKiN"),
    retract(stan(park, nie)), % Usuwamy stary stan
    assertz(stan(park, tak)), % Ustawiamy nowy stan
    zmien_lokalizacje(przed_pkin).

% Taksówka
dzialanie(taksowka, pojedz_do_hali_koszyki) :-
    write("Jedziesz do Hali Koszyki."), nl,
    odejmij(20),
    zmien_lokalizacje(hala_koszyki).

dzialanie(taksowka, pojedz_na_wilcza_30) :-
    write("Jedziesz na Wilczą 30."), nl,
    odejmij(20),
    zmien_lokalizacje(wilcza_30).

dzialanie(taksowka, porozmawiaj) :-
    write("Kierowca mówi: 'Ciężka noc, co? Wyglądasz jakoś tak wczorajszo. Zdecydowanie wczoraj poimprezowałeś.'"), nl.

% Wilcza 30
dzialanie(wilcza_30, zapukaj_do_drzwi) :-
    write("Otwiera ci nieznana osoba. 'Czekałem na ciebie.'"), nl,
    zmien_lokalizacje(dom_wilcza), nl.

dzialanie(wilcza_30, rozejrzyj_sie) :-
    write("Wilcza 30. Stara kamienica z odrapanym numerem nad wejściem."), nl,
    write("Drzwi noszą ślady zużycia, jakby ktoś niedawno próbował je sforsować."), nl,
    write("W środku czuć wilgoć, kurz i zapach tanich papierosów."), nl,
    write("Na skrzynkach pocztowych nazwiska lokatorów, ale jedno miejsce jest puste."), nl.

dzialanie(wilcza_30, idz_do_hali_koszyki) :-
    write("Opuszczasz Wilczą 30 i idziesz w strone Hali Koszyki."), nl,
    zmien_lokalizacje(hala_koszyki).

% Dom Wilcza
dzialanie(dom_wilcza, wykup_notatke) :-
    (\+ kupil_notatke_na_wilczej -> true; false),
    stan(pieniadze, ObecnePieniadze),
    ObecnePieniadze >= 10,
    write("Ciekawość wzieła górę i wykupiłeś ten kawałek papieru."), nl,
    assertz(kupil_notatke_na_wilczej),
    odejmij(10),
    retract(stan(notatki, Lista)),  % Pobieramy obecną listę notatek
    length(Lista, N),               % Sprawdzamy, ile jest notatek
    NowaNotatka is N + 1,           % Nowa notatka dostaje numer N+1
    assertz(stan(notatki, [NowaNotatka | Lista])), % Aktualizujemy stan
    zmien_lokalizacje(wilcza_30).

dzialanie(dom_wilcza, wykup_notatke) :-
    (kupil_notatke_na_wilczej -> write("Osoba nie ma nic więcej do sprzedania tobie. Po co mówiła tobie że coś ma?"), nl
    ;
    write("Kwota, o którą prosi cię mężczyzna jest zdecydowanie za wysoka. Może jeszcze tu wrócę..."), nl).


dzialanie(dom_wilcza, opusc_dom) :-
    write("Postanowiłeś opuścić dom mężczyzny. Co jeszcze cię czeka?"), nl,
    zmien_lokalizacje(wilcza_30).

% Hala Koszyki
dzialanie(hala_koszyki, podejdz_do_baru) :-
    \+ podszedl_do_baru,
    assertz(podszedl_do_baru),
    write("Barman rozpoznaje cię i mówi, że wczoraj zostawiłeś coś ważnego."), nl,
    write("Wręcza ci kolejną część notatki i wspomina o chińskiej restauracji, do której się wybierałeś."), nl,
    retract(stan(notatki, Lista)),  % Pobieramy obecną listę notatek
    length(Lista, N),               % Sprawdzamy, ile jest notatek
    NowaNotatka is N + 1,           % Nowa notatka dostaje numer N+1
    assertz(stan(notatki, [NowaNotatka | Lista])). % Aktualizujemy stan

dzialanie(hala_koszyki, podejdz_do_baru) :-
    write("Barman nie ma nic do wręczenia. Odchodzisz"), nl.

dzialanie(hala_koszyki, porozmawiaj_z_gosciem) :-
    write("Tajemniczy rozmówca wspomina o dziwnym incydencie, którego był świadkiem - ktoś potrącił cię szybko wychodząc."), nl.

dzialanie(hala_koszyki, wyjdz_w_strone_chinczyka) :-
    write("Idziesz do chińskiej restauracji."), nl,
    zmien_lokalizacje(chinczyk).

% Chińczyk
dzialanie(chinczyk, porozmawiaj_z_wlascicielem) :-
    stan(rozmowa, nie),
    write("Pamięta cię! Wspomina, że wczoraj zostawiłeś coś przy stoliku."), nl,
    write("Wskaże ci go jedynie, jeśli kupisz coś (10 zł), przecież za darmo nie możesz siedzieć w lokalu!"), nl,
    retract(stan(rozmowa, nie)),
    assertz(stan(rozmowa, tak)).

dzialanie(chinczyk, porozmawiaj_z_wlascicielem) :-
    stan(rozmowa, tak),
    write("Podchodzisz do właściciela jeszcze raz. Dalej cie pamięta."), nl,
    (stan(eiti, tak) -> write("Nic tobie nie wskazuje. Zaczynasz się zastanawiać co właściwie chcesz od właściciela."), nl;
                        write("Przypomina tobie o czymś przy stoliku. Jak coś kupisz (10 zł), to wskaże tobie ten tajemniczy przedmiot."), nl).

dzialanie(chinczyk, kup_cos) :-
    stan(rozmowa, nie),  % Sprawdzamy, czy najpierw rozmawialiśmy z właścicielem
    write("Najpierw porozmawiaj z właścicielem."), nl.

dzialanie(chinczyk, kup_cos) :-

    stan(rozmowa, tak),
    stan(pieniadze, ObecnePieniadze),
    ObecnePieniadze >= 10,  % Sprawdzamy, czy mamy wystarczająco pieniędzy
    stan(eiti, nie),         % Sprawdzamy, czy nie kupiliśmy wcześniej

    retract(stan(pieniadze, ObecnePieniadze)),  % Usuwamy stary stan pieniędzy
    NowePieniadze is ObecnePieniadze - 10,      % Zmniejszamy o 10 zł
    assertz(stan(pieniadze, NowePieniadze)),     % Ustawiamy nowy stan pieniędzy

    retract(stan(eiti, nie)),
    assertz(stan(eiti, tak)),   % Ustawiamy stan eiti na 'tak'
    write("Znajdujesz tajemniczą wiadomość „EITI” napisaną na odwrocie serwetki."), nl.

dzialanie(chinczyk, kup_cos) :-
    stan(rozmowa, tak),
    stan(pieniadze, ObecnePieniadze),
    ObecnePieniadze >= 10,
    stan(eiti, tak),
    write("Właściciel nie ma tobie nic ciekawego do sprzedania... no w sumie oprócz jedzenia.").


dzialanie(chinczyk, kup_cos) :-
    stan(rozmowa, tak),
    stan(pieniadze, ObecnePieniadze),
    ObecnePieniadze < 10,  % Sprawdzamy, czy mamy wystarczająco pieniędzy
    write("Nie masz tyle forsy! Musisz mieć 10 zł, aby kupić coś."), nl.

dzialanie(chinczyk, idz_do_gg_pw) :-
    write("Idziesz do Gmachu Głównego PW."), nl,
    zmien_lokalizacje(gg_pw).

dzialanie(chinczyk, idz_na_weiti) :-
    write("Idziesz na wydział EITI."), nl,
    (podniesiono_przedmioty -> retract(podniesiono_przedmioty); true),
    zmien_lokalizacje(eiti).

% EITI
dzialanie(eiti, zajrzyj_do_laboratorium) :-
    (\+ podniesiono_przedmioty ->
        write("Wchodzisz do laboratorium i widzisz profesorów."), nl,
        write("Witasz się i powoli wchodzisz do środka. Studentów tu jeszcze nie ma, ale zapewne będą tu niedługo jakieś zajęcia."), nl,
        write("'Szuka Pan czegoś?' - pyta profesor. Odpowiadasz że tak, coś zostawiłeś (dobrze wiesz że to nieprawda)"), nl,
        write("Chociaż... ha, ciekawe. Widzisz kawałek notatki. Bierzesz ją - może się tobie przydać."), nl,
        assert(podniesiono_przedmioty),
        retract(stan(notatki, Lista)),
        length(Lista, N),
        NowaNotatka is N + 1,
        assertz(stan(notatki, [NowaNotatka | Lista]))
    ;
        write("Wchodzisz do laboratorium i... nie, nie wchodzisz do laboratorium."), nl
    ).

dzialanie(eiti, zajrzyj_do_szatni) :-
    (\+ sprawdzil_szatnie ->
    write("Podchodzisz, a Pan z szatni wyjmuje już numerek, i chce go tobie wręczyć. Nie bierzesz numerka, ale rozglądasz się wokół"), nl,
    write("'Czy w czymś Panu pomóc???' - zapytany odpowiadasz, że po prostu patrzysz czy czegoś nie zapomniałeś"), nl,
    write("'Coś... ostatnio wydawał się Pan jakiś rozkojarzony, o ile mnie pamięć nie myli...'"), nl,
    write("'hmmmm...' - Pan rozgląda się chwilę, patrzy pod swoje biurko, i mówi:"), nl,
    write("'Chyba to może być Pana. Niech Pan sprawdzi - leży tu od jakiegoś czasu.'"), nl,
    write("Dostajesz ładnie uciętą ściągę. Spoglądasz na zawartość, i rzeczywiście: coś kojarzysz. Może to się przydać..."), nl,
    inkrementuj_licznik(), % interakcja, + 0.5 do oceny
    assertz(sprawdzil_szatnie)
    ;
    write("Patrzysz jeszcze raz na szatnię, i nic nietypowego nie zauważasz. Prędko odchodzisz"), nl
    ).

dzialanie(eiti, idz_do_gg_pw) :-
    write("Idziesz do Gmachu Głównego PW."), nl,
    zmien_lokalizacje(gg_pw).

% GG PW
dzialanie(gg_pw, przeszukaj_teren) :-
    \+ wie_o_brakujacym_kluczu,
    write("Przeszukujesz teren dookoła kompletnie bez pomysłu. Nic nie znajdujesz."), nl.

dzialanie(gg_pw, przeszukaj_teren) :-
    wie_o_brakujacym_kluczu,
    write("Przeszukujesz teren... musisz jakoś otworzyć te drzwi do sali głównej."), nl, nl,
    write("Chodzisz dookoła z myślą że coś znajdziesz, ale bez skutku... Może trzeba do tego podejść na spokojnie?"), nl,
    write("Co robisz? Wybierz [1] Idź do dziekanatu [2] Przeszukaj korytarze [3] Sprawdź różne sale, [4] Sprawdź klatkę schodową [5] Skończ szukać"), nl,
    read(Wybor),
    przeszukaj_miejsce(Wybor).

dzialanie(gg_pw, sprawdz_tablice_ogloszen) :-
    write("Na tablicy ogłoszeń widzisz informację o terminie oddania pracy. Oprócz tego, widzisz nowo powieszoną kartkę z napisem 'Zgubiono klucz do sali ...'"), nl,
    (\+ wie_o_brakujacym_kluczu -> write("Więc chodzi o klucz... no tak."), nl, assertz(wie_o_brakujacym_kluczu)
    ;
    write("Wiesz o tym... "),
    (posiada_klucz -> write("Patrzysz na klucz leżący w twojej dłoni."); true)),
    wypisz_dostepne_akcje(gg_pw).

dzialanie(gg_pw, sprawdz_portiernie) :-
    write("Podchodzisz do pustej portierni. Zauważasz kubek z kawą, taśmę, i kilka innych przedmiotów."), nl,
    (posiada_1_czesc_wylamanego_klucza, posiada_2_czesc_wylamanego_klucza ->
        (\+ posiada_klucz_do_sekretnej_sali ->
            write("Masz dwie części klucza, które mniej więcej pasują do siebie. Bierzesz z biurka taśmę, i łączysz umiejętnie dwie części klucza."), nl,
            write("Hmmm. Ciekawe do czego ten klucz pasuje."), nl,
            assertz(posiada_klucz_do_sekretnej_sali) ; true
        )
        ; write("Odchodzisz."), nl
    ),
    wypisz_dostepne_akcje(gg_pw).

dzialanie(gg_pw, otworz_sale_glowna) :-
    \+ posiada_klucz,
    write("Chwytasz za klamkę, i próbujesz otworzyć drzwi, aczkolwiek nic z tego - drzwi są zamknięte."), nl,
    (\+ wie_o_brakujacym_kluczu -> assertz(wie_o_brakujacym_kluczu); true),
    wypisz_dostepne_akcje(gg_pw).

dzialanie(gg_pw, otworz_sale_glowna) :-
    posiada_klucz,
    (posiada_klucz_do_sekretnej_sali -> write("Naprawiony klucz nie pasuje, ale..."), nl; true),
    write("Klucz pasuje do zamka. Przekręcasz go, a drzwi, może i powoli, ale otwierają się przed tobą."), nl,
    zmien_lokalizacje(glowna_sala).

dzialanie(gg_pw, pogadaj_z_kims) :-
    interakcja_ggpw(),
    wypisz_dostepne_akcje(gg_pw).

dzialanie(glowna_sala, wyjdz_z_sali) :-
    write("Próbujesz wyjść z sali... ale drzwi się zamknęły, i nie chcą się otworzyć"), nl.

dzialanie(glowna_sala, sprawdz_kieszenie) :-
    \+ sprawdzil_kieszenie_sala_glowna,
    stan(notatki, Lista),
    length(Lista, N),
    stan(pieniadze, X),
    Y = 4 - X,
    (N = 0 ->
        write("Sprawdzasz swoje kieszenie... znajdujesz "), write(X), write(" złotych."), nl,
        write("Ale fajnie :D... żadna inna myśl nie przychodzi tobie do głowy."), nl
        ;
        write("Sprawdzasz swoje kieszenie... znajdujesz "), write(N), write(" części notatek, oraz "), write(X), write(" złotych."), nl,
        (N < 4 ->
            write("Zaraz... o nie..."), nl,
            write("W panice składasz części twojej pracy które wcześniej zebrałeś."), nl,
            write("Praca... nie jest kompletna. Brzuch zaczyna cię boleć. Wygląda na to, że brakuje tobie "), write(Y), write(" części notatek."), nl
            ;
            write("Teraz jesteś pewien - trzymasz części twojej pracy semestralnej."), nl,
            write("W panice składasz części twojej pracy semestralnej... jest pełna..."), nl,
            write("30 sekund emocjonalnego rollercoastera kończy się ogromną ulgą... uśmiechasz się!"), nl
        ),
        assertz(wie_o_pracy_semestralnej)
    ),
    assertz(sprawdzil_kieszenie_sala_glowna).

dzialanie(glowna_sala, sprawdz_kieszenie) :-
    sprawdzil_kieszenie_sala_glowna,
    write("Już sprawdziłeś kieszenie. Nic innego tam nie ma."), nl.

dzialanie(glowna_sala, podejdz_do_profesora) :-
    write("Podchodzisz do profesora siedzącego na wprost ciebie. Czeka na ciebie, i rozpoznaje cię. Witasz się."), nl,
    write("'I kto to przyszedł? Dzień dobry Panu.'- mówi profesor w nieco onieśmielającym tonie."),
    stan(notatki, Lista),
    length(Lista, X),
    (\+ wie_o_pracy_semestralnej ->
        write("'Będzie Pan tak tu stać? Czegoś Pan potrzebuje?'"), nl, nl,
        (X = 0 ->
            write("Nie wiesz co ciebie tu przyprowadziło, ale przez cały czas miałeś wrażenie, że musisz tu być."), nl,
            write("Odlatujesz myślami... gdzieś, ale nie wiesz gdzie. W tle słychać profesora coraz głośniej, ale nie wiesz o czym mówi."), nl,
            write("Powoli wracasz na Ziemię: widzisz profesora jak wstaje i wskazuje na drzwi. Każe tobie wyjść."), nl,
            write("Jesteś rozkojarzony. Twoje myśli błądzą w nieskończonej nicości. Próbujesz się uspokoić."), nl
        ;
            write("Nie wiesz w sumie co tu robisz."), nl,
            write("'To Pan wchodzi do mnie bez pojęcia co Pan w ogóle chce?'"), nl,
            write("No dokładnie!"), nl,
            write("'To mogę Panu powiedzieć, że ja na pewno chcę Pańskiej pracy semestralnej'"), nl,
            write("Naprawdę?"), nl
        )
        ;
        write("'Będzie Pan tak tu stać? Czegoś Pan potrzebuje?'"), nl, nl,
        write("Mówisz, że chcesz oddać pracę semestralną"), nl
    ),
    (X < 4 -> zle_zakonczenie(); dobre_zakonczenie()).

% Sprawdzenie zakończenia gry
dobre_zakonczenie() :-
    write("Bierzesz swoje notatki z kieszenie, i składasz je w jedną część. Profesor patrzy się na ciebie z lekkim zdziwieniem."), nl,
    write("Twoim oczom ukazuje się... twoja praca semstralna w pełnej postaci."), nl,
    write("'Wow... doceniam Pana determinację. Powiedziałbym że jest to niedorzeczne oddawać pracę w takim stanie, ale wygląda Pan na zmęczonego...'"), nl,
    write("Więc jest szansa?! Opłaciło się zbierać te notatki? Nie wiesz co myśleć, ale czekasz aż profesor skończy czytać pracę."), nl,
    read(_),
    shell(clear),
    write("Profesor wygląda raz na zażenowanego, raz na zaskoczonego, a nawet na zadowolonego."), nl,
    write("'Muszę Panu przyznać, że może praca idealna nie jest... ale zaliczyć, to Pan zaliczy.'"), nl,
    write("'A swoją drogą... no i jak Pańska wiedza? Powalczy Pan o lepszą ocenę?'"), nl,
    write("Starasz sobie przypomnieć co się dowiedziałeś... mówisz co wiesz, trochę też zmyślaśz, ale..."), nl,
    read(_),
    shell(clear),
    licznik_interakcji(L),
    Ocena is 3.0 + 0.5 * L,
    write("ZALICZASZ przedmiot z oceną "), write(Ocena).

zle_zakonczenie() :-
    write("Bierzesz swoje notatki z kieszeni, i składasz je w jedną czę-"), nl,
    write("O nie..."), nl,
    write("'I co ja mam z taką pracą zrobić? Nie czytam tego proszę Pana.'"), nl,
    write("Ale..."), nl,
    write("'Niestety nie ma żadnych 'ale' proszę Pana. Jak ja mam ocenić niepełną pracę? Miał Pan tyle czasu na oddanie.'"), nl,
    read(_),
    shell('clear'),
    write("NIE ZALICZASZ przedmiotu. Ocena końcowa: 2.0. Profesor wydaje się być na ciebie zdenerwowany."), nl,
    stan(notatki, Lista),
    length(Lista, N),
    write("Zebrałeś "), write(N), write("/4 notatek. Nie udało ci się skompletować pracy semestralnej.").

sprawdz(stan_notatek) :-
    stan(notatki, Lista),
    length(Lista, N),   % Liczymy liczbę notatek
    write("Aktualnie masz " ),
    write(N),
    write(" notatek."), nl.

% Uruchomienie gry
:- start.
