Object subclass: Game [
    | location money notes hasNumber visitedWilcza visitedHala visitedPark conversationDone visitedEiti
      interactionCounter talkCounter hasKey hasKeyPart1 hasKeyPart2 hasSecretKey checkedLockerRoom
      knowsAboutMissingKey knowsAboutSemesterWork checkedMainHallPockets greetedNobody approachedBar
      boughtWilczaNote viewedFountain pocketChecked pickedUpItems |

    Game class >> new [
        ^super new initialize
    ]

    initialize [
        location := TarasPKiN new.
        money := 0.
        notes := OrderedCollection new.
        hasNumber := false.
        visitedWilcza := false.
        visitedHala := false.
        visitedPark := false.
        conversationDone := false.
        visitedEiti := false.
        interactionCounter := 0.
        talkCounter := 0.
        hasKey := false.
        hasKeyPart1 := false.
        hasKeyPart2 := false.
        hasSecretKey := false.
        checkedLockerRoom := false.
        knowsAboutMissingKey := false.
        knowsAboutSemesterWork := false.
        checkedMainHallPockets := false.
        greetedNobody := false.
        approachedBar := false.
        boughtWilczaNote := false.
        viewedFountain := false.
        pocketChecked := false.
        pickedUpItems := false.
    ]

    changeLocation: newLocation [
        location := newLocation.
        self displayDescription.
        self displayAvailableActions.
    ]

    displayDescription [
        Transcript show: location description; cr.
    ]

    displayAvailableActions [
        Transcript show: 'Dostepne akcje:'; cr.
        location availableActionsFor: self do: [:action |
            Transcript show: '- '; show: action; cr.
        ].
        Transcript show: 'Aby wykonac dzialanie, wpisz: game performAction: #akcja'; cr.
    ]

    performAction: actionSymbol [
        location performAction: actionSymbol inGame: self.
    ]

    addMoney: amount [
        money := money + amount.
        Transcript show: 'Twoje fundusze to: '; show: money; show: ' zl'; cr.
    ]

    subtractMoney: amount [
        money := money - amount.
        Transcript show: 'Twoje fundusze to: '; show: money; show: ' zl'; cr.
    ]

    incrementInteractionCounter [
        interactionCounter := interactionCounter + 1.
    ]

    incrementTalkCounter [
        talkCounter := talkCounter + 1.
    ]

    "Gettery i settery dla zmiennych stanu"
    location [^location]
    money: anAmount [money := anAmount]
    notes: aCollection [notes := aCollection]
    hasKey: aBoolean [hasKey := aBoolean]
    hasKeyPart1: aBoolean [hasKeyPart1 := aBoolean]
    hasKeyPart2: aBoolean [hasKeyPart2 := aBoolean]
    pocketChecked [^pocketChecked]
    pocketChecked: aBoolean [pocketChecked := aBoolean]
    hasSecretKey: aBoolean [hasSecretKey := aBoolean]
    knowsAboutMissingKey: aBoolean [knowsAboutMissingKey := aBoolean]
    talkCounter [^talkCounter]

    checkNotes [
        Transcript show: 'Aktualnie masz '; show: notes size; show: ' notatek.'; cr.
    ]

    goodEnding [
        | grade |
        Transcript show: 'Bierzesz swoje notatki z kieszeni, i skladasz je w jedna czesc. Profesor patrzy sie na ciebie z lekkim zdziwieniem.'; cr.
        Transcript show: 'Twoim oczom ukazuje sie... twoja praca semestralna w pelnej postaci.'; cr.
        Transcript show: '"Wow... doceniam Pana determinacje. Powiedzialbym ze jest to niedorzeczne oddawac prace w takim stanie, ale wyglada Pan na zmeczonego..."'; cr.
        Transcript show: 'Wiec jest szansa?! Oplacilo sie zbierac te notatki? Nie wiesz co myslec, ale czekasz az profesor skonczy czytac prace.'; cr.
        Transcript show: 'Wpisz "true" i nacisnij Enter.'; cr.
        StdIn readLine.
        Transcript show: 'Profesor wyglada raz na zazenowanego, raz na zaskoczonego, a nawet na zadowolonego.'; cr.
        Transcript show: '"Musze Panu przyznac, ze moze praca idealna nie jest... ale zaliczyc, to Pan zaliczy."'; cr.
        Transcript show: '"A swoja droga... no i jak Panska wiedza? Powalczy Pan o lepsza ocene?"'; cr.
        Transcript show: 'Starasz sobie przypomniec co sie dowiedziales... mowisz co wiesz, troche tez zmyslasz, ale...'; cr.
        Transcript show: 'Wpisz "true" i nacisnij Enter.'; cr.
        StdIn readLine.
        grade := 3.0 + (0.5 * interactionCounter).
        Transcript show: 'ZALICZASZ przedmiot z ocena '; show: grade; cr.
        Transcript show: 'Zebrano wszystkie 4 czesci notatki. Skompletowano prace semestralna!'; cr.
        Transcript show: 'Znaleziono '; show: interactionCounter; show: ' z czterech dostepnych sekretnych interakcji.'; cr.
    ]

    badEnding [
        notes size > 0 ifTrue: [
            Transcript show: 'Bierzesz swoje notatki z kieszeni, i skladasz je w jedna cze-'; cr.
            Transcript show: 'O nie...'; cr.
            Transcript show: 'I co ja mam z taka praca zrobic? Nie czytam tego prosze Pana.'; cr.
            Transcript show: 'Ale...'; cr.
            Transcript show: 'Niestety nie ma zadnych "ale" prosze Pana. Jak ja mam ocenic niepelna prace? Mial Pan tyle czasu na oddanie.'; cr.
        ].
        Transcript show: 'Wpisz "true" i nacisnij Enter.'; cr.
        StdIn readLine.
        Transcript show: 'NIE ZALICZASZ przedmiotu. Ocena koncowa: 2.0. Profesor wydaje sie byc na ciebie zdenerwowany.'; cr.
        Transcript show: 'Zebrano '; show: notes size; show: '/4 notatek. Nie udalo ci sie skompletowac pracy semestralnej.'; cr.
        Transcript show: 'Znaleziono '; show: interactionCounter; show: ' z czterech dostepnych sekretnych interakcji.'; cr.
    ]
]

