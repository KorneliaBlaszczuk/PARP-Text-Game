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