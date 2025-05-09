Object subclass: Game [
    | location money notes hasNumber visitedWilcza visitedHala visitedPark conversationDone visitedEiti
      interactionCounter talkCounter hasKey hasKeyPart1 hasKeyPart2 hasSecretKey checkedLockerRoom
      knowsAboutMissingKey knowsAboutSemesterWork checkedMainHallPockets greetedNobody approachedBar
      boughtWilczaNote viewedFountain pocketChecked pickedUpItems gameOver visitedWilcza30|

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
        visitedWilcza30 := false.
        pocketChecked := false.
        pickedUpItems := false.
        gameOver := false.
    ]

    start [
        self gameLoop.
    ]

    gameLoop [
        | input |
        self showFullLocationInfo. "Pełna informacja tylko przy pierwszym wejściu"

        [gameOver] whileFalse: [
            input := self getInput.
            (self tryPerformAction: input) ifFalse: [
                'Nie rozpoznano akcji!' displayNl.
            ].
        ].
        self endGame.
    ]

    showFullLocationInfo [
        '===== LOKALIZACJA =====' displayNl.
        '' displayNl.
        location description displayNl.
        '' displayNl.
        'DOSTĘPNE AKCJE:' displayNl.
        '' displayNl.
        location availableActionsFor: self do: [:action |
            ' * ' display.
            action displayNl.
        ].
        '' displayNl.
    ]

    getInput [
        Transcript show: 'Wpisz akcję: '; flush.
        ^ stdin nextLine asString
    ]

    tryPerformAction: inputString [
        | actionSymbol |
        actionSymbol := inputString asSymbol.

        location availableActionsFor: self do: [:availableAction |
            (availableAction asSymbol = actionSymbol) ifTrue: [
                '' displayNl.
                '>>> Wykonuję: ' display. availableAction displayNl. '' displayNl.
                location performAction: actionSymbol inGame: self.
                ^ true
            ].
        ].
        ^ false
    ]

    endGame [
        Transcript show: 'Koniec gry!'; cr.
    ]

    changeLocation: newLocation [
        location := newLocation.
        self showFullLocationInfo.
    ]


    performAction: actionSymbol [
        location performAction: actionSymbol inGame: self.
    ]

    addMoney: amount [
        money := money + amount.
        "Zmieniamy sposób wyświetlania liczby"
        ('Twoje fundusze to: %1 zl' % {money}) displayNl.
    ]

    subtractMoney: amount [
        money := money - amount.
        ('Twoje fundusze to: %1 zl' % {money}) displayNl.
    ]

    incrementInteractionCounter [
        interactionCounter := interactionCounter + 1.
    ]

    incrementTalkCounter [
        talkCounter := talkCounter + 1.
    ]

    "Gettery i settery dla zmiennych stanu"
    location [^location]
    money [^money]
    money: anAmount [money := anAmount]
    notes [
        ^ notes
    ]
    notes: aCollection [
        notes := aCollection
    ]
    hasKey: aBoolean [hasKey := aBoolean]
    hasKeyPart1: aBoolean [hasKeyPart1 := aBoolean]
    hasKeyPart2: aBoolean [hasKeyPart2 := aBoolean]
    pocketChecked [^pocketChecked]
    pocketChecked: aBoolean [pocketChecked := aBoolean]
    hasSecretKey: aBoolean [hasSecretKey := aBoolean]
    knowsAboutMissingKey: aBoolean [knowsAboutMissingKey := aBoolean]
    talkCounter [^talkCounter]
    pickedUpItems [^ pickedUpItems]
    pickedUpItems: aBoolean [pickedUpItems := aBoolean]
    visitedHala [^ visitedHala]
    visitedHala: aBoolean [visitedHala := aBoolean]
    hasNumber [^ hasNumber]
    hasNumber: aBoolean [hasNumber := aBoolean]
    visitedWilcza [^ visitedWilcza]
    visitedWilcza: aBoolean [visitedWilcza := aBoolean]
    visitedPark [^ visitedPark]
    visitedPark: aBoolean [visitedPark := aBoolean]
    viewedFountain [^ viewedFountain]
    viewedFountain: aBoolean [viewedFountain := aBoolean]
    boughtWilczaNote [^ boughtWilczaNote]
    boughtWilczaNote: aBoolean [boughtWilczaNote := aBoolean]
    approachedBar [^ approachedBar]
    approachedBar: aBoolean [approachedBar := aBoolean]
    visitedWilcza30 [^ visitedWilcza30]
    visitedWilcza30: aBoolean [visitedWilcza30 := aBoolean]
    conversationDone [^ conversationDone]
    conversationDone: aBoolean [conversationDone := aBoolean]
    visitedEiti [^ visitedEiti]
    visitedEiti: aBoolean [visitedEiti := aBoolean]
    checkedLockerRoom [^ checkedLockerRoom]
    checkedLockerRoom: aBoolean [checkedLockerRoom := aBoolean]

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

    availableActionsFor: game do: aBlock [
        #('zajrzyjDoKieszeni' 'rozejrzyjSie' 'podejdzDoKrawedzi' 'zejdzPoSchodach' 'uzyjWindy') asOrderedCollection
            do: [ :akcja | aBlock value: akcja ].
    ]

    performAction: actionSymbol inGame: game [
        actionSymbol = #zajrzyjDoKieszeni ifTrue: [
            game pocketChecked ifFalse: [
                game pocketChecked: true.
                'Siegasz do kieszeni i znajdujesz 20zl oraz notatke.' displayNl.
                game addMoney: 20.
                game notes: (game notes add: 1; yourself).  "Poprawiona linia"
                ^ true
            ] ifTrue: [
                'Juz zajrzales do kieszeni, nic tam wiecej nie ma.' displayNl.
                ^ true
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

    availableActionsFor: game do: aBlock [
        ^#('podniesPieniadze' 'idzDalej') asOrderedCollection
            do: [ :akcja | aBlock value: akcja ].
    ]

    performAction: actionSymbol inGame: game [
        actionSymbol = #podniesPieniadze ifTrue: [
            (game pickedUpItems) ifTrue: [
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

    availableActionsFor: game do: aBlock [
        ^#('porozmawiajZPortierem' 'wyjdzNaZewnatrz' 'udajSieDoSzatni') asOrderedCollection
            do: [ :akcja | aBlock value: akcja ].
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

    availableActionsFor: game do: aBlock [
        ^#('wyjdzNaZewnatrz' 'przeszukajKieszenie' 'przeszukajPlaszcz') asOrderedCollection
            do: [ :akcja | aBlock value: akcja ].
    ]

    performAction: actionSymbol inGame: game [
        actionSymbol = #wyjdzNaZewnatrz ifTrue: [
            Transcript show: 'Wychodzisz z PKiN.'; cr.
            Transcript show: 'Wychodzac zaczepia cie dziwny chlopak, ktory mowi: ''O hej brachu, pamietasz co sie dzialo wczoraj w Hali Koszyki?'''; cr.
            game visitedHala: true.
            game changeLocation: (PrzedPKiN new).
            ^ true
        ].
        actionSymbol = #przeszukajKieszenie ifTrue: [
            Transcript show: 'Warto bylo przeszukac kieszenie jeszcze raz. Znajdujesz numerek.'; cr.
            game hasNumber: true.
            ^ true
        ].
        actionSymbol = #przeszukajPlaszcz ifTrue: [
            game hasNumber ifTrue: [
                Transcript show: 'Znajdujesz ulotke z oferta Happy Hours z baru w Hali Koszyki.'; cr.
            ] ifFalse: [
                Transcript show: 'Nie masz numerka, wiec nie wiesz, ktory plaszcz nalezy do ciebie.'; cr.
            ].
            ^ true
        ].
        ^ false
    ]
]

Location subclass: PrzedPKiN [
    description [
        ^'Jestes przed PKiN. Widok na miasto jest zapierajacy, mozesz ruszyc w rozne strony.'
    ]

    availableActionsFor: game do: aBlock [
        #('idzWStroneParku' 'idzWStroneTaksowki' 'spojrzNaUlotke') do: [:akcja |
            aBlock value: akcja
        ].

        game visitedHala ifTrue: [
            aBlock value: 'idzDoHaliKoszyki'
        ].

        game visitedWilcza ifTrue: [
            aBlock value: 'idzNaWilcza30'
        ].
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

    availableActionsFor: game do: aBlock [
        ^#('usiadzNaLawce' 'karmGolebie' 'obejrzyjFontanne' 'porozmawiajZNieznajomym' 'idzPrzedPKiN') asOrderedCollection
            do: [ :akcja | aBlock value: akcja ].
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
                'Ogladasz fontanne. Patrzysz na spokojna tafle. Znajdujesz kilka monet o lacznej wartosci ' display.
                amount display. ' zl.' displayNl.
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

    availableActionsFor: game do: aBlock [
        aBlock value: 'porozmawiaj'.
        (game respondsTo: #visitedHala) ifTrue: [
            game visitedHala ifTrue: [
                aBlock value: 'pojedzDoHaliKoszyki'
            ].
        ].
        (game respondsTo: #visitedWilcza) ifTrue: [
            game visitedWilcza ifTrue: [
                aBlock value: 'pojedzNaWilcza30'
            ].
        ].
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

    availableActionsFor: game do: aBlock [
        ^#('zapukajDoDrzwi' 'rozejrzyjSie' 'idzDoHaliKoszyki') asOrderedCollection
            do: [ :akcja | aBlock value: akcja ].
    ]

    performAction: actionSymbol inGame: game [
        actionSymbol = #zapukajDoDrzwi ifTrue: [
            (game visitedWilcza30) ifTrue: [
                'Drzwi są zamknięte. Nikt nie odpowiada.' displayNl.
            ] ifFalse: [
                'Otwiera ci nieznana osoba. ''Czekalem na ciebie.''' displayNl.
                game visitedWilcza30: true.
                game changeLocation: (DomWilcza new).
            ].
            ^ true
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

    availableActionsFor: game do: aBlock [
        ^#('wykupNotatke' 'opuscDom') asOrderedCollection
            do: [ :akcja | aBlock value: akcja ].
    ]

    performAction: actionSymbol inGame: game [
        actionSymbol = #wykupNotatke ifTrue: [
            game boughtWilczaNote ifTrue: [
                Transcript show: 'Osoba nie ma nic wiecej do sprzedania tobie.'; cr.
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

    availableActionsFor: game do: aBlock [
        ^#('podejdzDoBaru' 'porozmawiajZGosciem' 'wyjdzWStroneChinczyka') asOrderedCollection
            do: [ :akcja | aBlock value: akcja ].
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

Location subclass: Chinczyk [
    description [
        ^'Lokal jest niewielki, ale przytulny. Na scianach wisza chinskie lampiony, a w tle cicho gra azjatycka muzyka. Wlasciciel patrzy na ciebie z zainteresowaniem, jakby cie juz widzial.'
    ]

    availableActionsFor: game do: aBlock [
        ^#('porozmawiajZWlascicielem' 'kupCos' 'idzDoGgPw' 'idzNaWeiti') asOrderedCollection
            do: [ :akcja | aBlock value: akcja ].
    ]

    performAction: actionSymbol inGame: game [
        actionSymbol = #porozmawiajZWlascicielem ifTrue: [
            game conversationDone ifFalse: [
                Transcript show: 'Pamieta cie! Wspomina, ze wczoraj zostawiles cos przy stoliku.'; cr.
                Transcript show: 'Wskaze ci go jedynie, jesli kupisz cos (10zl), przeciez za darmo nie mozesz siedziec w lokalu!'; cr.
                game conversationDone: true.
            ] ifTrue: [
                Transcript show: 'Podchodzisz do wlasciciela jeszcze raz. Dalej cie pamieta.'; cr.
                game visitedEiti ifTrue: [
                    Transcript show: 'Nic tobie nie wskazuje. Zaczynasz sie zastanawiac co wlasciwie chcesz od wlasciciela.'; cr.
                ] ifFalse: [
                    Transcript show: 'Przypomina tobie o czyms przy stoliku. Jak cos kupisz (10zl), to wskaze tobie ten tajemniczy przedmiot.'; cr.
                ].
            ].
        ].
        actionSymbol = #kupCos ifTrue: [
            game conversationDone ifFalse: [
                Transcript show: 'Najpierw porozmawiaj z wlascicielem.'; cr.
            ] ifTrue: [
                game money >= 10 ifTrue: [
                    game visitedEiti ifFalse: [
                        game subtractMoney: 10.
                        game visitedEiti: true.
                        Transcript show: 'Znajdujesz tajemnicza wiadomosc "EITI" napisana na odwrocie serwetki.'; cr.
                    ] ifTrue: [
                        Transcript show: 'Wlasciciel nie ma tobie nic ciekawego do sprzedania... no w sumie oprocz jedzenia.'; cr.
                    ].
                ] ifFalse: [
                    Transcript show: 'Nie masz tyle forsy! Musisz miec 10zl, aby kupic cos.'; cr.
                ].
            ].
        ].
        actionSymbol = #idzDoGgPw ifTrue: [
            Transcript show: 'Idziesz do Gmachu Glownego PW.'; cr.
            game changeLocation: (GgPw new).
        ].
        actionSymbol = #idzNaWeiti ifTrue: [
            Transcript show: 'Idziesz na wydzial EITI.'; cr.
            game pickedUpItems: false.
            game changeLocation: (Eiti new).
        ].
    ]
]

Location subclass: Eiti [
    description [
        ^'Jestes na Wydziale EITI. Laboratoria i studenci dookola.'
    ]

    availableActionsFor: game do: aBlock [
        ^#('zajrzyjDoLaboratorium' 'zajrzyjDoSzatni' 'idzDoGgPw') asOrderedCollection
            do: [ :akcja | aBlock value: akcja ].
    ]

    performAction: actionSymbol inGame: game [
        actionSymbol = #zajrzyjDoLaboratorium ifTrue: [
            game pickedUpItems ifFalse: [
                Transcript show: 'Wchodzisz do laboratorium i widzisz profesorow.'; cr.
                Transcript show: 'Witasz sie i powoli wchodzisz do srodka. Studentow tu jeszcze nie ma, ale zapewne beda tu niedlugo jakies zajecia.'; cr.
                Transcript show: '"Szuka Pan czegos?" - pyta profesor. Odpowiadasz ze tak, cos zostawiles (dobrze wiesz ze to nieprawda)'; cr.
                Transcript show: 'Chociaz... ha, ciekawe. Widzisz kawalek notatki. Bierzesz ja - moze sie tobie przydac.'; cr.
                game pickedUpItems: true.
                game notes: (game notes add: (game notes size + 1); yourself).
            ] ifTrue: [
                Transcript show: 'Wchodzisz do laboratorium i... nie, nie wchodzisz do laboratorium.'; cr.
            ].
        ].
        actionSymbol = #zajrzyjDoSzatni ifTrue: [
            game checkedLockerRoom ifFalse: [
                Transcript show: 'Podchodzisz, a Pan z szatni wyjmuje juz numerek, i chce go tobie wreczyc. Nie bierzesz numerka, ale rozgladasz sie wokol'; cr.
                Transcript show: '"Czy w czyms Panu pomoc???" - zapytany odpowiadasz, ze po prostu patrzysz czy czegos nie zapomniales'; cr.
                Transcript show: '"Cos... ostatnio wydawal sie Pan jakis rozkojarzony, o ile mnie pamiec nie myli..."'; cr.
                Transcript show: '"hmmmm..." - Pan rozglada sie chwile, patrzy pod swoje biurko, i mowi:'; cr.
                Transcript show: '"Chyba to moze byc Pana. Niech Pan sprawdzi - lezy tu od jakiegos czasu."'; cr.
                Transcript show: 'Dostajesz ladnie ucieta sciage. Spogladasz na zawartosc, i rzeczywiscie: cos kojarzysz. Moze to sie przydac...'; cr.
                game incrementInteractionCounter.
                game checkedLockerRoom: true.
            ] ifTrue: [
                Transcript show: 'Patrzysz jeszcze raz na szatnie, i nic nietypowego nie zauwazasz. Predko odchodzisz'; cr.
            ].
        ].
        actionSymbol = #idzDoGgPw ifTrue: [
            Transcript show: 'Idziesz do Gmachu Glownego PW.'; cr.
            game changeLocation: (GgPw new).
        ].
    ]
]

| game |
game := Game new.
game start.