Object subclass: Location [
    description [
        ^'Brak opisu lokalizacji.'
    ]

    availableActionsFor: game [
        ^#()
    ]

    performAction: actionSymbol inGame: game [
        Transcript show: 'Akcja nieobslugiwana: '; show: actionSymbol; cr.
    ]
]

Location subclass: TarasPKiN [
    description [
        ^'Budzisz sie na tarasie PKiN. Okropnie boli cie glowa, szczegolnie, kiedy na twoje powieki padaja pierwsze promienie nowego dnia. Nagle czujesz dziabniecie. To golab, ktory zdecydowanie nie jest zadowolony z twojej obecnosci na jego terytorium. Co zrobic?'
    ]

    availableActionsFor: game [
        ^#(zajrzyjDoKieszeni rozejrzyjSie podejdzDoKrawedzi zejdzPoSchodach uzyjWindy)
    ]

    performAction: actionSymbol inGame: game [
        actionSymbol = #zajrzyjDoKieszeni ifTrue: [
            game pocketChecked ifFalse: [
                game pocketChecked: true.
                Transcript show: 'Siegasz do kieszeni i znajdujesz 20zl oraz notatke.'; cr.
                game addMoney: 20.
                game notes: (game notes add: 1; yourself).
            ] ifTrue: [
                Transcript show: 'Juz zajrzales do kieszeni, nic tam wiecej nie ma.'; cr.
            ].
        ].
        actionSymbol = #rozejrzyjSie ifTrue: [
            Transcript show: 'Widzisz panorame miasta. Slonce wschodzi nad Warszawa.'; cr.
        ].
        actionSymbol = #podejdzDoKrawedzi ifTrue: [
            Transcript show: 'Podchodzisz do krawedzi i odczuwasz lekki zawrot glowy.'; cr.
        ].
        actionSymbol = #uzyjWindy ifTrue: [
            Transcript show: 'Zjezdzasz winda prosto na dol do holu PKiN.'; cr.
            game changeLocation: (HolPKiN new).
        ].
        actionSymbol = #zejdzPoSchodach ifTrue: [
            Transcript show: 'Schodzisz schodami PKiN.'; cr.
            game changeLocation: (SchodyPKiN new).
        ].
    ]
]

