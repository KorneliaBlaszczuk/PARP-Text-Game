Location subclass: SalaGlowna [
    description [
        ^'Jesteś w głównej sali. Czas na końcową decyzję i oddanie pracy semestralnej.'
    ]

    availableActionsFor: game do: aBlock [
        ^#('sprawdzKieszenie' 'wyjdzZSali' 'podejdzDoProfesora') asOrderedCollection
            do: [ :akcja | aBlock value: akcja ].
    ]

    performAction: actionSymbol inGame: game [
        actionSymbol = #sprawdzKieszenie ifTrue: [
            | notes money |
            money := game money.
            notes := game notes.

            game checkedMainHallPockets ifTrue: [
                Transcript show: 'Już sprawdziłeś kieszenie. Nic innego tam nie ma.'; cr.
            ] ifFalse: [
                notes size = 0 ifTrue: [ "Or notes isEmpty"
                    Transcript show: 'Sprawdzasz swoje kieszenie... znajdujesz '; show: money printString; show: ' zł.'; cr.
                    Transcript show: 'Ale fajnie :D... żadna inna myśl nie przychodzi tobie do głowy.'; cr.
                ] ifFalse: [
                    Transcript show: 'Sprawdzasz swoje kieszenie... znajdujesz '; show: notes size printString; show: ' części notatek, oraz '; show: money printString; show: ' zł.'; cr.
                    notes size < 4 ifTrue: [
                        Transcript show: 'Zaraz... o nie...'; cr.
                        Transcript show: 'W panice składasz części twojej pracy które wcześniej zebrałeś.'; cr.
                        Transcript show: 'Praca... nie jest kompletna. Brzuch zaczyna cię boleć. Wygląda na to, że brakuje tobie '; show: (4 - notes size) printString; show: ' części notatek.'; cr.
                    ] ifFalse: [
                        Transcript show: 'Teraz jesteś pewien - trzymasz części twojej pracy semestralnej.'; cr.
                        Transcript show: 'W panice składasz części twojej pracy semestralnej... jest pełna...'; cr.
                        Transcript show: '30 sekund emocjonalnego rollercoastera kończy się ogromną ulgą... uśmiechasz się!'; cr.
                    ].
                    game knowsAboutSemesterWork: true.
                ].
            ].
            game checkedMainHallPockets: true.
        ].

        actionSymbol = #wyjdzZSali ifTrue: [
            Transcript show: 'Próbujesz wyjść z sali... ale drzwi się zamknęły, i nie chcą się otworzyć'; cr.
        ].

        actionSymbol = #podejdzDoProfesora ifTrue: [
            | notes |
            notes := game notes.

            Transcript show: 'Podchodzisz do profesora siedzącego na wprost ciebie. Czeka na ciebie, i rozpoznaje cię. Witasz się.'; cr.
            Transcript show: '''I kto to przyszedł? Dzień dobry Panu.'' - mówi profesor w nieco onieśmielającym tonie.'; cr.

            game knowsAboutSemesterWork ifFalse: [
                Transcript show: '''Będzie Pan tak tu stać? Czegoś Pan potrzebuje?'''; cr.
                notes isEmpty ifTrue: [ "notes size = 0 would also work"
                    Transcript show: 'Nie wiesz co ciebie tu przyprowadziło, ale przez cały czas miałeś wrażenie, że musisz tu być.'; cr.
                    Transcript show: 'Odlatujesz myślami... gdzieś, ale nie wiesz gdzie. W tle słychać profesora coraz głośniej, ale nie wiesz o czym mówi.'; cr.
                    Transcript show: 'Powoli wracasz na Ziemię: widzisz profesora jak wstaje i wskazuje na drzwi. Każe tobie wyjść.'; cr.
                    Transcript show: 'Jesteś rozkojarzony. Twoje myśli błądzą w nieskończonej nicości. Próbujesz się uspokoić.'; cr.
                ] ifFalse: [
                    Transcript show: 'Nie wiesz w sumie co tu robisz.'; cr.
                    Transcript show: '''To Pan wchodzi do mnie bez pojęcia co Pan w ogóle chce?'''; cr.
                    Transcript show: 'No dokładnie!'; cr.
                    Transcript show: '''To mogę Panu powiedzieć, że ja na pewno chcę Pańskiej pracy semestralnej'''; cr.
                    Transcript show: 'Naprawdę?'; cr.
                ].
            ] ifTrue: [
                Transcript show: '''Będzie Pan tak tu stać? Czegoś Pan potrzebuje?'''; cr.
                Transcript show: 'Mówisz, że chcesz oddać pracę semestralną'; cr.
            ].
            Transcript cr.

            notes size >= 4
                ifTrue: [ game goodEnding ]
                ifFalse: [ game badEnding ].
            game gameOver: true.
        ].
    ]
]