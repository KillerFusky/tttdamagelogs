dmglog.highlightedPlayers = dmglog.highlightedPlayers or {}

highlightFont = dmglog.CreateFont 'DL_Highlight',
	font: 'Verdana'
	size: 13

PANEL =

    Init: () =>
        @panels = {}
        @SetSize(590, 60)
        @CreateLabel!
        @CreatePlayerChoices!
        @CreateHighlightButton!
        dmglog.highlightedPlayers = {}

    Paint: (w, h) =>
        surface.SetDrawColor(Color(40, 40, 40))
        surface.DrawLine(0, 0, w - 1, 0)
        surface.DrawLine(w - 1, 0, w - 1, h - 1)
        surface.DrawLine(w - 1, h - 1, 0, h - 1)
        surface.DrawLine(0, h - 1, 0, 0)

    CreateLabel: () =>
        with @label = vgui.Create('DLabel', self)
            do
                .baseText = dmglog.GetTranslation('currently_highlighted_players')
                .UpdateText = () =>
                    text = @baseText
                    if #dmglog.highlightedPlayers == 0
                        text ..= ' ' .. dmglog.GetTranslation('none')
                    @SetText(text)
                    @SizeToContents!
            do
                \SetFont(highlightFont)
                \SetTextColor(color_black)
                \SetPos(5, 10)
                \UpdateText!

    CreatePlayerChoices: () =>
        with @playerChoices = vgui.Create('DComboBox', self)
            \SetPos(5, 30)
            \SetSize(490, 20)
            \AddChoice(dmglog.GetTranslation('no_players'))
            \SetEnabled(false)

    CreateHighlightButton: () =>
        with @highlightButton = vgui.Create('DButton', self)
            do
                \SetPos(500, 30)
                \SetSize(80, 20)
                \SetText(dmglog.GetTranslation('highlight_action'))
            do
                .DoClick = (highlightButton) ->
                    @OnHighlighButtonClick!

    OnHighlighButtonClick: () =>
        name, roundPlayer = @playerChoices\GetSelected!
        if not roundPlayer or dmglog.highlightedPlayers[roundPlayer] return
        dmglog.highlightedPlayers[roundPlayer] = true
        @CreatePanels!        

    CreatePanels: () =>
        @label\UpdateText!
        surface.SetFont('DL_Highlight')
        x = surface.GetTextSize(@label\GetText!) + 10
        for roundPlayer in *dmglog.highlightedPlayers
            with ply = vgui.Create('DamagelogHighlightedPlayer', self)
                \SetRoundPlayer(roundPlayer)
                \SetPos(x, 8)
                x += \GetWide! + 5
                table.insert(@panels, ply)

    ClearPanels: () =>
        for panel in *@panels
            panel\Remove!
        table.Empty(@panels)    

    OnRoundLoad: () =>
        @ClearPanels!
        table.Empty(dmglog.highlightedPlayers)

        roundPlayers = dmglog.currentRoundEvents.roundPlayers
        @playerChoices\Clear!
        @playerChoices\SetEnabled(true)
        for roundPlayer in *roundPlayers.list
            @playerChoices\AddChoice(roundPlayer.name, roundPlayer, roundPlayer == roundPlayers.list[1])

vgui.Register('DamagelogHighlightPanel', PANEL, 'DPanel')