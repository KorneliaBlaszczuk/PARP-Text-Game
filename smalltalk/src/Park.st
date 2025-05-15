Location subclass: Park [
    description [
        ^'Wchodzisz do Parku swietokrzyskiego. Powietrze jest rzeskie, a pierwsze promienie slonca oswietlaja puste alejki. W oddali slyszysz szum miasta, ale tutaj panuje dziwny spokoj. Na jednej z lawek siedzi mezczyzna owiniety w gruby plaszcz, z broda gesta jak historia tego miasta. Kiedy przechodzisz obok, unosi wzrok i usmiecha sie lekko. Obok widzisz budke, gdzie mozesz kupic nasiona dla golebi (-5zl).'
    ]

    availableActionsFor: game do: aBlock [
        ^#('usiadzNaLawce' 'karmGolebie' 'obejrzyjFontanne' 'porozmawiajZNieznajomym' 'idzPrzedPKiN') asOrderedCollection
            do: [ :akcja | aBlock value: akcja ].
    ]

    performAction: actionSymbol inGame: game [
        actionSymbol = #usiadzNaLawce ifTrue: [
            Transcript show: 'Siadasz na zimnej, metalowej lawce. Chlod poranka powoli przenika przez material twojego ubrania. Przymykasz oczy na chwile i wsluchujesz sie w dzwieki miasta. Czujesz chwilowy spokoj. Moze nawet zbyt wielki. Jakby swiat na moment sie zatrzymal, pozwalajac ci zlapac oddech przed kolejnym krokiem.'; cr.
        ].
        actionSymbol = #karmGolebie ifTrue: [
            game money >= 5 ifTrue: [
                Transcript show: 'Kupujesz nasiona i karmisz golebi. Jeden z nich wyglada znajomo... To ten, ktory dziabnal cie na tarasie!'; cr.
                game subtractMoney: 5.
            ] ifFalse: [
                Transcript show: 'Nie masz wystarczajaco pieniedzy, aby kupic chleb dla golebi.'; cr.
            ].
        ].
        actionSymbol = #obejrzyjFontanne ifTrue: [
            game viewedFountain ifTrue: [
                Transcript show: 'Ogladasz fontanne. Nic wiecej tam nie ma.'; cr.
            ] ifFalse: [
                | amount |
                amount := 2 + (Random new next * 9) floor. "Losowa liczba od 2 do 10"
                'Ogladasz fontanne. Patrzysz na spokojna tafle. Znajdujesz kilka monet o lacznej wartosci ' display.
                amount display. ' zl.' displayNl.
                game viewedFountain: true.
                game addMoney: amount.
            ].
        ].
        actionSymbol = #porozmawiajZNieznajomym ifTrue: [
            game visitedWilcza ifFalse: [
                Transcript show: 'Witasz sie z nieznajomym.'; cr.
                Transcript show: '''Dzien dobry! Co u Pana slychac?'' - pyta sie ciebie nieznajomy z entuzjazmem'; cr.
                Transcript show: 'Rowno entuzjastycznie odpowiadasz, ze ''dobrze''... nawet jesli pytanie nie brzmialo ''jak sie czujesz'', ale kto by sie przejmowal.'; cr.
                Transcript show: 'Zaczynasz rozmowe z nieznajomym, az... tracisz czucie czasu. Ile rozmawialiscie? Nie wiesz.'; cr.
                Transcript show: '''Ja musze prosze Pana jeszcze na autobus zdazyc, ale milo sie z Panem rozmawialo!'' - nieznajomy zegna sie z toba: znowu entuzjastycznie!'; cr.
                Transcript show: '''I niech Pan pamieta o Wilczej 30! Warto tam zajrzec!'''; cr.
                Transcript show: '??? Moze o czyms wspomniales podczas rozmowy, co by skutkowaly w takiej prosbie, ale tego nie pamietasz'; cr.
                Transcript show: 'Masz wrazenie, ze cos wyniosles z tej konwersacji, aczkolwiek nie wiesz do konca co.'; cr.
                game visitedWilcza: true.
                game incrementInteractionCounter.
            ] ifTrue: [
                Transcript show: 'Witasz sie z nieznajomym. Entuzjastycznie machasz do niego.'; cr.
                game greetedNobody ifFalse: [
                    game greetedNobody: true.
                ] ifTrue: [
                    Transcript show: 'Czy wszystko dobrze?'; cr.
                ].
            ].
        ].
        actionSymbol = #idzPrzedPKiN ifTrue: [
            Transcript show: 'Wracasz przed PKiN'; cr.
            game visitedPark: true.
            game changeLocation: (PrzedPKiN new).
        ].
    ]
]