SaveRound = (roundEvents) ->
    print('round save')
    tbl = roundEvents\ToTable!
    encodedTbl = util.TableToJSON(tbl)
    print(encodedTbl)
    with query = dmglog.db\prepare('CALL add_old_logs(?)')
        \setString(1, encodedTbl)
        \start!

hook.Add 'TTTEndRound', 'TTTDamagelogs_OldLogs', () ->
    print('end round hook')
    currentRound = dmglog.eventsHandler\GetCurrentRound!
    SaveRound(currentRound)