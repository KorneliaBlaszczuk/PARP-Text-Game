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