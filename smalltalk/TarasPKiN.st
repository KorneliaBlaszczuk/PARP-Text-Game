Location subclass: TarasPKiN [
    description [
        ^'Budzisz sie na tarasie PKiN. Okropnie boli cie glowa, szczegolnie, kiedy na twoje powieki padaja pierwsze promienie nowego dnia. Nagle czujesz dziabniecie. To golab, ktory zdecydowanie nie jest zadowolony z twojej obecnosci na jego terytorium. Co zrobic?'
    ]

    availableActionsFor: game do: aBlock [
        #('zajrzyjDoKieszeni' 'rozejrzyjSie' 'podejdzDoKrawedzi' 'zejdzPoSchodach' 'uzyjWindy') asOrderedCollection
            do: [ :akcja | aBlock value: akcja ].
    ]

    performAction: actionSymbol inGame: game [
        actionSymbol = #zajrzyjDoKieszeni ifTrue: [
            game pocketChecked ifFalse: [
                game pocketChecked: true.
                'Siegasz do kieszeni i znajdujesz 20zl oraz notatke.' displayNl.
                game addMoney: 20.
                game notes: (game notes add: 1; yourself).  "Poprawiona linia"
                ^ true
            ] ifTrue: [
                'Juz zajrzales do kieszeni, nic tam wiecej nie ma.' displayNl.
                ^ true
            ].
        ].
        actionSymbol = #rozejrzyjSie ifTrue: [
            Transcript show: 'Widzisz panorame miasta. Slonce wschodzi nad Warszawa.'; cr.
        ].
        actionSymbol = #podejdzDoKrawedzi ifTrue: [
            Transcript show: 'Podchodzisz do krawedzi i odczuwasz lekki zawrot glowy.'; cr.
        ].
        actionSymbol = #uzyjWindy ifTrue: [
            Transcript show: 'Zjezdzasz winda prosto na dol do holu PKiN.'; cr.
            game changeLocation: (HolPKiN new).
        ].
        actionSymbol = #zejdzPoSchodach ifTrue: [
            Transcript show: 'Schodzisz schodami PKiN.'; cr.
            game changeLocation: (SchodyPKiN new).
        ].
    ]
]