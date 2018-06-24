CreateGui = (tabs) ->
    

hook.Add 'TTTDamagelogsMenuOpen', 'TTTDamagelogs_DamageTab', (tabs) ->

    damageTab = vgui.Create('DListLayout')
    damageTab.Paint = (w, h) =>
        surface.SetDrawColor(Color(234, 234, 234))
        surface.DrawRect(1, 1, w - 2, h - 2)

    selectionPanel = damageTab\Add('DamagelogSelectionPanel')
    
    viewTabs = damageTab\Add('DamagelogViewTabs')
    viewTabs\SetHeight(450)
    viewTabs\Resize!

    LoadRound = (round) ->
        dmglog.AskRoundEvents round, (roundEvents) ->
            --damagelogListView\DisplayRoundEvents(roundEvents)
            selectionPanel.roles\SetRoundNumber(round)
            selectionPanel.roles\SetRoundPlayers(roundEvents.roundPlayers)

    damageTab.OnSelectedRoundChanged = LoadRound

    tabs\AddSheet(dmglog.GetTranslation('damagelog_tab_title'), damageTab, 'icon16/application_view_detail.png')

    LoadRound(dmglog.roundsCount) 