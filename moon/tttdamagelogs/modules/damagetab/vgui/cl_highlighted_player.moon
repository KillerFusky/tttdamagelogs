PANEL =

    CreateCloseButton: () =>
        with @close = vgui.Create('TipsButton', self)
            do
                .colors =
                    default: COLOR_LGRAY
                    hover: Color(0, 100, 200)
                    press: COLOR_BLUE
            do
                \SetPos(@wText + 10, 2)
                \SetSize(13, 13)
                \SetText('')
            do
                .PaintOver = (w, h) =>
                    surface.SetFont('DermaDefault')
                    xw, yw = surface.GetTextSize('X')
                    surface.SetTextPos(w / 2 - xw / 2 + 1, h / 2 - yw / 2)
                    surface.DrawText('X')
            do
                .DoClick = (close) ->
                    dmglog.highlightedPlayers[@roundPlayer] = nil
                    @GetParent!\CreatePanels!

    Paint: (w, h) =>
        if not @text then return
        do
            surface.SetDrawColor(Color(242, 242, 242))
            surface.DrawRect(0, 0, w, h)
        do
            surface.SetDrawColor(Color(0, 50, 200))
            surface.DrawLine(0, 0, w - 1, 0)
            surface.DrawLine(w - 1, 0, w - 1, h - 1)
            surface.DrawLine(w - 1, h - 1, 0, h - 1)
            surface.DrawLine(0, h - 1, 0, 0)
        do
            surface.SetFont("DL_Highlight")
            surface.SetTextColor(color_black)
            surface.SetTextPos(3, 1)
            surface.DrawText(@text)

    Resize: () =>
        surface.SetFont('DL_Highlight')
        @wText, @hText = surface.GetTextSize(@text)
        @SetSize(@wText + 25, @hText + 4)

    SetRoundPlayer: (roundPlayer) =>
        @roundPlayer = roundPlayer
        @text = @roundPlayer.name
        @Resize!
        @CreateCloseButton!

vgui.Register('DamagelogHighlightedPlayer', PANEL, 'DPanel')