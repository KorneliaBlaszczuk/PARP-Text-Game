Location subclass: PrzedPKiN [
    description [
        ^'Jestes przed PKiN. Widok na miasto jest zapierajacy, mozesz ruszyc w rozne strony.'
    ]

    availableActionsFor: game do: aBlock [
        #('idzWStroneParku' 'idzWStroneTaksowki' 'spojrzNaUlotke') do: [:akcja |
            aBlock value: akcja
        ].

        game visitedHala ifTrue: [
            aBlock value: 'idzDoHaliKoszyki'
        ].

        game visitedWilcza ifTrue: [
            aBlock value: 'idzNaWilcza30'
        ].
    ]

    performAction: actionSymbol inGame: game [
        actionSymbol = #idzWStroneParku ifTrue: [
            game visitedPark ifTrue: [
                Transcript show: 'Odwiedziles juz park, nie masz ochoty znowu tam wracac...'; cr.
            ] ifFalse: [
                Transcript show: 'Idziesz w strone parku...'; cr.
                game changeLocation: (Park new).
            ].
        ].
        actionSymbol = #idzWStroneTaksowki ifTrue: [
            game money >= 20 ifTrue: [
                Transcript show: 'Wsiadasz do taksowki.'; cr.
                game changeLocation: (Taksowka new).
            ] ifFalse: [
                Transcript show: 'Nie masz wystarczajacej ilosci pieniedzy, aby skorzystac z taksowki.'; cr.
            ].
        ].
        actionSymbol = #spojrzNaUlotke ifTrue: [
            Transcript show: 'Znajdujesz ulotke z baru w Hali Koszyki z reklama Happy Hours. Moze warto sie tam udac?'; cr.
        ].
        actionSymbol = #idzDoHaliKoszyki ifTrue: [
            Transcript show: 'Postanawiasz pojsc do Hali Koszyki spacerujac, aby moc podziwiac budzaca sie Warszawe.'; cr.
            game changeLocation: (HalaKoszyki new).
        ].
        actionSymbol = #idzNaWilcza30 ifTrue: [
            Transcript show: 'Postanawiasz pojsc na Wilcza 30 spacerujac, aby moc podziwiac budzaca sie Warszawe.'; cr.
            game changeLocation: (Wilcza30 new).
        ].
    ]
]