Location subclass: SchodyPKiN [
    description [
        ^'Schodzac w dol robisz krotka przerwe, strasznie boli Cie glowa. Patrzac w dol zauwazasz lezace na podlodze pieniadze.'
    ]

    availableActionsFor: game [
        ^#(podniesPieniadze idzDalej)
    ]

    performAction: actionSymbol inGame: game [
        actionSymbol = #podniesPieniadze ifTrue: [
            game pickedUpItems ifTrue: [
                Transcript show: 'Nic tutaj juz nie ma.'; cr.
            ] ifFalse: [
                | amount |
                amount := 5 + (Random new next * 11) floor. "Losowa liczba od 5 do 15"
                game pickedUpItems: true.
                game addMoney: amount.
            ].
        ].
        actionSymbol = #idzDalej ifTrue: [
            Transcript show: 'Schodzisz schodami do holu PKiN.'; cr.
            game changeLocation: (HolPKiN new).
        ].
    ]
]

Location subclass: HolPKiN [
    description [
        ^'Glowa nadal boli cie nieublaganie. Wokol cicho, tylko portier siedzi za lada. Moze warto go zapytac o wczoraj?'
    ]

    availableActionsFor: game [
        ^#(porozmawiajZPortierem wyjdzNaZewnatrz udajSieDoSzatni)
    ]

    performAction: actionSymbol inGame: game [
        actionSymbol = #porozmawiajZPortierem ifTrue: [
            Transcript show: 'Portier patrzy na ciebie podejrzliwie, ale nic nie mowi.'; cr.
        ].
        actionSymbol = #wyjdzNaZewnatrz ifTrue: [
            Transcript show: 'Wychodzisz na zewnatrz, przed PKiN.'; cr.
            Transcript show: 'Wychodzac zaczepia cie dziwny chlopak, ktory mowi: ''O hej brachu, pamietasz co sie dzialo wczoraj w Hali Koszyki?'''; cr.
            game visitedHala: true.
            game changeLocation: (PrzedPKiN new).
        ].
        actionSymbol = #udajSieDoSzatni ifTrue: [
            Transcript show: 'Idziesz do szatni.'; cr.
            game changeLocation: (SzatniaPKiN new).
        ].
    ]
]

Location subclass: SzatniaPKiN [
    description [
        ^'Wyglada na to, ze kilka osob zapomnialo wziac plaszcz wychodzac. Moze byc trudno zgadnac, ktory jest moj.'
    ]

    availableActionsFor: game [
        ^#(wyjdzNaZewnatrz przeszukajKieszenie przeszukajPlaszcz)
    ]

    performAction: actionSymbol inGame: game [
        actionSymbol = #wyjdzNaZewnatrz ifTrue: [
            Transcript show: 'Wychodzisz z PKiN.'; cr.
            Transcript show: 'Wychodzac zaczepia cie dziwny chlopak, ktory mowi: ''O hej brachu, pamietasz co sie dzialo wczoraj w Hali Koszyki?'''; cr.
            game visitedHala: true.
            game changeLocation: (PrzedPKiN new).
        ].
        actionSymbol = #przeszukajKieszenie ifTrue: [
            Transcript show: 'Warto bylo przeszukac kieszenie jeszcze raz. Znajdujesz numerek.'; cr.
            game hasNumber: true.
        ].
        actionSymbol = #przeszukajPlaszcz ifTrue: [
            game hasNumber ifTrue: [
                Transcript show: 'Znajdujesz ulotke z oferta Happy Hours z baru w Hali Koszyki.'; cr.
            ] ifFalse: [
                Transcript show: 'Nie masz numerka, wiec nie wiesz, ktory plaszcz nalezy do ciebie.'; cr.
            ].
        ].
    ]
]

