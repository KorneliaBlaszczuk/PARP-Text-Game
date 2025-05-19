Object subclass: Game [
    | location money notes hasNumber visitedWilcza visitedHala visitedPark conversationDone visitedEiti
      interactionCounter talkCounter hasKey hasKeyPart1 hasKeyPart2 hasSecretKey checkedLockerRoom
      knowsAboutMissingKey knowsAboutSemesterWork checkedMainHallPockets greetedNobody approachedBar
      boughtWilczaNote viewedFountain pocketChecked pickedUpItems gameOver visitedWilcza30|

    Game class >> new [
        ^super new initialize
    ]

    initialize [
        location := TarasPKiN new.              "uzywane w lokalizacji"
        money := 0.                             "pieniadze"
        notes := OrderedCollection new.         "notatki"
        hasNumber := false.                     "szatnia_pkin"
        visitedWilcza := false.                 "chyba powinno byc knowsAboutWilcza?"
        visitedHala := false.                   "tu knowsAboutHalaKoszyki?"
        visitedPark := false.                   "blokada po wizycie w parku"
        conversationDone := false.              "chinczyk, rozmowa przed kupnem notatki"
        visitedEiti := false.                   "knowsAboutEiti?"
        interactionCounter := 0.                "do oceny koncowej"
        talkCounter := 0.                       "DO GGPW, licznik rozmow"
        hasKey := false.                        "DO GGPW, klucz do sali glownej"
        hasKeyPart1 := false.                   "DO GGPW, klucz do sekretnej sali"
        hasKeyPart2 := false.                   "DO GGPW, klucz do sekretnej sali"
        hasSecretKey := false.                  "DO GGPW, klucz do sekretnej sali"
        checkedLockerRoom := false.             "EiTI szatnia"
        knowsAboutMissingKey := false.          "DO GGPW, czy wie o brakujacym kluczu"
        knowsAboutSemesterWork := false.        "DO SALI GLOWNEJ, po sprawdzeniu kieszeni"
        checkedMainHallPockets := false.        "DO SALI GLOWNEJ, sprawdzanie kieszeni"
        greetedNobody := false.                 "W parku"
        approachedBar := false.                 "Hala koszyki bar"
        boughtWilczaNote := false.              "Notatka z wilczej"
        viewedFountain := false.                "Park"
        visitedWilcza30 := false.               "visitedWilcza bylo wyzej? To chyba do faktycznych odwiedzin uzywane"
        pocketChecked := false.                 "poczatek gry"
        pickedUpItems := false.                 "kilka momentow w grze z itemkami"
        gameOver := false.                      "hm?"
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
    hasKey [^hasKey]
    hasKey: aBoolean [hasKey := aBoolean]
    hasKeyPart1 [^hasKeyPart1]
    hasKeyPart1: aBoolean [hasKeyPart1 := aBoolean]
    hasKeyPart2 [^hasKeyPart2]
    hasKeyPart2: aBoolean [hasKeyPart2 := aBoolean]
    checkedMainHallPockets [^checkedMainHallPockets]
    checkedMainHallPockets: aBoolean [checkedMainHallPockets := aBoolean]
    pocketChecked [^pocketChecked]
    pocketChecked: aBoolean [pocketChecked := aBoolean]
    hasSecretKey [^hasSecretKey]
    hasSecretKey: aBoolean [hasSecretKey := aBoolean]
    knowsAboutMissingKey [^knowsAboutMissingKey]
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
    knowsAboutSemesterWork [^knowsAboutSemesterWork]
    knowsAboutSemesterWork: aBoolean [knowsAboutSemesterWork := aBoolean]
    gameOver [^gameOver]
    gameOver: aBoolean [gameOver := aBoolean]

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
        FileStream stdin nextLine. "CHANGED to nextLine"
        Transcript show: 'Profesor wyglada raz na zazenowanego, raz na zaskoczonego, a nawet na zadowolonego.'; cr.
        Transcript show: '"Musze Panu przyznac, ze moze praca idealna nie jest... ale zaliczyc, to Pan zaliczy."'; cr.
        Transcript show: '"A swoja droga... no i jak Panska wiedza? Powalczy Pan o lepsza ocene?"'; cr.
        Transcript show: 'Starasz sobie przypomniec co sie dowiedziales... mowisz co wiesz, troche tez zmyslasz, ale...'; cr.
        Transcript show: 'Wpisz "true" i nacisnij Enter.'; cr.
        FileStream stdin nextLine. "CHANGED to nextLine"
        grade := 3.0 + (0.5 * interactionCounter).
        Transcript show: 'ZALICZASZ przedmiot z ocena '; show: grade printString; cr.
        Transcript show: 'Zebrano wszystkie 4 czesci notatki. Skompletowano prace semestralna!'; cr.
        Transcript show: 'Znaleziono '; show: interactionCounter printString; show: ' z czterech dostepnych sekretnych interakcji.'; cr.
        self gameOver: true.
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
        FileStream stdin nextLine. "CHANGED to nextLine"
        Transcript show: 'NIE ZALICZASZ przedmiotu. Ocena koncowa: 2.0. Profesor wydaje sie byc na ciebie zdenerwowany.'; cr.
        Transcript show: 'Zebrano '; show: notes size printString; show: '/4 notatek. Nie udalo ci sie skompletowac pracy semestralnej.'; cr.
        Transcript show: 'Znaleziono '; show: interactionCounter printString; show: ' z czterech dostepnych sekretnych interakcji.'; cr.
        self gameOver: true.
    ]

    handleInteraction [
        talkCounter = 0 ifTrue: [ ^self interactZero ].
        talkCounter = 1 ifTrue: [ ^self interactOne ].
        talkCounter = 2 ifTrue: [ ^self interactTwo ].
        talkCounter = 3 ifTrue: [ ^self interactThree ].
        ^self interactNone
    ]

    interactZero [
        self incrementTalkCounter.
        Transcript show: 'Zauważasz jakiegoś profesora, i podchodzisz do niego.'; cr.
        self knowsAboutMissingKey
            ifTrue: [
                Transcript
                    show: 'Witasz się z profesorem. Pytasz go też, czy wie jak otworzyć salę główną.'; cr;
                    show: 'Nie jest otwarta? Hm. Niech Pan sprawdzi może w portierni - tam powinni Panu pomóc.'; cr.
            ]
            ifFalse: [
                Transcript show: 'Mówisz do profesora dzień dobry. Profesor z uśmiechem wita się z tobą. Nic więcej nie mówisz.'; cr.
            ].
        ^ self
    ]

    interactOne [
        self incrementTalkCounter.
        Transcript show: 'Zaczepiasz jakiegoś studenta. Student uśmiecha się do ciebie.'; cr.
        Transcript show: 'Hej, co tam?'; cr.
        Transcript show: 'Patrzysz się ze zdziwieniem. Student przypomina tobie, że jest z tobą na roku. Nadal nic ci to nie mówi.'; cr.
        self knowsAboutMissingKey
            ifTrue: [
                Transcript show: 'Nieważne. Pytasz go, czy wie jak dostać się do sali głównej.'; cr.
                Transcript show: 'Czytałeś może tablicę ogłoszeń? Napisali że klucza nie ma - zginął gdzieś. Ciekawe gdzie go zgubili.'; cr.
                Transcript show: 'Nie pomogło tobie to za bardzo. Odchodzisz.'; cr.
            ]
            ifFalse: [
                Transcript show: 'Nie wiedząc co powiedzieć, jak najszybciej znikasz z miejsca zdarzenia.'; cr.
            ].
        ^ self
    ]

    interactTwo [
        self incrementTalkCounter.
        Transcript show: 'Próbujesz pogadać z Panią woźną.'; cr.

        self knowsAboutMissingKey
            ifFalse: [
                Transcript show: 'W sumie uznajesz, że nie chcesz jej przeszkadzać. Odchodzisz.'; cr.
            ]
            ifTrue: [
                Transcript show: 'Pytasz Panią, czy może wie na temat zamknięcia sali głównej.'; cr;
                show: 'Oj nie wiem, słyszałam tylko że zginął niedawno. Tak dokładnie nie szukaliśmy go jeszcze.'; cr.
            ].
        ^ self
    ]

    interactThree [
        self incrementTalkCounter.
        Transcript show: 'Podchodzisz do studentki. Witasz się.'; cr.

        self knowsAboutMissingKey
            ifFalse: [
                Transcript show: 'Pytasz jak idzie w tym semestrze. Studentka krótko odpowiada że, idzie jej nieźle.'; cr.
            ]
            ifTrue: [
                Transcript show: 'Pytasz, czy może wie dlaczego sala główna jest zamknięta.'; cr;
                show: 'Hm, też próbujesz oddać pracę semestralną, nie?'; cr.

                (notes size = 0)
                    ifTrue: [ Transcript show: 'Zaraz...'; cr. ].

                (notes size = 4)
                    ifTrue: [
                        Transcript show: 'Odpowiadasz, że tak - na tym tobie teraz zależy'; cr;
                        show: 'Podobno klucz gdzieś się zgubił, i teraz profesor czeka w środku aż ktoś mu otworzy'; cr;
                        show: 'Żegnasz się, i powoli odwracasz się w stro-'; cr;
                        show: 'Tak jak coś, kolega mi mówił że zaczął odpytywać ostatnio.'; cr;
                        show: 'Podobno mówi coś w stylu ''no i jak twoja wiedza'', i jak mu odpowiesz, to można wyższą ocenę dostać.'; cr;
                        show: 'Pytasz, czy może wie, z czego odpytywał.'; cr;
                        show: 'Chyba wszystkich pytał o to samo...'; cr;
                        show: 'Przez kolejną minutę rozmawiasz, i słuchasz o pytaniach. To się może przydać!'; cr.
                        self incrementInteractionCounter.
                    ] ifFalse: [
                        (notes size = 0) ifFalse: [
                            Transcript show: 'Aha, faktycznie. Odchodzisz.'; cr.
                        ]
                    ].
            ].
        ^ self
    ]

    interactNone [
        self knowsAboutMissingKey
            ifTrue: [
                Transcript show: 'Chciałbyś zagadać jeszcze raz, ale nie widzisz już nikogo, z kim rozmawiałeś.'; cr.
            ]
            ifFalse: [
                Transcript show: 'Nie chcesz już próbować.'; cr.
            ].
        ^ self
    ]

    handleSearchArea [
        | input |
        self knowsAboutMissingKey
            ifTrue: [
                Transcript show: 'Przeszukujesz teren... musisz jakoś otworzyć te drzwi do sali głównej.'; cr;
                    show: 'Chodzisz dookoła z myślą że coś znajdziesz, ale bez skutku... Może trzeba do tego podejść na spokojnie?'; cr.

                [true] whileTrue: [
                    Transcript show: 'Co robisz? Wybierz [1] Idź do dziekanatu [2] Przeszukaj korytarze [3] Sprawdź różne sale, [4] Sprawdź klatkę schodową [5] Skończ szukać'; cr.
                    input := self getInput.

                    input = '1' ifTrue: [ self searchDeanOffice. ^ self handleSearchArea ].
                    input = '2' ifTrue: [ self searchCorridors. ^ self handleSearchArea ].
                    input = '3' ifTrue: [ self searchRooms. ^ self handleSearchArea ].
                    input = '4' ifTrue: [ self searchStairs. ^ self handleSearchArea ].
                    input = '5' ifTrue: [
                        Transcript show: 'Kończysz przeszukiwanie.'; cr.
                        ^ self
                    ].
                    ( (input = '1')
                        or: [ (input = '2')
                        or: [ (input = '3')
                        or: [ (input = '4')
                        or: [ (input = '5') ] ] ] ] )
                            ifFalse: [
                                Transcript show: 'Nieprawidłowy wybór.'; cr.
                            ].
                ].
            ]
            ifFalse: [
                Transcript show: 'Przeszukujesz teren dookoła kompletnie bez pomysłu. Nic nie znajdujesz.'; cr.
                ^ self
            ].
    ]

    searchDeanOffice [
        | input |
        Transcript show: 'Dziekanat wydaje się być zamknięty. Spod drzwi wystaje kawałek jakiegoś przedmiotu'; cr.
        [true] whileTrue: [
            Transcript show: 'Wybierz [1] Spróbuj otworzyć drzwi do dziekanatu [2] Podnieś przedmiot [3] Wróć do miejsca startowego'; cr.
            input := self getInput.
            input = '1' ifTrue: [
                Transcript show: 'Drzwi dalej się nie otwierają. Próbujesz na siłę, ale bez skutku. Jedyne co wywołujesz, to dziwne spojrzenie od przechodzącej Pani magister.'; cr.
            ].
            input = '2' ifTrue: [
                self hasKeyPart1
                    ifTrue: [
                        Transcript show: 'Pod drzwiami jest jeszcze kawałek kartki. Zostawiasz go.'; cr.
                    ]
                    ifFalse: [
                        Transcript show: 'Schylasz się po przedmiot, i wysuwasz go spod drzwi. Dobra informacja: jest to klucz!'; cr;
                            show: 'Gorsza informacja: część tego klucza wydaje się wyłamana. Może się przyda, kto wie'; cr.
                        self hasKeyPart2 ifTrue: [
                            Transcript show: 'Gdyby tylko dało się go jakoś naprawić...'; cr.
                        ].
                        self hasKeyPart1: true.
                    ].
            ].
            input = '3' ifTrue: [ ^ self ].

            ( (input = '1') or: [ (input = '2') or: [ (input = '3') ] ] ) ifFalse: [
                Transcript show: 'Nieprawidłowy wybór.'; cr.
            ].
        ].
    ]

    searchCorridors [
        | input |
        Transcript show: 'Jest tutaj co sprawdzać. Ale od czego zacząć?'; cr.
        [true] whileTrue: [
            Transcript show: 'Co sprawdzisz? [1] Pójdź w lewo [2] Pójdź w prawo [3] Pójdź na wprost [4] Wróć do miejsca startowego'; cr.
            input := self getInput.

            input = '1' ifTrue: [
                Transcript show: 'Przechodzisz po lewym korytarzu i sprawdzasz każdy kąt.'; cr;
                    show: 'Nic ciekawego nie zauważasz. Wracasz do rozwidlenia.'; cr.
            ].
            input = '2' ifTrue: [
                Transcript show: 'Sprawdzasz korytarz po prawej. Sprawdzasz dosłownie wszystko co się da.'; cr.
                self hasKeyPart2
                    ifTrue: [
                        Transcript show: 'Nic nie zauważasz'; cr.
                    ]
                    ifFalse: [
                        Transcript show: 'Zauważasz dwuzłotówkę, oraz dziwny kawałek... czegoś. Patrzysz czy nikt nie idzie, i podnosisz oba przedmioty'; cr.
                        self hasKeyPart2: true.
                        self hasKeyPart1 ifTrue: [
                            Transcript show: 'Ten kawałek w sumie pasuje do wyłamanego klucza. Gdyby go jakoś naprawić...'; cr.
                        ].
                        self addMoney: 2.
                    ].
            ].
            input = '3' ifTrue: [
                Transcript show: 'Idziesz na wprost. Natrafiasz na ścianę.'; cr.
            ].
            input = '4' ifTrue: [ ^ self ].

            ( ( (input = '1')
                or: [ (input = '2') ] )
                or: [ (input = '3')
                or: [ (input = '4') ] ] )
                    ifFalse: [
                        Transcript show: 'Nieprawidłowy wybór.'; cr.
                    ].
        ].
    ]

    searchRooms [
        | input |
        Transcript show: 'Idziesz na pierwsze piętro, i wchodzisz do losowego korytarza. Za cel obierasz sobie losowe sale.'; cr.
        [true] whileTrue: [
            Transcript show: 'Co robisz? [1] Wejdź do sali 121 [2] Wejdź do sali 113 [3] Wejdź do sali 133 [4] Wróć do miejsca startowego'; cr.
            input := self getInput.

            input = '1' ifTrue: [
                Transcript show: 'Próbujesz otworzyć salę 121.'; cr;
                    show: 'Sala jest zamknięta.'; cr.
                self hasSecretKey ifTrue: [
                    Transcript show: 'Twój naprawiony klucz nie pasuje do zamka.'; cr.
                ].
                self hasKey ifTrue: [
                    Transcript show: 'Klucz który znalazłeś, nie pasuje do zamka.'; cr.
                ].
            ].
            input = '2' ifTrue: [
                Transcript show: 'Próbujesz otworzyć salę 113'; cr;
                    show: 'Sala jest otwarta. Wchodzisz do środka: nikogo tutaj nie ma.'; cr;
                    show: 'Przeszukujesz salę, i wszystko wydaje się normalne. Podchodzisz do biurka nauczyciela, lecz wszystkie szafki są pozamykane.'; cr;
                    show: 'Nic nie znajdujesz.'; cr.
            ].
            input = '3' ifTrue: [
                Transcript show: 'Próbujesz otworzyć salę 133'; cr;
                    show: 'Sala jest zamknięta.'; cr.
                self hasKey ifTrue: [
                    Transcript show: 'Klucz który znalazłeś, nie pasuje do zamka.'; cr.
                ].
                self hasSecretKey
                    ifFalse: [
                        Transcript show: 'Odchodzisz od drzwi'; cr.
                    ]
                    ifTrue: [
                        Transcript show: 'Klucz który naprawiłeś, pasuje do zamka. Otwierasz drzwi do sali 133, i wchodzisz do środka.'; cr;
                            show: 'Wszystko wygląda normalnie. Zauważasz zostawione przez jakiegoś studenta notatki. Są z przedmiotu, który przecież kojarzysz.'; cr;
                            show: 'Szybko czytasz notatki.'; cr.
                        self pickedUpItems
                            ifTrue: [
                                Transcript show: 'Niczego więcej się nie dowiadujesz.'; cr.
                            ]
                            ifFalse: [
                                (self notes size < 4)
                                    ifTrue: [
                                        Transcript show: 'W sumie mało się dowiadujesz'; cr.
                                    ]
                                    ifFalse: [
                                        Transcript show: 'To może się przydać do twoich notatek! Bierzesz czystą kartkę z biurka nauczyciela, i przepisujesz najważniejsze rzeczy.'; cr.
                                        self incrementInteractionCounter.
                                        self pickedUpItems: true.
                                    ].
                            ].
                    ].
            ].
            input = '4' ifTrue: [ ^ self ].

            ( ( (input = '1')
                or: [ (input = '2') ] )
                or: [ (input = '3')
                or: [ (input = '4') ] ] )
                    ifFalse: [
                        Transcript show: 'Nieprawidłowy wybór.'; cr.
                    ].
        ].
    ]

    searchStairs [
        Transcript show: 'Idziesz sprawdzić najbliższą klatkę schodową. Przechodzisz się po niej w górę, i wracasz. Nic nie zauważasz.'; cr.
        self hasKey
            ifTrue: [
                Transcript show: 'Schylasz się po klucz i... nic nie podnosisz. Klucz trzymasz przecież w ręku. Niezręcznie...'; cr.
            ]
            ifFalse: [
                Transcript show: 'Znajdujesz klucz! Wygląda dość staro, ale może będzie gdzieś pasować.'; cr.
                self hasKey: true.
            ].
        Transcript show: 'Wracasz do punktu, z którego zacząłeś przeszukiwanie.'; cr.
        ^ self
    ]
]