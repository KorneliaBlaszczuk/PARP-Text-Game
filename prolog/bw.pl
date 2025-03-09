% Początkowy stan gracza
:- dynamic lokalizacja/1.
:- dynamic stan/2.

lokalizacja(start).
stan(pieniadze, 0).
stan(notatki, []).

% Definicja dostępnych akcji dla każdej lokalizacji
akcje(taras_pkin, [zajrzyj_do_kieszeni, rozejrzyj_sie, podejdz_do_krawedzi, zejdz_po_schodach, uzyj_windy]).
akcje(schody_pkin, [podnies_pieniadze, idz_dalej]).
akcje(hol_pkin, [porozmawiaj_z_portierem, wyjdz_na_zewnatrz, udaj_sie_do_szatni]).
akcje(przed_pkin, [idz_w_strone_parku, idz_w_strone_taksowki, spojrz_na_ulotke]).
akcje(taksowka, [pojedz_do_hali_koszyki, pojedz_na_wilcza_30, porozmawiaj]).
akcje(wilcza_30, [zapukaj_do_drzwi]).
akcje(hala_koszyki, [podejdz_do_baru, porozmawiaj_z_gosciem, wyjdz_w_strone_chinczyka]).
akcje(chinczyk, [porozmawiaj_z_wlascicielem, usiadz_przy_stoliku]).
akcje(eiti, [zajrzyj_do_laboratorium, idz_do_gg_pw]).
akcje(gg_pw, [przeszukaj_teren, sprawdz_tablice_ogloszen]).
akcje(glowna_sala, [odczytaj_koperte]).

% Zmiana stanu pieniędzy
dodaj(Kwota) :-
    stan(pieniadze, ObecnePieniadze), % Pobieramy obecny stan pieniędzy
    NowyStan is ObecnePieniadze + Kwota, % Dodajemy x zł do obecnego stanu
    retract(stan(pieniadze, ObecnePieniadze)), % Usuwamy stary stan
    assertz(stan(pieniadze, NowyStan)), % Dodajemy nowy stan
    write("Twoje fundusze to: "), % Wyświetlamy komunikat
    write(NowyStan), nl. % Wyświetlamy nowy stan portfela

% Opis początkowy gry
start :-
    write("Budzisz się na tarasie PKiN. Okropnie boli cię głowa, szczególnie, kiedy na twoje powieki padają pierwsze promienie nowego dnia."), nl,
    write("Nagle czujesz dziabnięcie. To gołąb, który zdecydowanie nie jest zadowolony z twojej obecności na jego terytorium. Co zrobić?"), nl,
    zmien_lokalizacje(taras_pkin).

% Uproszczone wywołanie akcji
dzialanie(Akcja) :-
    lokalizacja(Lokalizacja),
    dzialanie(Lokalizacja, Akcja).

% Akcje dostępne na tarasie PKiN
dzialanie(taras_pkin, zajrzyj_do_kieszeni) :-
    write("Sięgasz do kieszeni i znajdujesz 20 zł oraz notatkę."), nl,
    retract(stan(pieniadze, _)),
    assertz(stan(pieniadze, 20)),
    retract(stan(notatki, Lista)),
    assertz(stan(notatki, [1 | Lista])).

dzialanie(taras_pkin, rozejrzyj_sie) :-
    write("Widzisz panoramę miasta. Słońce wschodzi nad Warszawą."), nl.

dzialanie(taras_pkin, uzyj_windy) :-
    write("Zjeżdzasz windą prosto na dół do holu PKiN."), nl.
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
    zmien_lokalizacje(przed_pkin).

dzialanie(hol_pkin, udaj_sie_do_szatni) :-
    write("Idziesz do szatni."), nl,
    zmien_lokalizacje(szatnia).

% Przed PKiN
dzialanie(przed_pkin, idz_w_strone_parku) :-
    write("Idziesz w stronę parku..."), nl,
    zmien_lokalizacje(park).

dzialanie(przed_pkin, idz_w_strone_taksowki) :-
    write("Wsiadasz do taksówki."), nl,
    zmien_lokalizacje(taksowka).

dzialanie(przed_pkin, spojrz_na_ulotke) :-
    write("Na ulotce napisano: 'Czy pamiętasz, co miałeś zrobić?'"), nl.

% Taksówka
dzialanie(taksowka, pojedz_do_hali_koszyki) :-
    write("Jedziesz do Hali Koszyki."), nl,
    zmien_lokalizacje(hala_koszyki).

dzialanie(taksowka, pojedz_na_wilcza_30) :-
    write("Jedziesz na Wilczą 30."), nl,
    zmien_lokalizacje(wilcza_30).

dzialanie(taksowka, porozmawiaj) :-
    write("Kierowca mówi: 'Ciężka noc, co?'"), nl.

% Wilcza 30
dzialanie(wilcza_30, zapukaj_do_drzwi) :-
    write("Otwiera ci nieznana osoba. 'Czekałem na ciebie.'"), nl.

% Hala Koszyki
dzialanie(hala_koszyki, podejdz_do_baru) :-
    write("Podchodzisz do baru i zamawiasz kawę."), nl.

dzialanie(hala_koszyki, porozmawiaj_z_gosciem) :-
    write("Gość mówi: 'Masz już wszystko, czego potrzebujesz?'"), nl.

dzialanie(hala_koszyki, wyjdz_w_strone_chinczyka) :-
    write("Idziesz do chińskiej restauracji."), nl,
    zmien_lokalizacje(chinczyk).

% Chińczyk
dzialanie(chinczyk, porozmawiaj_z_wlascicielem) :-
    write("Właściciel mówi: 'Zjadłbyś coś?'"), nl.

dzialanie(chinczyk, usiadz_przy_stoliku) :-
    write("Siadasz przy stoliku i zamawiasz danie dnia."), nl.

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

% Funkcja zmieniająca lokalizację i wypisująca dostępne akcje
zmien_lokalizacje(NowaLokalizacja) :-
    retract(lokalizacja(_)),
    assertz(lokalizacja(NowaLokalizacja)),
    akcje(NowaLokalizacja, Akcje),
    write("Dostępne akcje w tej lokalizacji: "), nl,
    wypisz_akcje(Akcje).

% Funkcja wypisująca akcje
wypisz_akcje([]).
wypisz_akcje([Akcja|Reszta]) :-
    write("- "), write(Akcja), nl,
    wypisz_akcje(Reszta).

% Uruchomienie gry
:- start.
