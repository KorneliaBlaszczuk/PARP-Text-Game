% Początkowy stan gracza
:- dynamic lokalizacja/1.
:- dynamic stan/2.
:- dynamic dzialanie/2.
:- dynamic zajrzano_do_kieszeni/0.

lokalizacja(start).
stan(pieniadze, 0).
stan(notatki, []).
stan(numerek, nie).
stan(wilcza, nie).
stan(hala_koszyki, nie).
stan(park, nie).
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
akcje(wilcza_30, [zapukaj_do_drzwi, rozejrzyj_sie]).
akcje(dom_wilcza, [wykup_notatke, opusc_dom]).
akcje(hala_koszyki, [podejdz_do_baru, porozmawiaj_z_gosciem, wyjdz_w_strone_chinczyka]).
akcje(chinczyk, [porozmawiaj_z_wlascicielem, usiadz_przy_stoliku]).
akcje(eiti, [zajrzyj_do_laboratorium, idz_do_gg_pw]).
akcje(gg_pw, [przeszukaj_teren, sprawdz_tablice_ogloszen]).
akcje(glowna_sala, [odczytaj_koperte]).

dostepna_taksowka(porozmawiaj).
dostepna_taksowka(pojedz_do_hali_koszyki) :- stan(hala_koszyki, tak).
dostepna_taksowka(pojedz_na_wilcza_30) :- stan(wilcza, tak).

dostępny_pkin(idz_w_strone_parku).
dostępny_pkin(idz_w_strone_taksowki).
dostępny_pkin(spojrz_na_ulotke).
dostępny_pkin(idz_do_hali_koszyki) :- stan(hala_koszyki, tak).
dostępny_pkin(idz_na_wilcza_30) :- stan(wilcza, tak).

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

% Uproszczone wywołanie akcji
dzialanie(Akcja) :-
    lokalizacja(Lokalizacja),
    dzialanie(Lokalizacja, Akcja).

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
    write("Jesteś w Gmachu Głównym Politechniki Warszawskiej. Wszędzie pełno studentów i nauczycieli."), nl.

opis(glowna_sala) :-
    write("Jesteś w głównej sali. Czas na końcową decyzję i oddanie pracy semestralnej."), nl.

% W przypadku, gdy brak opisu dla lokalizacji
opis(_) :-
    write("Nie ma opisanego miejsca."), nl.

% Opis początkowy gry
start :-
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
    dodaj(10).

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
    retract(stan(wilcza, nie)), % Usuwamy stary stan
    assertz(stan(wilcza, tak)), % Ustawiamy nowy stan
    write("Wilcza 30. To tam znajdziesz odpowiedzi. Ale uważaj… nie każda prawda przynosi ulgę."), nl.

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
    stan(pieniadze, ObecnePieniadze),
    ObecnePieniadze >= 10,
    write("Ciekawość wzieła górę i wykupiłeś ten kawałek papieru."), nl,
    odejmij(10),
    retract(stan(notatki, Lista)),  % Pobieramy obecną listę notatek
    length(Lista, N),               % Sprawdzamy, ile jest notatek
    NowaNotatka is N + 1,           % Nowa notatka dostaje numer N+1
    assertz(stan(notatki, [NowaNotatka | Lista])), % Aktualizujemy stan
    zmien_lokalizacje(wilcza_30).

dzialanie(dom_wilcza, wykup_notatke) :-
    write("Kwota, o którą prosi cię mężczyzna jest zdecydowanie za wysoka. Może jeszcze tu wrócę..."), nl.

dzialanie(dom_wilcza, opusc_dom) :-
    write("Postanowiłeś opuścić dom mężczyzny. Co jeszcze cię czeka?"), nl,
    zmien_lokalizacje(wilcza_30).

% Hala Koszyki
dzialanie(hala_koszyki, podejdz_do_baru) :-
    write("Barman rozpoznaje cię i mówi, że wczoraj zostawiłeś coś ważnego."), nl,
    write("Wręcza ci kolejną część notatki i wspomina o chińskiej restauracji, do której się wybierałeś."), nl,
    retract(stan(notatki, Lista)),  % Pobieramy obecną listę notatek
    length(Lista, N),               % Sprawdzamy, ile jest notatek
    NowaNotatka is N + 1,           % Nowa notatka dostaje numer N+1
    assertz(stan(notatki, [NowaNotatka | Lista])). % Aktualizujemy stan

