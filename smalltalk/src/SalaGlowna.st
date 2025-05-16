Location subclass: SalaGlowna [
    description [
        ^'Jesteś w głównej sali. Czas na końcową decyzję i oddanie pracy semestralnej.'
    ]

    availableActionsFor: game do: aBlock [
        ^#('sprawdz_kieszenie' 'wyjdz_z_sali' 'podejdz_do_profesora') asOrderedCollection
            do: [ :akcja | aBlock value: akcja ].
    ]

    performAction: actionSymbol inGame: game [
    ]
]