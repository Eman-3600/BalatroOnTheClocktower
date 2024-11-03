local blind = {
    name = "The Seat",
    key = "seat",
    atlas = "atlasclockbosses",
    pos = {x = 0, y = 16},
    boss = {min = 3, max = 10},
    boss_colour = HEX('8c6240'),
    loc_txt = {
        name ="The Seat",
        text={
            "Enhanced cards",
            "are drawn last",
        },
    },
}

blind.in_pool = function (self)

    if G.playing_cards and (self.boss.min <= math.max(1, G.GAME.round_resets.ante)) then
    
        for k, v in pairs(G.playing_cards) do
            if v.config.center ~= G.P_CENTERS.c_base then return true end
        end
    end

    return false
end

blind.eman_rig_shuffle = function (self, seed)

    local first = {}
    local after = {}

    for i = #G.deck.cards, 1, -1 do
        local card = table.remove(G.deck.cards, i)

        if card.config.center == G.P_CENTERS.c_base then
            table.insert(first, card)
        else
            table.insert(after, card)
        end
    end

    pseudoshuffle(first, pseudoseed(seed.."_first"))
    pseudoshuffle(after, pseudoseed(seed.."_after"))

    for _, v in ipairs(after) do
        table.insert(G.deck.cards, v)
    end

    for _, v in ipairs(first) do
        table.insert(G.deck.cards, v)
    end
end



return blind