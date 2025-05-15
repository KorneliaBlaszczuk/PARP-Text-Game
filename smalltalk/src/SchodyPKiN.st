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