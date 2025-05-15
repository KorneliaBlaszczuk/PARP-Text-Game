Location subclass: Taksowka [
    description [
        ^'Wsiadles do taksowki. Kierowca czeka na dalsze instrukcje.'
    ]

    availableActionsFor: game do: aBlock [
        aBlock value: 'porozmawiaj'.
        (game respondsTo: #visitedHala) ifTrue: [
            game visitedHala ifTrue: [
                aBlock value: 'pojedzDoHaliKoszyki'
            ].
        ].
        (game respondsTo: #visitedWilcza) ifTrue: [
            game visitedWilcza ifTrue: [
                aBlock value: 'pojedzNaWilcza30'
            ].
        ].
    ]

    performAction: actionSymbol inGame: game [
        actionSymbol = #pojedzDoHaliKoszyki ifTrue: [
            Transcript show: 'Jedziesz do Hali Koszyki.'; cr.
            game subtractMoney: 20.
            game changeLocation: (HalaKoszyki new).
        ].
        actionSymbol = #pojedzNaWilcza30 ifTrue: [
            Transcript show: 'Jedziesz na Wilcza 30.'; cr.
            game subtractMoney: 20.
            game changeLocation: (Wilcza30 new).
        ].
        actionSymbol = #porozmawiaj ifTrue: [
            Transcript show: 'Kierowca mowi: ''Ciezka noc, co? Wygladasz jakos tak wczorajszo. Zdecydowanie wczoraj poimprezowales.'''; cr.
        ].
    ]
]