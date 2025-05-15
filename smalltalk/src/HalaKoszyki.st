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