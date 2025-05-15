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