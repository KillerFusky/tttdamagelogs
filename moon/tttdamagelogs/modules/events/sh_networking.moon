askRoundsEvent = dmglog.net.AddNetworkString('AskRoundEvents')

if SERVER

    dmglog.net.ReceiveAsync askRoundsEvent, (length, ply) ->
        roundNumber = net.ReadUInt(8)
        roundEvents = dmglog.eventsHandler.roundEvents[roundNumber]
        if roundEvents
            return () ->
                roundEvents\Send!

if CLIENT

    dmglog.AskRoundEvents = (roundNumber) ->
        return Promise async (resolve, reject) ->
            net.Start(askRoundsEvent)
            net.WriteUInt(roundNumber, 8)
            result = await dmglog.net.SendAsync()
            roundEvents = dmglog.RoundEvents.Read!
            resolve(roundEvents)