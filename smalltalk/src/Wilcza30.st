Location subclass: Wilcza30 [
    description [
        ^'Stoisz przed drzwiami mieszkania na Wilczej 30.'
    ]

    availableActionsFor: game do: aBlock [
        ^#('zapukajDoDrzwi' 'rozejrzyjSie' 'idzDoHaliKoszyki') asOrderedCollection
            do: [ :akcja | aBlock value: akcja ].
    ]

    performAction: actionSymbol inGame: game [
        actionSymbol = #zapukajDoDrzwi ifTrue: [
            (game visitedWilcza30) ifTrue: [
                'Drzwi są zamknięte. Nikt nie odpowiada.' displayNl.
            ] ifFalse: [
                'Otwiera ci nieznana osoba. ''Czekalem na ciebie.''' displayNl.
                game visitedWilcza30: true.
                game changeLocation: (DomWilcza new).
            ].
            ^ true
        ].
        actionSymbol = #rozejrzyjSie ifTrue: [
            Transcript show: 'Wilcza 30. Stara kamienica z odrapanym numerem nad wejsciem.'; cr.
            Transcript show: 'Drzwi nosza slady zuzycia, jakby ktos niedawno probowal je sforsowac.'; cr.
            Transcript show: 'W srodku czuc wilgoc, kurz i zapach tanich papierosow.'; cr.
            Transcript show: 'Na skrzynkach pocztowych nazwiska lokatorow, ale jedno miejsce jest puste.'; cr.
        ].
        actionSymbol = #idzDoHaliKoszyki ifTrue: [
            Transcript show: 'Opuszczasz Wilcza 30 i idziesz w strone Hali Koszyki.'; cr.
            game changeLocation: (HalaKoszyki new).
        ].
    ]
]