Location subclass: PrzedPKiN [
    description [
        ^'Jestes przed PKiN. Widok na miasto jest zapierajacy, mozesz ruszyc w rozne strony.'
    ]

    availableActionsFor: game [
        | actions |
        actions := OrderedCollection new.
        actions addAll: {#idzWStroneParku. #idzWStroneTaksowki. #spojrzNaUlotke}.

        game visitedHala ifTrue: [actions add: #idzDoHaliKoszyki].
        game visitedWilcza ifTrue: [actions add: #idzNaWilcza30].

        ^actions
    ]

    performAction: actionSymbol inGame: game [
        actionSymbol = #idzWStroneParku ifTrue: [
            game visitedPark ifTrue: [
                Transcript show: 'Odwiedziles juz park, nie masz ochoty znowu tam wracac...'; cr.
            ] ifFalse: [
                Transcript show: 'Idziesz w strone parku...'; cr.
                game changeLocation: (Park new).
            ].
        ].
        actionSymbol = #idzWStroneTaksowki ifTrue: [
            game money >= 20 ifTrue: [
                Transcript show: 'Wsiadasz do taksowki.'; cr.
                game changeLocation: (Taksowka new).
            ] ifFalse: [
                Transcript show: 'Nie masz wystarczajacej ilosci pieniedzy, aby skorzystac z taksowki.'; cr.
            ].
        ].
        actionSymbol = #spojrzNaUlotke ifTrue: [
            Transcript show: 'Znajdujesz ulotke z baru w Hali Koszyki z reklama Happy Hours. Moze warto sie tam udac?'; cr.
        ].
        actionSymbol = #idzDoHaliKoszyki ifTrue: [
            Transcript show: 'Postanawiasz pojsc do Hali Koszyki spacerujac, aby moc podziwiac budzaca sie Warszawe.'; cr.
            game changeLocation: (HalaKoszyki new).
        ].
        actionSymbol = #idzNaWilcza30 ifTrue: [
            Transcript show: 'Postanawiasz pojsc na Wilcza 30 spacerujac, aby moc podziwiac budzaca sie Warszawe.'; cr.
            game changeLocation: (Wilcza30 new).
        ].
    ]
]

