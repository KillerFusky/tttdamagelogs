PANEL =

    Init: () =>
        @AddColumn(dmglog.GetTranslation('listview_time'))\SetFixedWidth(40)
        @AddColumn(dmglog.GetTranslation('listview_type'))\SetFixedWidth(40)
        @AddColumn(dmglog.GetTranslation('listview_event'))\SetFixedWidth(529)
        @AddColumn('')\SetFixedWidth(30)

    DisplayRoundEvents: (roundEvents) =>
        @roundEvents = roundEvents
        @Update!

    Update: () =>
        if not @roundEvents return
        @Clear!
        roundPlayers = @roundEvents.roundPlayers
        for roundEvent in *@roundEvents.eventsList
            displayedRoundTime = string.FormattedTime(roundEvent.roundTime, "%02i:%02i")
            displayedType = roundEvent.displayedType
            text = roundEvent\ToString(roundPlayers)
            if not roundEvent\ShouldBeDisplayed(text, roundPlayers) continue
            color = roundEvent\GetColor(roundPlayers)
            with line = @AddLine(displayedRoundTime, displayedType, text)
                .PaintOver = (line, w, h) ->
                    column\SetTextColor(color) for column in *line.Columns

vgui.Register('DamagelogListView', PANEL, 'DListView')