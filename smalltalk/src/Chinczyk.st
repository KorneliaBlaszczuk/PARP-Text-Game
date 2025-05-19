Location subclass: Chinczyk [
    description [
        ^'Lokal jest niewielki, ale przytulny. Na scianach wisza chinskie lampiony, a w tle cicho gra azjatycka muzyka. Wlasciciel patrzy na ciebie z zainteresowaniem, jakby cie juz widzial.'
    ]

    availableActionsFor: game do: aBlock [
        ^#('porozmawiajZWlascicielem' 'kupCos' 'idzDoGgPw' 'idzNaWeiti') asOrderedCollection
            do: [ :akcja | aBlock value: akcja ].
    ]

    performAction: actionSymbol inGame: game [
        actionSymbol = #porozmawiajZWlascicielem ifTrue: [
            game conversationDone ifFalse: [
                Transcript show: 'Pamieta cie! Wspomina, ze wczoraj zostawiles cos przy stoliku.'; cr.
                Transcript show: 'Wskaze ci go jedynie, jesli kupisz cos (10zl), przeciez za darmo nie mozesz siedziec w lokalu!'; cr.
                game conversationDone: true.
            ] ifTrue: [
                Transcript show: 'Podchodzisz do wlasciciela jeszcze raz. Dalej cie pamieta.'; cr.
                game visitedEiti ifTrue: [
                    Transcript show: 'Nic tobie nie wskazuje. Zaczynasz sie zastanawiac co wlasciwie chcesz od wlasciciela.'; cr.
                ] ifFalse: [
                    Transcript show: 'Przypomina tobie o czyms przy stoliku. Jak cos kupisz (10zl), to wskaze tobie ten tajemniczy przedmiot.'; cr.
                ].
            ].
        ].
        actionSymbol = #kupCos ifTrue: [
            game conversationDone ifFalse: [
                Transcript show: 'Najpierw porozmawiaj z wlascicielem.'; cr.
            ] ifTrue: [
                game money >= 10 ifTrue: [
                    game visitedEiti ifFalse: [
                        game subtractMoney: 10.
                        game visitedEiti: true.
                        Transcript show: 'Znajdujesz tajemnicza wiadomosc "EITI" napisana na odwrocie serwetki.'; cr.
                    ] ifTrue: [
                        Transcript show: 'Wlasciciel nie ma tobie nic ciekawego do sprzedania... no w sumie oprocz jedzenia.'; cr.
                    ].
                ] ifFalse: [
                    Transcript show: 'Nie masz tyle forsy! Musisz miec 10zl, aby kupic cos.'; cr.
                ].
            ].
        ].
        actionSymbol = #idzDoGgPw ifTrue: [
            Transcript show: 'Idziesz do Gmachu Glownego PW.'; cr.
            game changeLocation: (GmachGlowny new).
        ].
        actionSymbol = #idzNaWeiti ifTrue: [
            Transcript show: 'Idziesz na wydzial EITI.'; cr.
            game pickedUpItems: false.
            game changeLocation: (Eiti new).
        ].
    ]
]