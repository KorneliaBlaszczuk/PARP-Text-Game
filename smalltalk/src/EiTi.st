Location subclass: Eiti [
    description [
        ^'Jestes na Wydziale EITI. Laboratoria i studenci dookola.'
    ]

    availableActionsFor: game do: aBlock [
        ^#('zajrzyjDoLaboratorium' 'zajrzyjDoSzatni' 'idzDoGgPw') asOrderedCollection
            do: [ :akcja | aBlock value: akcja ].
    ]

    performAction: actionSymbol inGame: game [
        actionSymbol = #zajrzyjDoLaboratorium ifTrue: [
            game pickedUpItems ifFalse: [
                Transcript show: 'Wchodzisz do laboratorium i widzisz profesorow.'; cr.
                Transcript show: 'Witasz sie i powoli wchodzisz do srodka. Studentow tu jeszcze nie ma, ale zapewne beda tu niedlugo jakies zajecia.'; cr.
                Transcript show: '"Szuka Pan czegos?" - pyta profesor. Odpowiadasz ze tak, cos zostawiles (dobrze wiesz ze to nieprawda)'; cr.
                Transcript show: 'Chociaz... ha, ciekawe. Widzisz kawalek notatki. Bierzesz ja - moze sie tobie przydac.'; cr.
                game pickedUpItems: true.
                game notes: (game notes add: (game notes size + 1); yourself).
            ] ifTrue: [
                Transcript show: 'Wchodzisz do laboratorium i... nie, nie wchodzisz do laboratorium.'; cr.
            ].
        ].
        actionSymbol = #zajrzyjDoSzatni ifTrue: [
            game checkedLockerRoom ifFalse: [
                Transcript show: 'Podchodzisz, a Pan z szatni wyjmuje juz numerek, i chce go tobie wreczyc. Nie bierzesz numerka, ale rozgladasz sie wokol'; cr.
                Transcript show: '"Czy w czyms Panu pomoc???" - zapytany odpowiadasz, ze po prostu patrzysz czy czegos nie zapomniales'; cr.
                Transcript show: '"Cos... ostatnio wydawal sie Pan jakis rozkojarzony, o ile mnie pamiec nie myli..."'; cr.
                Transcript show: '"hmmmm..." - Pan rozglada sie chwile, patrzy pod swoje biurko, i mowi:'; cr.
                Transcript show: '"Chyba to moze byc Pana. Niech Pan sprawdzi - lezy tu od jakiegos czasu."'; cr.
                Transcript show: 'Dostajesz ladnie ucieta sciage. Spogladasz na zawartosc, i rzeczywiscie: cos kojarzysz. Moze to sie przydac...'; cr.
                game incrementInteractionCounter.
                game checkedLockerRoom: true.
            ] ifTrue: [
                Transcript show: 'Patrzysz jeszcze raz na szatnie, i nic nietypowego nie zauwazasz. Predko odchodzisz'; cr.
            ].
        ].
        actionSymbol = #idzDoGgPw ifTrue: [
            Transcript show: 'Idziesz do Gmachu Glownego PW.'; cr.
            game changeLocation: (GmachGlowny new).
        ].
    ]
]