Location subclass: GmachGlowny [
    description [
        ^'Jesteś w Gmachu Głównym Politechniki Warszawskiej. Wszędzie pełno studentów i nauczycieli.'
    ]

    availableActionsFor: game do: aBlock [
        ^#('pogadajZKims' 'sprawdzTabliceOgloszen' 'sprawdzPortiernie' 'przeszukajTeren' 'otworzSaleGlowna') asOrderedCollection
            do: [ :akcja | aBlock value: akcja ].
    ]

    performAction: actionSymbol inGame: game [

        actionSymbol = #pogadajZKims ifTrue: [
            game handleInteraction.
        ].

        actionSymbol = #sprawdzTabliceOgloszen ifTrue: [
            Transcript show: 'Na tablicy ogłoszeń widzisz informację o terminie oddania pracy. Oprócz tego, widzisz nowo powieszoną kartkę z napisem ''Zgubiono klucz do sali ...'''; cr.
            game knowsAboutMissingKey ifTrue: [
                Transcript show: 'Wiesz o tym...'; cr.
                game hasKey ifTrue: [
                    Transcript show: 'Patrzysz na klucz leżący w twojej dłoni.'; cr.
                ].
            ]
            ifFalse: [
                Transcript show: 'Więc chodzi o klucz... no tak.'; cr.
                game knowsAboutMissingKey: true.
            ].
        ].

        actionSymbol = #sprawdzPortiernie ifTrue: [
            Transcript show: 'Podchodzisz do pustej portierni. Zauważasz kubek z kawą, taśmę, i kilka innych przedmiotów.'; cr.
            (game hasKeyPart1 and: [game hasKeyPart2]) ifTrue: [
                game hasSecretKey ifTrue: [
                    Transcript show: 'Już naprawiłeś klucz.'; cr.
                ]
                ifFalse: [
                    Transcript show: 'Masz dwie części klucza, które mniej więcej pasują do siebie. Bierzesz z biurka taśmę, i łączysz umiejętnie dwie części klucza.'; cr.
                    Transcript show: 'Hmmm. Ciekawe do czego ten klucz pasuje.'; cr.
                    game hasSecretKey: true.
                ].
            ] ifFalse: [
                Transcript show: 'Odchodzisz'; cr.
            ].
        ].

        actionSymbol = #otworzSaleGlowna ifTrue: [
            game hasKey ifTrue: [
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