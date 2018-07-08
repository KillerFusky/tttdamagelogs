class dmglog.RoundPlayers

    new: (list = false) =>
        @list = list or {}

    InitializeWithCurrentPlayers: () =>
        table.Empty(@list)
        for ply in *player.GetAll!
            @AddPlayer(ply)

    AddPlayer: (ply) =>
        roundPlayer = dmglog.RoundPlayer.Create(ply)
        id = table.insert(@list, roundPlayer)
        roundPlayer\SetId(id)

    GetPlayerId: (ply) =>
        steamId = ply\SteamID!
        name = ply\Name!
        predicate = (roundPlayer) -> roundPlayer.steamId == steamId and (steamId != 'BOT' or roundPlayer.name == name)
        return dmglog.table.FindKey(@list, predicate) or false

    GetById: (id) => @list[id]

    Send: () =>
        net.WriteUInt(#@list, 16)
        for roundPlayer in *@list
            roundPlayer\Send!

    UpdateForRoundBegin: () =>
        for roundPlayer in *@list
            ply = player.GetBySteamID(roundPlayer.steamId)
            if IsValid(ply) and ply\IsActive!
                roundPlayer.role = ply\GetRole!
                roundPlayer.onlyPlayedPreparation = false

    @Read: () ->
        list = {}
        for i = 1, net.ReadUInt(16)
            roundPlayer = dmglog.RoundPlayer.Read!
            table.insert(list, roundPlayer)
        return dmglog.RoundPlayers(list)