Location subclass: Park [
    description [
        ^'Wchodzisz do Parku swietokrzyskiego. Powietrze jest rzeskie, a pierwsze promienie slonca oswietlaja puste alejki. W oddali slyszysz szum miasta, ale tutaj panuje dziwny spokoj. Na jednej z lawek siedzi mezczyzna owiniety w gruby plaszcz, z broda gesta jak historia tego miasta. Kiedy przechodzisz obok, unosi wzrok i usmiecha sie lekko. Obok widzisz budke, gdzie mozesz kupic nasiona dla golebi (-5zl).'
    ]

    availableActionsFor: game [
        ^#(usiadzNaLawce karmGolebie obejrzyjFontanne porozmawiajZNieznajomym idzPrzedPKiN)
    ]

    performAction: actionSymbol inGame: game [
        actionSymbol = #usiadzNaLawce ifTrue: [
            Transcript show: 'Siadasz na zimnej, metalowej lawce. Chlod poranka powoli przenika przez material twojego ubrania. Przymykasz oczy na chwile i wsluchujesz sie w dzwieki miasta. Czujesz chwilowy spokoj. Moze nawet zbyt wielki. Jakby swiat na moment sie zatrzymal, pozwalajac ci zlapac oddech przed kolejnym krokiem.'; cr.
        ].
        actionSymbol = #karmGolebie ifTrue: [
            game money >= 5 ifTrue: [
                Transcript show: 'Kupujesz nasiona i karmisz golebie. Jeden z nich wyglada znajomo... To ten, ktory dziabnal cie na tarasie!'; cr.
                game subtractMoney: 5.
            ] ifFalse: [
                Transcript show: 'Nie masz wystarczajaco pieniedzy, aby kupic chleb dla golebi.'; cr.
            ].
        ].
        actionSymbol = #obejrzyjFontanne ifTrue: [
            game viewedFountain ifTrue: [
                Transcript show: 'Ogladasz fontanne. Nic wiecej tam nie ma.'; cr.
            ] ifFalse: [
                | amount |
                amount := 2 + (Random new next * 9) floor. "Losowa liczba od 2 do 10"
                Transcript show: 'Ogladasz fontanne. Patrzysz na spokojna tafle. Znajdujesz kilka monet o lacznej wartosci '; show: amount; show: ' zl.'; cr.
                game viewedFountain: true.
                game addMoney: amount.
            ].
        ].
        actionSymbol = #porozmawiajZNieznajomym ifTrue: [
            game visitedWilcza ifFalse: [
                Transcript show: 'Witasz sie z nieznajomym.'; cr.
                Transcript show: '''Dzien dobry! Co u Pana slychac?'' - pyta sie ciebie nieznajomy z entuzjazmem'; cr.
                Transcript show: 'Rowno entuzjastycznie odpowiadasz, ze ''dobrze''... nawet jesli pytanie nie brzmialo ''jak sie czujesz'', ale kto by sie przejmowal.'; cr.
                Transcript show: 'Zaczynasz rozmowe z nieznajomym, az... tracisz czucie czasu. Ile rozmawialiscie? Nie wiesz.'; cr.
                Transcript show: '''Ja musze prosze Pana jeszcze na autobus zdazyc, ale milo sie z Panem rozmawialo!'' - nieznajomy zegna sie z toba: znowu entuzjastycznie!'; cr.
                Transcript show: '''I niech Pan pamieta o Wilczej 30! Warto tam zajrzec!'''; cr.
                Transcript show: '??? Moze o czyms wspomniales podczas rozmowy, co by skutkowaly w takiej prosbie, ale tego nie pamietasz'; cr.
                Transcript show: 'Masz wrazenie, ze cos wyniosles z tej konwersacji, aczkolwiek nie wiesz do konca co.'; cr.
                game visitedWilcza: true.
                game incrementInteractionCounter.
            ] ifTrue: [
                Transcript show: 'Witasz sie z nieznajomym. Entuzjastycznie machasz do niego.'; cr.
                game greetedNobody ifFalse: [
                    game greetedNobody: true.
                ] ifTrue: [
                    Transcript show: 'Czy wszystko dobrze?'; cr.
                ].
            ].
        ].
        actionSymbol = #idzPrzedPKiN ifTrue: [
            Transcript show: 'Wracasz przed PKiN'; cr.
            game visitedPark: true.
            game changeLocation: (PrzedPKiN new).
        ].
    ]
]

Location subclass: Taksowka [
    description [
        ^'Wsiadles do taksowki. Kierowca czeka na dalsze instrukcje.'
    ]

    availableActionsFor: game [
        | actions warunki |

        actions := OrderedCollection new.
        actions add: #porozmawiaj.

        warunki := {
            game visitedHala -> #pojedzDoHaliKoszyki.
            game visitedWilcza -> #pojedzNaWilcza30
        }.

        warunki do: [:par |
            par key ifTrue: [actions add: par value]
        ].

        ^actions
    ]

    performAction: actionSymbol inGame: game [
        actionSymbol = #pojedzDoHaliKoszyki ifTrue: [
            Transcript show: 'Jedziesz do Hali Koszyki.'; cr.
            game subtractMoney: 20.
            game changeLocation: (HalaKoszyki new).
        ].
        actionSymbol = #pojedzNaWilcza30 ifTrue: [
            Transcript show: 'Jedziesz na Wilcza 30.'; cr.
            game subtractMoney: 20.
            game changeLocation: (Wilcza30 new).
        ].
        actionSymbol = #porozmawiaj ifTrue: [
            Transcript show: 'Kierowca mowi: ''Ciezka noc, co? Wygladasz jakos tak wczorajszo. Zdecydowanie wczoraj poimprezowales.'''; cr.
        ].
    ]
]

