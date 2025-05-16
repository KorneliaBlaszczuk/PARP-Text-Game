Location subclass: GmachGlowny [
    description [
        ^'Jesteś w Gmachu Głównym Politechniki Warszawskiej. Wszędzie pełno studentów i nauczycieli.'
    ]

    availableActionsFor: game do: aBlock [
        ^#('pogadaj_z_kims' 'sprawdz_tablice_ogloszen' 'sprawdz_portiernie' 'przeszukaj_teren' 'otworz_sale_glowna') asOrderedCollection
            do: [ :akcja | aBlock value: akcja ].
    ]

    performAction: actionSymbol inGame: game [

        actionSymbol = #sprawdz_tablice_ogloszen ifTrue: [
            Transcript show: 'Na tablicy ogłoszeń widzisz informację o terminie oddania pracy. Oprócz tego, widzisz nowo powieszoną kartkę z napisem ''Zgubiono klucz do sali ...'''; cr.
            game knowsAboutMissingKey ifFalse: [
                Transcript show: 'Więc chodzi o klucz... no tak.'; cr.
                game knowsAboutMissingKey: true.
            ]
            ifTrue [
                Transcript show: 'Wiesz o tym...'; cr.
                game hasKey ifTrue: [
                    Transcript show: 'Patrzysz na klucz leżący w twojej dłoni.'; cr.
                ]
            ]
        ]

        actionSymbol = #sprawdz_portiernie ifTrue: [
            Transcript show: 'Podchodzisz do pustej portierni. Zauważasz kubek z kawą, taśmę, i kilka innych przedmiotów.'; cr.
            game (hasKeyPart1 and: [hasKeyPart2]) ifTrue: [
                game hasSecretKey ifTrue: [
                    Transcript show: 'Już naprawiłeś klucz.'; cr.
                ]
                ifFalse: [
                    Transcript show: 'Masz dwie części klucza, które mniej więcej pasują do siebie. Bierzesz z biurka taśmę, i łączysz umiejętnie dwie części klucza.'; cr.
                    Transcript show: 'Hmmm. Ciekawe do czego ten klucz pasuje.'; cr.
                    game hasSecretKey: true.
                ]
            ] [
                ifFalse: [
                    Transcript show: 'Odchodzisz'; cr.
                ]
            ]
        ]

        actionSymbol = #otworz_sale_glowna ifTrue: [
            game hasKey ifTrue [
                Transcript show: 'Używasz klucza aby otworzyć salę...'; cr.
                game changeLocation: (SalaGlowna new).
            ]
            ifFalse: [
                Transcript show: 'Nie masz klucza do sali!'; cr.
                game knowsAboutMissingKey: true.
            ]
        ]
    ]
]