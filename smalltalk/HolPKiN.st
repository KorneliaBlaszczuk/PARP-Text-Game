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