Location subclass: Wilcza30 [
    description [
        ^'Stoisz przed drzwiami mieszkania na Wilczej 30.'
    ]

    availableActionsFor: game [
        ^#(zapukajDoDrzwi rozejrzyjSie idzDoHaliKoszyki)
    ]

    performAction: actionSymbol inGame: game [
        actionSymbol = #zapukajDoDrzwi ifTrue: [
            Transcript show: 'Otwiera ci nieznana osoba. ''Czekalem na ciebie.'''; cr.
            game changeLocation: (DomWilcza new).
        ].
        actionSymbol = #rozejrzyjSie ifTrue: [
            Transcript show: 'Wilcza 30. Stara kamienica z odrapanym numerem nad wejsciem.'; cr.
            Transcript show: 'Drzwi nosza slady zuzycia, jakby ktos niedawno probowal je sforsowac.'; cr.
            Transcript show: 'W srodku czuc wilgoc, kurz i zapach tanich papierosow.'; cr.
            Transcript show: 'Na skrzynkach pocztowych nazwiska lokatorow, ale jedno miejsce jest puste.'; cr.
        ].
        actionSymbol = #idzDoHaliKoszyki ifTrue: [
            Transcript show: 'Opuszczasz Wilcza 30 i idziesz w strone Hali Koszyki.'; cr.
            game changeLocation: (HalaKoszyki new).
        ].
    ]
]

Location subclass: DomWilcza [
    description [
        ^'Wchodzisz do srodka, w pokoju unosi sie zapach papierosow i starego drewna. Mezczyzna wskazuje na krzeslo, kazac ci usiasc. Nagle bierze jakas kartke ze stolu. Mowi: ''Potrzebujesz tego, ale za darmo ci tego nie oddam (-10zl).'''
    ]

    availableActionsFor: game [
        ^#(wykupNotatke opuscDom)
    ]

    performAction: actionSymbol inGame: game [
        actionSymbol = #wykupNotatke ifTrue: [
            game boughtWilczaNote ifTrue: [
                Transcript show: 'Osoba nie ma nic wiecej do sprzedania tobie. Po co mowila tobie ze cos ma?'; cr.
            ] ifFalse: [
                game money >= 10 ifTrue: [
                    Transcript show: 'Ciekawosc wziela gore i wykupiles ten kawalek papieru.'; cr.
                    game boughtWilczaNote: true.
                    game subtractMoney: 10.
                    game notes: (game notes add: (game notes size + 1); yourself).
                    game changeLocation: (Wilcza30 new).
                ] ifFalse: [
                    Transcript show: 'Kwota, o ktora prosi cie mezczyzna jest zdecydowanie za wysoka. Moze jeszcze tu wroce...'; cr.
                ].
            ].
        ].
        actionSymbol = #opuscDom ifTrue: [
            Transcript show: 'Postanowiles opuscic dom mezczyzny. Co jeszcze cie czeka?'; cr.
            game changeLocation: (Wilcza30 new).
        ].
    ]
]

Location subclass: HalaKoszyki [
    description [
        ^'Hala Koszyki tetni zyciem nawet o tej godzinie. Zapach kawy i swiezego pieczywa unosi sie w powietrzu, a ludzie smieja sie przy stolikach. Czujesz, ze byles tu wczoraj, ale wciaz nie pamietasz, co sie stalo.'
    ]

    availableActionsFor: game [
        ^#(podejdzDoBaru porozmawiajZGosciem wyjdzWStroneChinczyka)
    ]

    performAction: actionSymbol inGame: game [
        actionSymbol = #podejdzDoBaru ifTrue: [
            game approachedBar ifFalse: [
                Transcript show: 'Barman rozpoznaje cie i mowi, ze wczoraj zostawiles cos waznego.'; cr.
                Transcript show: 'Wrecza ci kolejna czesc notatki i wspomina o chinskiej restauracji, do ktorej sie wybierales.'; cr.
                game approachedBar: true.
                game notes: (game notes add: (game notes size + 1); yourself).
            ] ifTrue: [
                Transcript show: 'Barman nie ma nic do wreczenia. Odchodzisz'; cr.
            ].
        ].
        actionSymbol = #porozmawiajZGosciem ifTrue: [
            Transcript show: 'Tajemniczy rozmowca wspomina o dziwnym incydencie, ktorego byl swiadkiem - ktos potracil cie szybko wychodzac.'; cr.
        ].
        actionSymbol = #wyjdzWStroneChinczyka ifTrue: [
            Transcript show: 'Idziesz do chinskiej restauracji.'; cr.
            game changeLocation: (Chinczyk new).
        ].
    ]
]
