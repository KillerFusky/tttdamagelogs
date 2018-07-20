PANEL = 

    Init: () =>
        @UpdateRounds(true)
        hook.Add 'TTTDamagelogsRoundsCountChanged', 'TTTDamagelogs_UpdateRoundsCountDisplay', () ->
            @UpdateRounds(false) if IsValid(self)
        
    UpdateRounds: (firstUpdate) =>
        @Clear!
        if dmglog.roundsCount == 0
            @AddChoice(dmglog.GetTranslation('no_round_available'))
            @ChooseOptionID(1)
            @DoClick = () => -- NO-OP
        else
            for roundNumber = 1, dmglog.roundsCount
                displayedText = @GetDisplayedText(roundNumber)
                @AddChoice(displayedText, i)
            @ChooseOptionID(dmglog.roundsCount) if firstUpdate

    GetDisplayedText: (roundNumber) =>
        if roundNumber == dmglog.roundsCount and GetRoundState() == ROUND_ACTIVE
            return dmglog.GetTranslation('current_round')
        else 
            return dmglog.GetTranslation('combobox_round', {roundNumber: roundNumber})

    GetSelectedRound: () => select(2, @GetSelected!)        
    
vgui.Register('DamagelogRoundSelection', PANEL, 'DComboBox')