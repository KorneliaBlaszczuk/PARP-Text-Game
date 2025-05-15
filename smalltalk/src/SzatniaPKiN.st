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