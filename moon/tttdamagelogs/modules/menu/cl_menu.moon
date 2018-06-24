
key = KEY_F8

dmglog.OpenMenu = () ->
    dmglog.Menu = vgui.Create('DamagelogMenu')

concommand.Add 'damagelog', () -> 
    dmglog.OpenMenu!

pressedOpenKey = false
hook.Add 'Think', 'TTTDamagelogs_KeyOpen', () ->
    isKeyDown = input.IsKeyDown(key)
    if isKeyDown and not pressedOpenKey
        pressedOpenKey = true
        if not IsValid(dmglog.Menu)
            dmglog.OpenMenu!
        else
            dmglog.Menu\Close!
    elseif pressedOpenKey and not isKeyDown
        pressedOpenKey = false