dzialanie(hala_koszyki, porozmawiaj_z_gosciem) :-
    write("Tajemniczy rozmówca wspomina o dziwnym incydencie, którego był świadkiem - ktoś potrącił cię szybko wychodząc."), nl.

dzialanie(hala_koszyki, wyjdz_w_strone_chinczyka) :-
    write("Idziesz do chińskiej restauracji."), nl,
    zmien_lokalizacje(chinczyk).

% Chińczyk
dzialanie(chinczyk, porozmawiaj_z_wlascicielem) :-
    write("Pamięta cię! Wspomina, że wczoraj zostawiłeś coś przy stoliku."), nl,
    write("Wskaże ci go jedynie, jeśli kupisz coś (10 zł), przecież za darmo nie możesz siedzieć w lokalu!"), nl.

dzialanie(chinczyk, kup_cos) :-
    stan(pieniadze, ObecnePieniadze),
    ObecnePieniadze >= 10,  % Sprawdzamy, czy mamy wystarczająco pieniędzy
    stan(eiti, nie),         % Sprawdzamy, czy nie kupiliśmy wcześniej
    retract(stan(pieniadze, ObecnePieniadze)),  % Usuwamy stary stan pieniędzy
    NowePieniadze is ObecnePieniadze - 10,      % Zmniejszamy o 10 zł
    assertz(stan(pieniadze, NowePieniadze)),     % Ustawiamy nowy stan pieniędzy
    assertz(stan(eiti, tak)),   % Ustawiamy stan eiti na 'tak'
    write("Znajdziesz tam tajemniczą wiadomość „EITI” napisaną na odwrocie serwetki."), nl.

dzialanie(chinczyk, kup_cos) :-
    stan(pieniadze, ObecnePieniadze),
    ObecnePieniadze < 10,  % Sprawdzamy, czy mamy wystarczająco pieniędzy
    write("Nie masz tyle forsy! Musisz mieć 10 zł, aby kupić coś."), nl.

dzialanie(chinczyk, kup_cos) :-
    stan(eiti, nie),  % Sprawdzamy, czy najpierw rozmawialiśmy z właścicielem
    write("Najpierw porozmawiaj z właścicielem, aby odblokować opcję 'Kup coś'."), nl.

dzialanie(chinczyk, idz_do_gg_pw) :-
    write("Idziesz do Gmachu Głównego PW."), nl,
    zmien_lokalizacje(gg_pw).

dzialanie(chinczyk, idz_na_weiti) :-
    write("Idziesz na wydział EITI."), nl,
    zmien_lokalizacje(eiti).

% EITI
dzialanie(eiti, zajrzyj_do_laboratorium) :-
    write("Wchodzisz do laboratorium i widzisz profesorów."), nl.

dzialanie(eiti, idz_do_gg_pw) :-
    write("Idziesz do Gmachu Głównego PW."), nl,
    zmien_lokalizacje(gg_pw).

% GG PW
dzialanie(gg_pw, przeszukaj_teren) :-
    write("Szukasz wskazówek..."), nl.

dzialanie(gg_pw, sprawdz_tablice_ogloszen) :-
    write("Na tablicy ogłoszeń widzisz informację o terminie oddania pracy."), nl.

% Główna sala
dzialanie(glowna_sala, odczytaj_koperte) :-
    write("Otwierasz kopertę i znajdujesz ostateczną wskazówkę."), nl.

% Sprawdzenie zakończenia gry
dobre_zakonczenie :-
    stan(notatki, Lista),
    length(Lista, 5),
    write("Gratulacje! Oddałeś pracę semestralną i zdałeś przedmiot!"), nl.

sprawdz(stan_notatek) :-
    stan(notatki, Lista),
    length(Lista, N),   % Liczymy liczbę notatek
    write("Aktualnie masz " ),
    write(N),
    write(" notatek."), nl.

% Uruchomienie gry
:- start.
