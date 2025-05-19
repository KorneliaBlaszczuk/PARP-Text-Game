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
        self incrementTalkCounter. "Corresponds to: modify (\s -> s {conversationCounter = conversationCounter s + 1})"
        Transcript show: 'Próbujesz pogadać z Panią woźną.'; cr.

        self knowsAboutMissingKey
            ifFalse: [ "Corresponds to: if not keyKnowledge"
                Transcript show: 'W sumie uznajesz, że nie chcesz jej przeszkadzać. Odchodzisz.'; cr.
            ]
            ifTrue: [ "Corresponds to: else do"
                Transcript show: 'Pytasz Panią, czy może wie na temat zamknięcia sali głównej.'; cr;
                show: 'Oj nie wiem, słyszałam tylko że zginął niedawno. Tak dokładnie nie szukaliśmy go jeszcze.'; cr. "Note the single quote inside for dialogue"
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
                    ifTrue: [ Transcript show: 'Zaraz...'; cr. ]. "No 'else return ()' needed, Smalltalk just proceeds"

                (notes size = 4) "Changed from Haskell's 'if length lst /= 4 then ... else ...' to a direct check"
                    ifTrue: [
                        Transcript show: 'Odpowiadasz, że tak - na tym tobie teraz zależy'; cr;
                        show: 'Podobno klucz gdzieś się zgubił, i teraz profesor czeka w środku aż ktoś mu otworzy'; cr;
                        show: 'Żegnasz się, i powoli odwracasz się w stro-'; cr; "Note the trailing dash"
                        show: 'Tak jak coś, kolega mi mówił że zaczął odpytywać ostatnio.'; cr;
                        show: 'Podobno mówi coś w stylu ''no i jak twoja wiedza'', i jak mu odpowiesz, to można wyższą ocenę dostać.'; cr; "Double single quotes for 'no i jak twoja wiedza'"
                        show: 'Pytasz, czy może wie, z czego odpytywał.'; cr;
                        show: 'Chyba wszystkich pytał o to samo...'; cr;
                        show: 'Przez kolejną minutę rozmawiasz, i słuchasz o pytaniach. To się może przydać!'; cr.
                        self incrementInteractionCounter. "Corresponds to: modify (\s -> s {interactionCounter = interactionCounter s + 1})"
                    ]
                    ifFalse: [ "This covers notes size > 0 AND notes size < 4 (and not 0)"
                        (notes size = 0) ifFalse: [ "Only show 'Aha, faktycznie...' if not already handled by 'Zaraz...'"
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
]